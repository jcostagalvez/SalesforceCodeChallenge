public with sharing class CAP_Mock_Service {
    public static HttpResponse getInfoFromExternalService(String setEndpoint) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(setEndpoint);
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        return res;
    }
}
