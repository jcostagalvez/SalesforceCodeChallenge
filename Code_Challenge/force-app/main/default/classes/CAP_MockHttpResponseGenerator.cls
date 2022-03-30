global with sharing class CAP_MockHttpResponseGenerator implements HttpCalloutMock{
    Public String url = 'http://api.example.com/';
    Public String urlAccounts = 'https://api.example/accounts/';

    global HTTPResponse respond(HTTPRequest req) {
        
        
        // Create a fake response
        if(req.getEndpoint() == url + '/salesforce/oauth/token'){
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(200);
            return res;
        }else{
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"accountStatus" : "enabled","transactionDetails": {"properties":{"resourceId": "cb880508-78e9-11ea-bc55-0242ac130003","name": "Supermarket","balanceType": "expected","amount":{"currency":"EUR","amount":"5877.78"},"transactionDate": "2020-04-25T15:30:35.035Z"}},"accountTransactionList":[{"iban":"ES4700759339324669344918","amount":{"currency":"EUR","amount":"5877.78"},"currencyCode":"EUR","transactionDate":"2020-04-25T15:30:35.035Z","amountValue":"5877.78","product": "current"}]}');
            res.setStatusCode(200);
            return res;
        }
    }
}
