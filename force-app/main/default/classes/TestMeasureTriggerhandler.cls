@isTest
private class TestMeasureTriggerhandler {
    @testSetup
    private static void setup() {
        updateInvestmentAreaTriggerHandler.isExecuted = false;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='rajput', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
        
        Account testAccount = new Account( Name = 'Test Account' );
        insert testAccount;
        
        Plan__c plan = new Plan__c(Partner__c=testAccount.Id,Status__c='Draft',Start_Date__c=system.today(),End_Date__c = system.today().addDays(20));
        insert plan;
        
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
        iArea.Investment_Area_Owner__c = usr.Id;
        
        insert iArea;
        
        Funding_Allocation__c fAllocation = new Funding_Allocation__c();
        fAllocation.Financial_Year__c = '2014/15';
        fAllocation.Funding_Allocation_End_Date__c = system.Today().addDays(90);
        fAllocation.Funding_Allocation_Start_Date__c = system.Today();
        fAllocation.Funding_Amount__c = 500;
        fAllocation.Strategic_Area__c = sArea.Id;
        
        insert fAllocation;
        
        Investment_Area_Allocation__c invAreaAllocation = new Investment_Area_Allocation__c();
        invAreaAllocation.Amount__c = 400;
        invAreaAllocation.Investment_Area__c = iArea.Id;
        invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
        invAreaAllocation.Status__c = 'Draft';
        
        insert invAreaAllocation;
        
        Skip_Trigger__c isSkipTrigger = new Skip_Trigger__c();
        isSkipTrigger.Name = 'skipped';
        isSkipTrigger.is_Skipped__c = false;
        
        insert isSkipTrigger;
        
        List<Initiative__c> lstOfInitiative = new List<Initiative__c>();
        
        Initiative__c init1 = new Initiative__c(
            Name = 'Test Init1',
            Investment_Area__c = iArea.Id,
            Plan__c = plan.Id,
            Pending_Measures__c = 0,
            Initiative_Owner__c = usr.Id);
        
        Initiative__c init2 = new Initiative__c(
            Name = 'Test Init2',
            Investment_Area__c = iArea.Id,
            Plan__c = plan.Id,
            Pending_Measures__c = 0,
            Initiative_Owner__c = usr.Id);
        
        lstOfInitiative.add(init1);
        lstOfInitiative.add(init2);
        
        insert lstOfInitiative;
        
        List<Measure__c> lstOfMeasure = new List<Measure__c>();
        
        for(Integer i = 0; i < 10; i++) {
            lstOfMeasure.add(
                new Measure__c(
                    Name = 'Test Measure' + i,
                    Initiative__c = init1.Id,
                    Partner__c = testAccount.Id,
                    Status__c = 'Pending')
            );
        }
        
        insert lstOfMeasure;
    }
    
    //Test insert
    @isTest
    private static void testInsert() {
        Test.startTest();
        
        List<Initiative__c> lstOfInitiative = [SELECT Id, Pending_Measures__c FROM Initiative__c];
        
        //System.assertEquals(10, lstOfInitiative[0].Pending_Measures__c);
        //System.assertEquals(0, lstOfInitiative[1].Pending_Measures__c);
        
        Test.stopTest();
    }
    
    //Test delete & undelete
    @isTest
    private static void testDelete() {
        Test.startTest();
        
        //Test delete
        List<Measure__c> lstOfMeasure = [SELECT Id FROM Measure__c WHERE Status__c = 'Pending'];
        
        delete lstOfMeasure;
        
        List<Initiative__c> lstOfInitiative = [SELECT Id, Pending_Measures__c FROM Initiative__c];
        system.debug('Testing Init ------------------'+lstOfInitiative);
        //System.assertEquals(10, lstOfInitiative[0].Pending_Measures__c);
        //System.assertEquals(0, lstOfInitiative[1].Pending_Measures__c);
        
        //Test undelete
        undelete lstOfMeasure;
        
        lstOfInitiative = [SELECT Id, Pending_Measures__c FROM Initiative__c];
        
        //System.assertEquals(10, lstOfInitiative[0].Pending_Measures__c);
        //System.assertEquals(0, lstOfInitiative[1].Pending_Measures__c);
        
        Test.stopTest();
    }
    
    //Test update - only Initiative__c changes
    @isTest
    private static void testUpdate1() {
        Test.startTest();
        
        List<Measure__c> lstOfMeasure = [SELECT Id, Initiative__c FROM Measure__c];
        List<Initiative__c> lstOfInitiative = [SELECT Id FROM Initiative__c];
        
        for(Integer i = 0; i < 10; i++) {
            lstOfMeasure[i].Initiative__c = (i < 5) ? null : lstOfInitiative[1].Id;
        }
        
        update lstOfMeasure;
        
        lstOfInitiative = [SELECT Id, Pending_Measures__c FROM Initiative__c];
        
        //System.assertEquals(10, lstOfInitiative[0].Pending_Measures__c);
        //System.assertEquals(5, lstOfInitiative[1].Pending_Measures__c);
        
        Test.stopTest();
    }
    
    //Test update - only Status__c changes
    @isTest
    private static void testUpdate2() {
        Test.startTest();
        
        List<Measure__c> lstOfMeasure = [SELECT Id, Status__c FROM Measure__c];
        List<Initiative__c> lstOfInitiative = [SELECT Id FROM Initiative__c];
        for(Integer i = 0; i < 10; i++) {
            lstOfMeasure[i].Status__c = 'Met';
        }
        
        update lstOfMeasure;
        
        lstOfInitiative = [SELECT Id, Pending_Measures__c FROM Initiative__c];
        
        //System.assertEquals(10, lstOfInitiative[0].Pending_Measures__c);
        //System.assertEquals(0, lstOfInitiative[1].Pending_Measures__c);
        
        Test.stopTest();
    }
    
    //Test update - both Initiative__c and Status__c change
    @isTest
    private static void testUpdate3() {
        Test.startTest();
        
        //Sub-test 1: Status__c changes from Pending to Met
        List<Measure__c> lstOfMeasure = [SELECT Id, Initiative__c, Status__c FROM Measure__c];
        List<Initiative__c> lstOfInitiative = [SELECT Id FROM Initiative__c];
        
        for(Integer i = 0; i < 5; i++) {
            lstOfMeasure[i].Initiative__c = lstOfInitiative[1].Id;
            lstOfMeasure[i].Status__c = 'Met';
        }
        
        update lstOfMeasure;
        
        lstOfInitiative = [SELECT Id, Pending_Measures__c FROM Initiative__c];
        
        //System.assertEquals(10, lstOfInitiative[0].Pending_Measures__c);
        //System.assertEquals(0, lstOfInitiative[1].Pending_Measures__c);
        
        //Sub-test 2: Status__c changes from Met to Pending
        lstOfMeasure = [SELECT Id, Initiative__c, Status__c FROM Measure__c WHERE Status__c = 'Met'];
        lstOfInitiative = [SELECT Id FROM Initiative__c];
        
        for(Integer i = 0; i < 5; i++) {
            lstOfMeasure[i].Initiative__c = lstOfInitiative[0].Id;
            lstOfMeasure[i].Status__c = 'Pending';
        }
        
        update lstOfMeasure;
        
        lstOfInitiative = [SELECT Id, Pending_Measures__c FROM Initiative__c];
        
        //System.assertEquals(10, lstOfInitiative[0].Pending_Measures__c);
        //System.assertEquals(0, lstOfInitiative[1].Pending_Measures__c);
        
        Test.stopTest();
    }
}