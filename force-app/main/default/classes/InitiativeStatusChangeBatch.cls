/*
*@ Author       :- Navneet Rajput 
*@ Company      :- Davanti
*@ Date         :- 03/07/2015
*@ Description  :- This batch will execute once in a day and it will check status field of Initiative. If status field of initiative is
                    not same as Status_Text of initiatve then it will update Status_Text with Status field.     
*@ History      :- 
*/


global class InitiativeStatusChangeBatch implements Database.Batchable<sObject>{

    global Database.querylocator start(Database.BatchableContext BC){
            
            DateTime lastDay = System.now().addDays(-1);
            
            return Database.getQueryLocator([SELECT ID,
                                                    Status__c,
                                                    Status_Text__c
                                             FROM   Initiative__c
                                             WHERE  Update_Status_text__c=TRUE]);
                                             
    }

    
    global void execute(Database.BatchableContext BC, List<Initiative__c> listOfInitiative){
        
        Savepoint savePt = Database.setSavepoint();
        try {
            List<Initiative__c> tempInitiativeLst = new List<Initiative__c>();
            for (Initiative__c initiative : listOfInitiative){
                if(initiative.Status__c <> initiative.Status_Text__c){
                    initiative.Status_Text__c = initiative.Status__c;
                    tempInitiativeLst.add(initiative);
                }
            }
            if (tempInitiativeLst<>NULL && !tempInitiativeLst.isEmpty()){
                update tempInitiativeLst;
            }
            
        } catch (System.DmlException e) {
            System.debug('Exception Is ' + e.getMessage());
            Database.rollback(savePt);
        } 
    }
        
    global void finish(Database.BatchableContext BC){
        
    }
    
}