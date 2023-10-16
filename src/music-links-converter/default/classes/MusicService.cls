public abstract class MusicService {
    protected final MusicServiceType serviceType;
    protected MusicServiceSetting__mdt settings { get { return MusicServiceSettingsProvider.get(serviceType); } }

    protected MusicService(MusicServiceType serviceType) {
        this.serviceType = serviceType;
    }

    protected BotJsonPayload get(String uri) {
        return get(uri, new BotJsonPayload());
    }

    protected BotJsonPayload get(String uri, BotJsonPayload payload) {
        String method = 'GET';
        String endpoint = settings.ApiUrl__c + uri + '?' + String.join(parseParamsPair(payload), '&');
        String tokenCacheKey = serviceType.name().capitalize() + 'AccessToken';
        try {
            return call(prepareRequest(method, endpoint, (String) Cache.Org.get(tokenCacheKey)));
        } catch (MusicServiceException ex) {
            if (ex.payload.getJsonPayload('response').getInteger('statusCode') == 401) {
                String newToken = authorize();
                Cache.Org.put(tokenCacheKey, newToken);
                return call(prepareRequest(method, endpoint, newToken));
            }
            throw ex;
        }
    }

    // TODO: Make it more generic and not specific on Spotify
    private String authorize() {
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint(settings.AuthorizationApiUrl__c);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');

        MusicServiceSecrets__c secrets = MusicServiceSecrets__c.getInstance(serviceType.name().capitalize());
        BotJsonPayload params = new BotJsonPayload()
            .set('grant_type', 'client_credentials')
            .set('client_id', secrets.AuthorizationClientId__c)
            .set('client_secret', secrets.AuthorizationClientSecret__c);

        request.setBody(String.join(parseParamsPair(params), '&'));
        return call(request).getString('access_token');
    }

    private HttpRequest prepareRequest(String method, String endpoint, String token) {
        HttpRequest request = new HttpRequest();
        request.setMethod(method);
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setEndpoint(endpoint);
        return request;
    }

    private BotJsonPayload call(HttpRequest request) {
        HttpResponse response = new Http().send(request);
        BotJsonPayload responsePayload = BotJsonPayload.fromJson(response.getBody());

        if (response.getStatusCode() != 200) {
            throw new MusicServiceException(
                'A call failed for the music service "' +
                    serviceType.name().capitalize() +
                    '" and URL "' +
                    request.getEndpoint() +
                    '" with status: ' +
                    response.getStatus(),
                new BotJsonPayload()
                    .set('request', new BotJsonPayload().set('body', request.getBody()))
                    .set(
                        'response',
                        new BotJsonPayload().set('body', responsePayload).set('statusCode', response.getStatusCode())
                    )
            );
        }
        return BotJsonPayload.fromJson(response.getBody());
    }

    private List<String> parseParamsPair(BotJsonPayload params) {
        List<String> paramsPairs = new List<String>();
        for (String param : params.getValues().keySet()) {
            paramsPairs.add(param + '=' + params.get(param));
        }
        return paramsPairs;
    }

    public class MusicServiceException extends BotCustomException {
        public MusicServiceException(String message, BotJsonPayload payload) {
            super(message, payload);
        }
    }
}
