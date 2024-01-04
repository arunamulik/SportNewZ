/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Membership_Numbers Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 18-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of Membership_Numbers Page
   ==========================================================================================================================
*/
@isTest
private class Membership_NumbersControllerTest {
    /*
     @ Description : Method to insert Membership Numbers
    */
    public static testMethod void testSaveMemNoCat() {
        List<Membership_Numbers_Category__c> memNiCatList = new List<Membership_Numbers_Category__c>();
        //Creating test data
        memNiCatList = RUL_Util.createMemNosCat();
        insert memNiCatList;
        List<Account> accList = new List<Account>();
        accList = RUL_Util.createAccounts();
        insert accList;
        Test.setCurrentPageReference(new PageReference('Page.Membership_Numbers')); 
        apexpages.currentpage().getparameters().put('id', memNiCatList[0].id);
                            
        Membership_NumbersController controller = new Membership_NumbersController();
        controller.newMemberNo.Organisation__c = accList[0].id;
        PageReference pageRef = controller.save();
        System.assertEquals(pageRef.getUrl(),'/' + controller.newMemberNo.Id);
        //System.assertEquals(1, [select count() from Membership_Numbers__c WHERE Membership_Numbers_Category__c =: memNiCatList[0].id]);       
    }
    
    /*
     @ Description : Method to cancel Membership Numbers
    */
    public static testMethod void testCancelMemNoCat() {
        List<Membership_Numbers_Category__c> memNiCatList = new List<Membership_Numbers_Category__c>();
        //Creating test data
        memNiCatList = RUL_Util.createMemNosCat();
        insert memNiCatList;
        List<Account> accList = new List<Account>();
        accList = RUL_Util.createAccounts();
        insert accList;
        Test.setCurrentPageReference(new PageReference('Page.Membership_Numbers')); 
        apexpages.currentpage().getparameters().put('id', memNiCatList[0].id);
                            
        Membership_NumbersController controller = new Membership_NumbersController();
        controller.newMemberNo.Organisation__c = accList[0].id;
        PageReference pageRef = controller.Cancel();
        System.assertEquals(pageRef.getUrl(),'/' + controller.newMemberNo.Membership_Numbers_Category__c);       
    }
}