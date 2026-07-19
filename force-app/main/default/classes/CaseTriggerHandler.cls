public with sharing class CaseTriggerHandler {
    public static void handleAfterInsertUpdate(List<Case> newCases, Map<Id, Case> oldMap) {
        Set<Id> caseIdsToSync = new Set<Id>();

        for (Case c : newCases) {
            Boolean isNew = (oldMap == null);
            Boolean statusChanged = !isNew && oldMap.get(c.Id).Status != c.Status;

            if (isNew || statusChanged) {
                caseIdsToSync.add(c.Id);
            }
        }

        if (!caseIdsToSync.isEmpty()) {
            System.enqueueJob(new CaseSyncQueueable(new List<Id>(caseIdsToSync)));
        }
    }
}