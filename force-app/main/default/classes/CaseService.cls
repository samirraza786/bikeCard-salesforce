public with sharing class CaseService {
    public static Case createCase(Id accountId, String subject) {
        Case newCase = new Case(
            AccountId = accountId,
            Subject = subject,
            Status = 'New'
        );
        insert newCase;
        return newCase;
    }
}