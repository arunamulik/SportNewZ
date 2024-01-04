/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of PerformanceRepEventData Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 30-11-2016       | Vivian Charlie   | 1. Created class to implement functionality of PerformanceRepEventData Page
   ==========================================================================================================================
*/
public class PerformanceRepEventDataController{
    public Performance_Representative_Event_Data__c perRepEventData {get;set;}
    
    public PerformanceRepEventDataController(){
        Id parentId = ApexPages.currentPage().getParameters().get('id');
        perRepEventData  = new Performance_Representative_Event_Data__c();
        perRepEventData.Performance_Representative__c = parentId;
    }
    
    public PageReference save()
    {      
        try {
            upsert perRepEventData ;
        } catch(exception e) {
            ApexPages.addMessages(e);          
        }
        return new PageReference('/' + perRepEventData.id);
    }
    
    public Pagereference cancel(){
        PageReference newpage = new Pagereference('/' + perRepEventData.Performance_Representative__c);
        newpage.setRedirect(true);
        return newpage;
    }
}