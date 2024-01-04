trigger TrgApplicationRound on Application_Round__c (after update) {
    
    if(Trigger.IsAfter && Trigger.isUpdate){
        ApplicationRoundTriggerHandler.createAssessmentRecords(Trigger.new); 
    }
}