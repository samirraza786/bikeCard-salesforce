public with sharing class CaseCalloutService {
    public static void syncCaseToExternal(Case c) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:JSONPlaceholder/posts');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(new Map<String, Object>{
            'caseId' => c.Id,
            'subject' => c.Subject,
            'status' => c.Status
        }));
        req.setTimeout(10000);

        try {
            Http http = new Http();
            HttpResponse res = http.send(req);
            if (res.getStatusCode() != 201) {
                System.debug('Sync failed for Case ' + c.Id + ': ' + res.getStatus());
            } else {
                System.debug('Sync succeeded: ' + res.getBody());
            }
        } catch (Exception e) {
            System.debug('Callout exception for Case ' + c.Id + ': ' + e.getMessage());
        }
    }
}