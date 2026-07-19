trigger CaseTrigger on Case (after insert, after update) {
    CaseTriggerHandler.handleAfterInsertUpdate(Trigger.new, Trigger.oldMap);
}