public class MusicLinksConverterBotServiceFactory {
    public MusicService createMusicServiceService(MusicServiceType type) {
        return (MusicService) BotUtils.createInstance(MusicServiceSettingsProvider.get(type).Service__c);
    }

    public ITrackRecognizer createTrackRecognizer(String trackUrl) {
        for (MusicServiceSetting__mdt settings : MusicServiceSettingsProvider.getAll()) {
            if (trackUrl.startsWith(settings.ShareLinkUrl__c)) {
                return (ITrackRecognizer) BotUtils.createInstance(settings.TrackRecognizer__c);
            }
        }
        throw new ImplementationNotFoundException(
            'Track Recognizer implementation was not found',
            new BotJsonPayload().set('trackUrl', trackUrl)
        );
    }

    public class ImplementationNotFoundException extends BotCustomException {
        public ImplementationNotFoundException(String message, BotJsonPayload payload) {
            super(message, payload);
        }
    }
}
