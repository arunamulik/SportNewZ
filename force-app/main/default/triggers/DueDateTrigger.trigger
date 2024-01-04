trigger DueDateTrigger on Activity__c (before insert) {
    
    if (trigger.isBefore ){
        DueDateHandler.DueDateMethod(trigger.new);
    }
}