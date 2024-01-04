@isTest
private class TestAddRequirement {
    
    static testMethod void accountAddRequirements() {
        Account accountObject = new Account();
        accountObject.Name = 'Athletics NZ';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
         Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='rajput', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
        insert usr;                    
        /*Account testAccount = new Account( Name = 'Test Account' );
            insert testAccount;
            */
            Plan__c plan = new Plan__c(Partner__c=accountObject.Id,Status__c='Draft',Start_Date__c=system.today(),
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
           invAreaAllocation.Amount__c = 400;
           invAreaAllocation.Investment_Area__c = iArea.Id;
           invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
           invAreaAllocation.Status__c = 'Draft';
           
           insert invAreaAllocation;
           
           Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id);
           insert inv;
        
        for(integer i = 0; i<2; i++){
            Requirement_Template__c reqT = new Requirement_Template__c();
            reqT.Name = 'Template ' + i;
            reqT.Description__c = 'Description ' + i;
            insert reqT;
        }
        Requirement__c requirementObject = new Requirement__c();
        requirementObject.Initiative__c = inv.Id;
        insert requirementObject;
        Test.startTest();
        ApexPages.currentPage().getParameters().put('accountId', accountObject.id);
        ApexPages.currentPage().getParameters().put('retUrl', accountObject.id);
        ApexPages.StandardController stCon = new ApexPages.StandardController(requirementObject);
        AddRequirementExtension addReqExt = new AddRequirementExtension(stCon);
        addReqExt.cancelButton();
        addReqExt.saveButton();
        addREqExt.validate(requirementObject);
        requirementObject.Due_Date__c = date.today();
        update requirementObject;
        addREqExt.validate(requirementObject);
        Test.stopTest();
    }
    
    static testMethod void initiativeAddRequirements() {
        Account accountObject = new Account();
        accountObject.Name = 'Athletics NZ';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
         Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='rajput', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
        insert usr;                    
        /*Account testAccount = new Account( Name = 'Test Account' );
            insert testAccount;
            */
            Plan__c plan = new Plan__c(Partner__c=accountObject.Id,Status__c='Draft',Start_Date__c=system.today(),
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
           invAreaAllocation.Amount__c = 400;
           invAreaAllocation.Investment_Area__c = iArea.Id;
           invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
           invAreaAllocation.Status__c = 'Draft';
           
           insert invAreaAllocation;
           
           Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id);
           insert inv;
           
        for(integer i = 0; i<2; i++){
            Requirement_Template__c reqT = new Requirement_Template__c();
            reqT.Name = 'Template ' + i;
            reqT.Description__c = 'Description ' + i;
            insert reqT;
        }
        Requirement__c requirementObject = new Requirement__c();
        requirementObject.Initiative__c = inv.Id;
        insert requirementObject;
        Test.startTest();
        ApexPages.currentPage().getParameters().put('initiativeId', accountObject.id);
        ApexPages.currentPage().getParameters().put('retUrl', accountObject.id);
        ApexPages.StandardController stCon = new ApexPages.StandardController(requirementObject);
        AddRequirementExtension addReqExt = new AddRequirementExtension(stCon);
        addReqExt.cancelButton();
        addReqExt.saveButton();
        Test.stopTest();
    }    
 
}