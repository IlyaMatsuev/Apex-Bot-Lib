public with sharing class MusicLinkConverterBotHandler extends TelegramBotHandler {
    private final MusicLinksConverterBotServiceFactory converterServiceFactory {
        get {
            if (converterServiceFactory == null) {
                converterServiceFactory = new MusicLinksConverterBotServiceFactory();
            }
            return converterServiceFactory;
        }
        set;
    }

    public override void onMessageReceived(TelegramBotContext context, TelegramMessageEvent event) {
        context.reply().text('I\'m not able to reply to regular messages yet');
    }

    public override void onInlineQuery(TelegramBotContext context, TelegramInlineQueryEvent event) {
        ConvertLinkQuery query = ConvertLinkQuery.parse(event.query);
        if (!query.isValid) {
            return;
        }

        String fullTrackName = recognizeTrack(query.originalTrackUrl);
        context.getService().inlineQuery(event.id).answer(getInlineQueryResults(fullTrackName));
    }

    private String recognizeTrack(String link) {
        ITrackRecognizer recognizer = converterServiceFactory.createTrackRecognizer(link);
        return recognizer.recognize(link).replaceAll('\\s', '+');
    }

    private List<TelegramInlineQueryResult> getInlineQueryResults(String trackName) {
        return new List<TelegramInlineQueryResult> { getSpotifyResult(trackName), getAppleMusicResult(trackName) };
    }

    private TelegramInlineQueryResult getSpotifyResult(String trackName) {
        SpotifyService service = (SpotifyService) converterServiceFactory.createMusicServiceService(
            MusicServiceType.Spotify
        );
        SpotifyTrack track = service.searchTracks(trackName, 1).get(0);
        return new TelegramInlineQueryResultArticle(MusicServiceType.Spotify.name())
            .withTitle('Spotify')
            .withDescription('Converts the provided link to a Spotify track link')
            .withThumbnail('https://upload.wikimedia.org/wikipedia/commons/7/74/Spotify_App_Logo.svg')
            .withInputMessage(new TelegramInputTextMessageContent(track.externalUrl));
    }

    private TelegramInlineQueryResult getAppleMusicResult(String trackName) {
        String songLink = 'some link here';
        return new TelegramInlineQueryResultArticle('apple')
            .withTitle('Apple Music')
            .withDescription('Converts the provided link to a Apple Music song link')
            .withThumbnail('https://assets.stickpng.com/thumbs/60394fc7b6264f0004079c1b.png')
            .withInputMessage(new TelegramInputTextMessageContent(songLink));
    }
}
