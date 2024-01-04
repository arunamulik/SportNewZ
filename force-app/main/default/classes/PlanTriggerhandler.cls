public with sharing class PlanTriggerhandler {

    public static void UpdateInitiativeFields(List<Plan__c> planlst){
         system.debug('Inside PlanTriggerhandler UpdateInitiativeFields() method');

        List<Initiative__c> updatedInitLst = new List<Initiative__c>();

        for (Initiative__c init : [SELECT Id, Partner__c, Investment_Area__c, Plan__r.Partner__c, Plan__r.Investment_Area__c, Plan__r.RecordType.DeveloperName FROM Initiative__c WHERE Plan__r.Id IN : planlst]) {
            if (init.Plan__r.RecordType.DeveloperName == 'Partner_Plan' && (init.Partner__c != init.Plan__r.Partner__c)) {
                init.Partner__c = init.Plan__r.Partner__c;
                updatedInitLst.add(init);
            }
            else if (init.Plan__r.RecordType.DeveloperName == 'Bundled_Plan' && (init.Investment_Area__c != init.Plan__r.Investment_Area__c)) {
                init.Investment_Area__c = init.Plan__r.Investment_Area__c;
                updatedInitLst.add(init);
            }                       
        }
        
        if(!updatedInitLst.IsEmpty()) { 
            update updatedInitLst;
        }
    }
}