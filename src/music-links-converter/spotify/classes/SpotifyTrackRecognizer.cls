public class SpotifyTrackRecognizer implements ITrackRecognizer {
    public String recognize(String url) {
        SpotifyService service = new SpotifyService();
        String trackId = url.substringAfter('/track/').substringBefore('?');
        SpotifyTrack track = service.getTrackById(trackId);
        return track.mainArtist.name + ' - ' + track.name;
    }
}
