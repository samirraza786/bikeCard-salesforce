public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(Id accountId) {
        return CaseSelector.selectByAccountId(accountId);
    }

    @AuraEnabled
    public static void saveCase(Id accountId, String subject) {
        try {
            CaseService.createCase(accountId, subject);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}