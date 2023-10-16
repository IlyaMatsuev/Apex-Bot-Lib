public class MusicServiceSettingsProvider {
    private static final Integer SETTING_QUERY_LIMIT = 50;

    private static final Map<MusicServiceType, MusicServiceSetting__mdt> settings = new Map<MusicServiceType, MusicServiceSetting__mdt>();

    private MusicServiceSettingsProvider() {}

    static {
        initSettings();
    }

    public static MusicServiceSetting__mdt get(MusicServiceType type) {
        if (!settings.containsKey(type)) {
            throw new IllegalArgumentException('No setting exists for the ' + type + ' music service type');
        }
        return settings.get(type);
    }

    public static List<MusicServiceSetting__mdt> getAll() {
        return settings.values();
    }

    private static void initSettings() {
        List<MusicServiceSetting__mdt> allSettings = [
            SELECT DeveloperName, ApiUrl__c, AuthorizationApiUrl__c, ShareLinkUrl__c, Service__c, TrackRecognizer__c
            FROM MusicServiceSetting__mdt
            LIMIT :SETTING_QUERY_LIMIT
        ];
        for (MusicServiceSetting__mdt setting : allSettings) {
            settings.put(MusicServiceType.valueOf(setting.DeveloperName), setting);
        }
    }
}
