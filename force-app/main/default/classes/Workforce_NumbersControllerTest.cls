@isTest
private class Workforce_NumbersControllerTest {
    private static testmethod void testSaveWorkNos() {
        list<Account> accList = RUL_Util.createAccounts();
        insert accList ;
        
        Workforce_Numbers_Category__c tempCat = new Workforce_Numbers_Category__c();
        tempCat.Organisation__c = accList[0].Id;
        tempCat.Category__c = 'Other';
        tempCat.End_Date__c = system.today();
        tempCat.Start_Date__c = system.today();
        insert tempCat;
        
        Workforce_Numbers__c tempWork = new Workforce_Numbers__c();
        tempWork.Workforce_Category__c = tempCat.Id;
        insert tempWork;
        
        PageReference newPageRef = Page.Workforce_Numbers;
        newPageRef.getParameters().put('Id',tempWork.Id);
        Test.setCurrentPage(newPageRef);
    
        Workforce_NumbersController newController = new Workforce_NumbersController();
        newController.save();
        newController.cancel();
        
        //System.assertEquals(1, [select count() from Workforce_Numbers__c WHERE Workforce_Category__c =: tempCat.id]);
    }
}