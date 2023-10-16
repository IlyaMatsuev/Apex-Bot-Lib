public class SpotifyService extends MusicService {
    public SpotifyService() {
        super(MusicServiceType.Spotify);
    }

    public SpotifyTrack getTrackById(String id) {
        return new SpotifyTrack(get('/tracks/' + id));
    }

    public List<SpotifyTrack> searchTracks(String searchQuery) {
        return searchTracks(searchQuery, 5);
    }

    public List<SpotifyTrack> searchTracks(String searchQuery, Integer resultsLimit) {
        BotJsonPayload searchParams = new BotJsonPayload()
            .set('q', searchQuery)
            .set('type', 'track')
            .set('limit', resultsLimit);

        BotJsonPayload result = get('/search', searchParams).getJsonPayload('tracks');
        List<SpotifyTrack> tracks = new List<SpotifyTrack>();
        for (BotJsonPayload item : result.getJsonPayloadList('items')) {
            tracks.add(new SpotifyTrack(item));
        }
        return tracks;
    }
}
