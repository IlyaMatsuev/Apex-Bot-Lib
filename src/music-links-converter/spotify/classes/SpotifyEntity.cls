public abstract class SpotifyEntity extends BotPayload {
    public String id { get { return payload.getString('id'); } }
    public String name { get { return payload.getString('name'); } }

    protected SpotifyEntity(BotJsonPayload payload) {
        super(payload);
    }

    public static SpotifyEntity fromPayload(BotJsonPayload payload) {
        String type = payload.getString('type');
        if (type == 'track') {
            return new SpotifyTrack(payload);
        } else if (type == 'artist') {
            return new SpotifyArtist(payload);
        }
        throw new SpotifyEntityException('Payload type was not recognized: ' + type, payload);
    }

    public class SpotifyEntityException extends BotCustomException {
        public SpotifyEntityException(String message, BotJsonPayload payload) {
            super(message, payload);
        }
    }
}
