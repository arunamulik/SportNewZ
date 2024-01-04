/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to implement functionality of Membership_Numbers Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 30-11-2016       | Vivian Charlie   | 1. Created class to implement functionality of Membership_Numbers Page
   ==========================================================================================================================
*/
public class Membership_NumbersController{
    public Membership_Numbers__c newMemberNo {get;set;}
    
    public Membership_NumbersController(){
        Id parentId = ApexPages.currentPage().getParameters().get('id');
        system.debug('parentId'+parentId);
        newMemberNo  = new Membership_Numbers__c();
        newMemberNo.Membership_Numbers_Category__c = parentId;
    }
    
    public PageReference save()
    {      
        try {
            upsert newMemberNo ;
        } catch(exception e) {
            ApexPages.addMessages(e);          
        }
        return new PageReference('/' + newMemberNo.id);
    }
    
    public Pagereference cancel(){
        PageReference newpage = new Pagereference('/' + newMemberNo.Membership_Numbers_Category__c);
        newpage.setRedirect(true);
        return newpage;
    }
}