/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Course_Participation Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 30-11-2016       | Vivian Charlie   | 1. Created class to implement functionality of Course_Participation Page
   ==========================================================================================================================
*/
public class Course_ParticipationController{
    public Course_Participation_Data__c newCoursePart {get;set;}
    
    public Course_ParticipationController(){
        Id parentId = ApexPages.currentPage().getParameters().get('id');
        system.debug('parentId'+parentId);
        newCoursePart = new Course_Participation_Data__c();
        newCoursePart.Course__c = parentId;
    }
    
    public PageReference save()
    {   
    System.debug('in save');   
        try {
            upsert newCoursePart;
        } catch(exception e) {
            ApexPages.addMessages(e);          
        }
        return new PageReference('/' + newCoursePart.id);
    }
    
    public Pagereference cancel(){
        PageReference newpage = new Pagereference('/' + newCoursePart.Course__c);
        newpage.setRedirect(true);
        return newpage;
    }
}