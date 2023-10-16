public class MusicServiceType extends BotEnumType {
    public static final MusicServiceType Spotify = new MusicServiceType('spotify');
    public static final MusicServiceType AppleMusic = new MusicServiceType('apple');

    public MusicServiceType(String value) {
        super(value, MusicServiceType.class);
    }

    public static MusicServiceType valueOf(String value) {
        return (MusicServiceType) BotEnumType.valueOf(value?.toLowerCase(), MusicServiceType.class);
    }

    public static List<MusicServiceType> values() {
        return new List<MusicServiceType> { Spotify, AppleMusic };
    }
}
