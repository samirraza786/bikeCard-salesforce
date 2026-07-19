public with sharing class CaseSelector {
    public static List<Case> selectByAccountId(Id accountId) {
        return [
            SELECT Id, Subject, Status, CreatedDate
            FROM Case
            WHERE AccountId = :accountId
            ORDER BY CreatedDate DESC
        ];
    }

    public static List<Case> selectByIds(List<Id> caseIds) {
        return [SELECT Id, Subject, Status FROM Case WHERE Id IN :caseIds];
    }
}