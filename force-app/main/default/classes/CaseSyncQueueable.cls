public with sharing class CaseSyncQueueable implements Queueable, Database.AllowsCallouts {
    private List<Id> caseIds;
    private static final Integer BATCH_SIZE = 50;

    public CaseSyncQueueable(List<Id> caseIds) {
        this.caseIds = caseIds;
    }

    public void execute(QueueableContext context) {
        List<Id> currentBatch = new List<Id>();
        List<Id> remaining = new List<Id>();

        for (Integer i = 0; i < caseIds.size(); i++) {
            if (i < BATCH_SIZE) {
                currentBatch.add(caseIds[i]);
            } else {
                remaining.add(caseIds[i]);
            }
        }

        List<Case> cases = CaseSelector.selectByIds(currentBatch);
        for (Case c : cases) {
            CaseCalloutService.syncCaseToExternal(c);
        }

        if (!remaining.isEmpty() && !Test.isRunningTest()) {
            System.enqueueJob(new CaseSyncQueueable(remaining));
        }
    }
}