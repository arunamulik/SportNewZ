@isTest
private class Participation_DataControllerTest {
    /*
     @ Description : Method to insert Participation Data
    */
    private static testmethod void testSavePartData() {
        //creating test data
        list<Account> accList = RUL_Util.createAccounts();
        insert accList ;
        
        Participation_Activity_Profile_Data__c newObj = new Participation_Activity_Profile_Data__c();
        newObj.Organisation__c = accList[0].Id;
        newObj.Start_Date__c = system.today();
        newObj.End_Date__c = system.today();
        newObj.Delivery_Context__c = 'Club';
        newObj.Percentage_of_Adults__c = 10;
        newObj.Percentage_of_Young_People__c = 10;
        insert newObj;
        
        PageReference newPageRef = Page.Participation_Data;
        newPageRef.getParameters().put('Id',newObj.Id);
        Test.setCurrentPage(newPageRef);
        
        Participation_DataController temp = new Participation_DataController();
        temp.save();
        temp.cancel();
        
       // System.assertEquals(1, [select count() from Participation_Data__c WHERE Programme_Name__c =: newObj.id]);       
    }
}