/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Initiative_Requirement Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 12-12-2016       | Vivian Charlie   | 1. Created class to implement functionality of Initiative_Requirement Page
   ==========================================================================================================================
*/
public class Initiative_RequirementController{

    public Initiative_RequirementController(ApexPages.StandardController controller) {

    }
 
    public  String initID {get; set;}
    public List<Requirement__c> reqList{get;set;}
    
    public ApexPages.StandardSetController stdSetController 
    {                                
        get {
        list<user> lstUsr = [SELECT Id,
                                    ContactID,
                                    contact.accountId 
                             FROM User 
                             WHERE id=: UserInfo.getUserId()];
        if(lstUsr != null && !lstUsr.isEmpty()) {
        reqList = new List<Requirement__c>();
        initID =  ApexPages.currentPage().getParameters().get('id');
            reqList =  [SELECT Requirement_ID__c ,
                               Name,
                               Description__c,
                               Due_Date__c,
                               Status__c,
                               Status_Image__c,
                               Partner__c,
                               Plan__c,
                               Reporting_Type__c
                        FROM Requirement__c
                        WHERE Initiative__c =: initID AND Reporting_Type__c = 'Written' AND Partner__c=:lstUsr[0].contact.accountId ORDER BY Due_Date__c];
        }
          
            if(stdSetController == null) {
                stdSetController = new ApexPages.StandardSetController(reqList);
                stdSetController.setPageSize(5);
            }
            return stdSetController;
        }
        set;       
    }
    
    public List<Requirement__c> getRequirements() {
        List<Requirement__c> requirements = new list<Requirement__c>();
        requirements = stdSetController.getRecords();
        return requirements;
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