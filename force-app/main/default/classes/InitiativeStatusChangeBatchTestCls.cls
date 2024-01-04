@isTest 
private class InitiativeStatusChangeBatchTestCls {
    
    static testMethod void initiativeStatusTest(){
        
        Test.startTest();
        //updateInvestmentAreaTriggerHandler handler = new updateInvestmentAreaTriggerHandler();
        updateInvestmentAreaTriggerHandler.isExecuted = false;
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='rajput', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
        
        Account testAccount = new Account( Name = 'Test Account' );
        insert testAccount;
        
        Plan__c plan = new Plan__c(Partner__c=testAccount.Id,Status__c='Draft',Start_Date__c=system.today(),
                                   End_Date__c = system.today().addDays(20));
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
        fAllocation.Financial_Year__c='2014/15';
        fAllocation.Funding_Allocation_End_Date__c=system.Today().addDays(90);
        fAllocation.Funding_Allocation_Start_Date__c= system.Today();
        fAllocation.Funding_Amount__c =500;
        fAllocation.Strategic_Area__c = sArea.Id;
        insert fAllocation;
        
        Investment_Area_Allocation__c invAreaAllocation = new Investment_Area_Allocation__c();
        invAreaAllocation.Amount__c = 500;
        invAreaAllocation.Investment_Area__c = iArea.Id;
        invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
        invAreaAllocation.Status__c = 'Draft';
        insert invAreaAllocation;
        
        Business_Case__c bCase = new Business_Case__c();
        bCase.Name = 'Investment Schedule 1';
        bCase.Status__c = 'Draft';
        bCase.Total_Amount__c =100;
        bCase.Investment_Area__c =iArea.Id;
        bCase.Strategic_Area__c = sArea.Id;
        bCase.Approval_Type__c ='Manager Delegation';
        insert bCase;
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Business_Case__c=bCase.Id,
                                              Investment_Area__c=iArea.Id,Plan__c=plan.Id,
                                              Planned__c=500,Initiative_Owner__c=usr.Id,Status_Text__c='');
        insert inv;
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Amount__c = 500;
        pay.status__c = 'Paid';
        insert pay;
        
        Requirement__c requirement = new Requirement__c();
        requirement.Name ='My Requirement';
        requirement.Status__c ='Completed';
        //requirement.Description__c = 'Test Initiative';
        requirement.Due_Date__c = system.Today();//System.now().addDays(-1);
        requirement.Completed_Date__c = system.Today();
        requirement.Initiative__c = inv.Id;
        insert requirement;
        
        InitiativeStatusChangeBatch batch = new InitiativeStatusChangeBatch();
        Database.executeBatch(batch);
        // Schedule class
         InitiativeStatusChangeScheduler.scheduleBatch();
        
		try {
			inv.Id =null;
			update inv;
			InitiativeStatusChangeBatch batch1 = new InitiativeStatusChangeBatch();
			Database.executeBatch(batch1);
		} catch (DmlException e){
			System.assert( e.getMessage().contains('Update failed. First exception on row 0'));
		}
			
		System.schedule('Initiative status change Job '+system.now(), '0 00 00 * * ?', new InitiativeStatusChangeScheduler());
		
        Test.stopTest();
	}
}