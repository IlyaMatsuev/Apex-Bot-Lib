public class SpotifyTrack extends SpotifyEntity {
    public SpotifyArtist mainArtist { get { return artists.get(0); } }

    public List<SpotifyArtist> artists {
        get {
            if (artists == null) {
                artists = new List<SpotifyArtist>();
                List<BotJsonPayload> payloadList = payload.getJsonPayloadList('artists');
                if (payloadList != null) {
                    for (BotJsonPayload payload : payloadList) {
                        artists.add(new SpotifyArtist(payload));
                    }
                }
            }
            return artists;
        }
        private set;
    }

    public String externalUrl {
        get {
            if (externalUrl == null) {
                externalUrl = payload.getJsonPayload('external_urls').getString(MusicServiceType.Spotify.name());
            }
            return externalUrl;
        }
        private set;
    }

    public SpotifyTrack(BotJsonPayload payload) {
        super(payload);
    }
}
