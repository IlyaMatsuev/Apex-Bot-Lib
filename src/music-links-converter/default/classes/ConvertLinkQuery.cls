public class ConvertLinkQuery {
    public final Boolean isValid;
    public final String originalTrackUrl;
    public final String convertServiceType;

    public ConvertLinkQuery(Boolean isValid) {
        this(false, '', '');
    }

    public ConvertLinkQuery(Boolean isValid, String originalTrackUrl, String convertToServiceType) {
        this.isValid = isValid;
        this.originalTrackUrl = originalTrackUrl;
        this.convertServiceType = convertToServiceType;
    }

    public static ConvertLinkQuery parse(String query) {
        if (String.isBlank(query)) {
            return new ConvertLinkQuery(false);
        }
        Matcher queryMatcher = Pattern.compile(buildQueryRegex()).matcher(query);
        if (!queryMatcher.matches()) {
            return new ConvertLinkQuery(false);
        }
        return new ConvertLinkQuery(true, queryMatcher.group(1), queryMatcher.group(4));
    }

    private static String buildQueryRegex() {
        List<String> shareLinkPatterns = new List<String>();
        for (MusicServiceSetting__mdt settings : MusicServiceSettingsProvider.getAll()) {
            String normalizedShareLink = settings.ShareLinkUrl__c.replaceAll('/', '\\/').replaceAll('.', '\\.');
            shareLinkPatterns.add(normalizedShareLink + '\\/.+');
        }
        List<String> musicServices = new List<String>();
        for (MusicServiceType musicService : MusicServiceType.values()) {
            musicServices.add(musicService.name());
        }
        return '^@\\w+\\s+((' +
            String.join(shareLinkPatterns, ')|(') +
            '))\\s+((' +
            String.join(musicServices, ')|(') +
            '))$';
    }
}
