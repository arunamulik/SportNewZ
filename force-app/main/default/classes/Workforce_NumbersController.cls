/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Workforce_Numbers Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 30-11-2016       | Vivian Charlie   | 1. Created class to implement functionality of Workforce_Numbers Page
   ==========================================================================================================================
*/
public class Workforce_NumbersController{
    public Workforce_Numbers__c newWorkforceNo {get;set;}
    
    public Workforce_NumbersController(){
        Id parentId = ApexPages.currentPage().getParameters().get('id');
        newWorkforceNo  = new Workforce_Numbers__c();
        newWorkforceNo.Workforce_Category__c = parentId;
    }
    
    public PageReference save()
    {      
        try {
            upsert newWorkforceNo ;
        } catch(exception e) {
            ApexPages.addMessages(e);          
        }
        return new PageReference('/' + newWorkforceNo.id);
    }
    
    public Pagereference cancel(){
        PageReference newpage = new Pagereference('/' + newWorkforceNo.Workforce_Category__c);
        newpage.setRedirect(true);
        return newpage;
    }
}