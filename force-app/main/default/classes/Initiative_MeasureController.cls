/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Initiative_Measure Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 12-12-2016       | Vivian Charlie   | 1. Created class to implement functionality of Initiative_Measure Page
   ==========================================================================================================================
*/
public class Initiative_MeasureController{

    public Initiative_MeasureController(ApexPages.StandardController controller) {

    }
 
    public  String initID {get; set;}
    public List<Measure__c> measureList{get;set;}
    
    public ApexPages.StandardSetController stdSetController 
    {                                
        get {
        list<user> lstUsr = [SELECT Id,
                                    ContactID,
                                    contact.accountId 
                             FROM User 
                             WHERE id=: UserInfo.getUserId()];
        if(lstUsr != null && !lstUsr.isEmpty()) {
        measureList = new List<Measure__c>();
        initID =  ApexPages.currentPage().getParameters().get('id');
            measureList =  [SELECT Name,
                                   Baseline_Text__c,
                                   Baseline_Date__c,
                                   Target_Text__c,
                                   Target_Date__c,
                                   Result_Rich_Text__c,
                                   Result_Date__c,
                                   Status__c,
                                   Result_Achieved_Icon__c,
                                   Partner__c
                            FROM Measure__c
                            WHERE Initiative__c =: initID AND Reporting_Type__c = 'Written' AND Partner__c=:lstUsr[0].contact.accountId ORDER BY Target_Date__c];
        }
        system.debug('measureList'+measureList); 
            if(stdSetController == null) {
                stdSetController = new ApexPages.StandardSetController(measureList);
                stdSetController.setPageSize(5);
            }
            return stdSetController;
        }
        set;       
    }
    
    public List<Measure__c> getMeasures() {
        List<Measure__c> measures = new list<Measure__c>();
        measures = stdSetController.getRecords();
        system.debug('measures '+measures);
        return measures;
    }
    
    public Boolean hasNext1 {
        get {
            return stdSetController.getHasNext();
        }
        set;
    }

    public Boolean hasPrevious1 {
        get {
            return stdSetController.getHasPrevious();
        }
        set;
    }

    public void first1() {
        stdSetController.first();
    }

    public void last1() {
        stdSetController.last();
    }

    public void previous1() {
        stdSetController.previous();
    }

    public void next1() {
        stdSetController.next();
    }
}