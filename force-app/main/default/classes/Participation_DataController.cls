/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Participation_Data Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 30-11-2016       | Vivian Charlie   | 1. Created class to implement functionality of Participation_Data Page
   ==========================================================================================================================
*/
public class Participation_DataController{
    public Participation_Data__c newPart {get;set;}
    
    public Participation_DataController(){
        Id parentId = ApexPages.currentPage().getParameters().get('id');
        newPart = new Participation_Data__c();
        newPart.Programme_Name__c = parentId;
    }
    
    public PageReference save()
    {      
        try {
            upsert newPart;
        } catch(exception e) {
            ApexPages.addMessages(e);          
        }
        return new PageReference('/' + newPart.id);
    }
    
    public Pagereference cancel(){
        PageReference newpage = new Pagereference('/' + newPart.Programme_Name__c);
        newpage.setRedirect(true);
        return newpage;
    }
}