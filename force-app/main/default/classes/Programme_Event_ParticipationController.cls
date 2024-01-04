/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to implement functionality of Programme_Event_Participation Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 30-11-2016       | Vivian Charlie   | 1. Created class to implement functionality of Programme_Event_Participation Page
   ==========================================================================================================================
*/
public class Programme_Event_ParticipationController{
    public Programme__c newProg {get;set;}
    
    public Programme_Event_ParticipationController(){
        Id parentId = ApexPages.currentPage().getParameters().get('id');
        system.debug('parentId'+parentId);
        newProg = new Programme__c();
        newProg.Programme_or_Event_Name__c = parentId;
    }
    
    public PageReference save()
    {      
        try {
            upsert newProg ;
        } catch(exception e) {
            ApexPages.addMessages(e);          
        }
        return new PageReference('/' + newProg.id);
    }
    
    public Pagereference cancel(){
        PageReference newpage = new Pagereference('/' + newProg.Programme_or_Event_Name__c);
        newpage.setRedirect(true);
        return newpage;
    }
}