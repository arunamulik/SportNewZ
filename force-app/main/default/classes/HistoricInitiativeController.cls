/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to implement functionality of Historic Reporting Page

=========================================================================================================================
Version | Date(DD-MM-YYYY) | Last Modified By | Comments
-------------------------------------------------------------------------------------------------------------------------
1.0     | 11-03-2022       | Aruna Mulik   | 1. Controller Historic Reporting Page
==========================================================================================================================
*/

public class HistoricInitiativeController {
    public List<Initiative__c> AllRecords {get;set;}
    public ApexPages.StandardSetController stdSetController 
    {                                
        get {
            list<user> lstUsr = [SELECT Id,
                                 ContactID,
                                 contact.accountId 
                                 FROM User 
                                 WHERE id=: UserInfo.getUserId()];
            if(lstUsr != null && !lstUsr.isEmpty()) {   
                
                AllRecords = [SELECT Id, 
                              Name, 
                              Partner__c,
                              Start_Date__c,
                              End_Date__c,
                              Description__c,
                              (Select Reporting_Type__c,Initiative__c From Requirements__r where Status__c ='Completed'  and Requirement_Reporting_Record_Type__c != NULL)
                              FROM Initiative__c
                              WHERE Partner__c=:lstUsr[0].contact.accountId];
            }
            //RUL Updated ends 18 March 2019
            set<Id> initIds = new set<Id>();
            list<Initiative__c> lstInit = new list<Initiative__c>();
            for(Initiative__c initObj: AllRecords) {
                if(initObj.Requirements__r != NULL){          
                    for (Requirement__c reqObj : initObj.Requirements__r) {
                        initIds.add(reqObj.Initiative__c);                
                    }
                }
                                 
            }
            
            List<Requirement__c> reqList = new List<Requirement__c>();
            List<Requirement__c> requirementList1 = [SELECT	Id, 
                                                    		Initiative__r.name, 
                                                    		Description__c, 
                                                    		Initiative__r.Id, 
                                                    		Initiative__r.Partner__c,
                        									Name, 
                                                    		Due_Date__c,
                                                    		Status__c, Requirement_Reporting_Record_Type__c  
                                                    from 	Requirement__c
                                                    WHERE 	Initiative__r.Partner__c=:lstUsr[0].contact.accountId
                                                    AND 	Initiative__r.Id IN :initIds 
                                                    AND		Status__c ='Completed'
                                                    AND 	Requirement_Reporting_Record_Type__c!=NULL
                                                    Order by Due_Date__c DESC];
            
            if(stdSetController == null) {
                for(Requirement__c req : requirementList1) {
                    reqList.add(req);
                }
                stdSetController = new ApexPages.StandardSetController(reqList);
                stdSetController.setPageSize(20);
            }
            return stdSetController;
        }
        set;       
    }
    
    public List<Requirement__c> getInitiatives() {
        return (List<Requirement__c>) stdSetController.getRecords();
    }
    
    public Boolean hasNext {
        get {
            return stdSetController.getHasNext();
        }
        set;
    }
    
    public Boolean hasPrevious {
        get {
            return stdSetController.getHasPrevious();
        }
        set;
    }   
    
    public void first() {
        stdSetController.first();
    }
    
    public void last() {
        stdSetController.last();
    }
    
    public void previous() {
        stdSetController.previous();
    }
    
    public void next() {
        stdSetController.next();
    }
}