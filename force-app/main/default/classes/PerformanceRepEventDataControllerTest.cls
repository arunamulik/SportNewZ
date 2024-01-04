@isTest
private class PerformanceRepEventDataControllerTest {
    private static testmethod void testSavePerRepData() {
        //Creating Test data
        list<Account> accList = RUL_Util.createAccounts();
        insert accList ;
        
        Performance_Representative__c tempRep = new Performance_Representative__c();
        tempRep.Organisation__c = accList[0].Id;
        tempRep.Start_Date__c = system.today();
        tempRep.End_Date__c = system.today();
        insert tempRep ;
        
        PageReference newPageRef = Page.Performance_Representative_Event_Data;
        newPageRef.getParameters().put('Id',tempRep.Id);
        Test.setCurrentPage(newPageRef);
        
        PerformanceRepEventDataController newObj = new PerformanceRepEventDataController();
        newObj.save();
        newObj.cancel();
        
        System.assertEquals(1, [select count() from Performance_Representative_Event_Data__c WHERE Performance_Representative__c =: tempRep.id]); 
    }
}