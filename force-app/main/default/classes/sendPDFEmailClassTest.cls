@isTest
private class sendPDFEmailClassTest {
    private static testmethod void testCaseOne() {
        Account testAccount = new Account( Name = 'Test Account', Type = 'Other');
        insert testAccount;
       
        Strategic_Area__c sArea = new Strategic_Area__c();
        sArea.Name = 'Wellington';
        sArea.Entity__c = 'Sportz Anz';
        sArea.Status__c = 'Draft';
        sArea.Start_Date__c = system.Today();
        sArea.End_Date__c = system.Today().addDays(2);
        insert sArea; 
        
        Investment_Area__c iArea = new Investment_Area__c();
        iArea.Name = 'Davanti';
        iArea.Strategic_Area__c = sArea.Id;
        iArea.Status__c = 'Active';
        iArea.Start_Date__c = system.Today();
        iArea.End_Date__c = system.Today().addDays(2);
        //iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;         
                                   
        Business_Case__c businesscaseobject = new Business_Case__c();
        businesscaseobject.name= 'Testing Parent Business Case';
        businesscaseobject.Executive_Summary__c ='bla bla bla ';
        //businesscaseobject.Status__c= 'Approved';
        businesscaseobject.Investment_Area__c = iArea.id;
        insert businesscaseobject;
        
        PageReference newPageRef = Page.InitiativeSchedulePage;
        newPageRef.getParameters().put('Id',businesscaseobject.Id);
        Test.setCurrentPage(newPageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(businesscaseobject);
        sendPDFEmailClass newObj = new sendPDFEmailClass(sc);
        newObj.emailLeadPdf();
        
        System.assert(Limits.getEmailInvocations()==1);
    }    
}