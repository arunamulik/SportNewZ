@isTest(SeeAllData=true)
private class testAssociateInitiatives {

    static testMethod void unitTestAssociateInitiatives1() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
		Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = investmentAreaObject.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
            initiativeObject.Planned__c = 100;
            initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
        businessCase.Strategic_Area__c = strategicArea.id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Work_Brief__c = workObj.Id;
            initiative.Planned__c = 50.00;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        //con.populateDisplayedRows
       con.displayedRows[0].bSelected = true;
        //con.displayedRows[1].bSelected = true;
        //con.computeSelected();
        con.first();
        con.next();
        con.previous();
        con.last();
        Integer i = con.totalPages;
        i = con.pageNumber;
        Boolean b = con.hasNext;
        b = con.hasPrevious;
        con.filterRecords();
        con.toggleSort();   
        con.addPageMessage('Test Class Message');
        con.processRecords();
        con.first();
        con.displayedRows[0].bSelected = false;
        //con.displayedRows[1].bSelected = false;
        con.next();
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
    
    static testMethod void unitTestAssociateInitiatives2() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = investmentAreaObject.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
        initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Planned__c = 100;
            initiativeObject.Priority__c = 'Must';
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = initiatives[0].Id;
        pay.Date__c = system.today();
        pay.Amount__c = 50;
        pay.status__c = 'Draft';
        insert pay;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
        businessCase.Strategic_Area__c = strategicArea.Id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Planned__c = 50.00;
            initiative.Work_Brief__c = workObj.Id;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        //con.populateDisplayedRows
       con.displayedRows[0].bSelected = true;
        //con.displayedRows[1].bSelected = true;
        //con.computeSelected();
        con.first();
        con.next();
        con.previous();
        con.last();
        Integer i = con.totalPages;
        i = con.pageNumber;
        Boolean b = con.hasNext;
        b = con.hasPrevious;
        con.filterRecords();
        con.toggleSort();   
        con.addPageMessage('Test Class Message');
        con.processRecords();
        con.first();
        con.displayedRows[0].bSelected = false;
        //con.displayedRows[1].bSelected = false;
        con.next();
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
    
    static testMethod void unitTestAssociateInitiatives3() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = investmentAreaObject.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
            initiativeObject.Planned__c = 100;
            initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = initiatives[0].Id;
        pay.Date__c = system.today();
        pay.Amount__c = 25;
        pay.status__c = 'Paid';
        insert pay;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        conDummy.currentPageNumber = 1;
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
        businessCase.Strategic_Area__c = strategicArea.Id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Work_Brief__c = workObj.Id;
            initiative.Planned__c = 50.00;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        //con.populateDisplayedRows
       con.displayedRows[0].bSelected = true;
        //con.displayedRows[1].bSelected = true;
        //con.computeSelected();
        con.first();
        con.next();
        con.previous();
        con.last();
        Integer i = con.totalPages;
        i = con.pageNumber;
        Boolean b = con.hasNext;
        b = con.hasPrevious;
        con.filterRecords();
        con.toggleSort();   
        con.addPageMessage('Test Class Message');
        con.processRecords();
        con.first();
        con.displayedRows[0].bSelected = false;
        //con.displayedRows[1].bSelected = false;
        con.next();
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
    
    static testMethod void unitTestAssociateInitiatives4() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = investmentAreaObject.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Organisation__c = accountObject.Id;
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
            initiativeObject.Planned__c = 100;
            initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = initiatives[0].Id;
        pay.Date__c = system.today();
        pay.Amount__c = 25;
        pay.status__c = 'Paid';
        insert pay;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        conDummy.currentPageNumber = 1;
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
        businessCase.Strategic_Area__c = strategicArea.Id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Work_Brief__c = workObj.Id;
            initiative.Planned__c = 50.00;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        //con.populateDisplayedRows
       con.displayedRows[0].bSelected = true;
        //con.displayedRows[1].bSelected = true;
        //con.computeSelected();
        con.first();
        con.next();
        con.previous();
        con.last();
        Integer i = con.totalPages;
        i = con.pageNumber;
        Boolean b = con.hasNext;
        b = con.hasPrevious;
        con.filterRecords();
        con.toggleSort();   
        con.addPageMessage('Test Class Message');
        con.processRecords();
        con.first();
        con.displayedRows[0].bSelected = false;
        //con.displayedRows[1].bSelected = false;
        con.next();
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
    
    static testMethod void unitTestAssociateInitiatives5() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = investmentAreaObject.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Organisation__c = accountObject.Id;
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
            initiativeObject.Planned__c = 100;
            initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = initiatives[0].Id;
        pay.Date__c = system.today();
        pay.Amount__c = 25;
        pay.status__c = 'Paid';
        insert pay;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        conDummy.currentPageNumber = 1;
        conDummy.strFilter ='Must';
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
        businessCase.Strategic_Area__c = strategicArea.Id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Work_Brief__c = workObj.Id;
            initiative.Planned__c = 50.00;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        //con.populateDisplayedRows
       con.displayedRows[0].bSelected = true;
        //con.displayedRows[1].bSelected = true;
        //con.computeSelected();
        con.first();
        con.next();
        con.previous();
        con.last();
        Integer i = con.totalPages;
        i = con.pageNumber;
        Boolean b = con.hasNext;
        b = con.hasPrevious;
        con.filterRecords();
        con.toggleSort();   
        con.addPageMessage('Test Class Message');
        con.processRecords();
        con.first();
        con.displayedRows[0].bSelected = false;
        //con.displayedRows[1].bSelected = false;
        con.next();
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
    
    static testMethod void unitTestAssociateInitiatives6() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = investmentAreaObject.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Strategic_Area__c = strategicAreaObject.Id;
        businessCaseObject.Name = 'Test Business Case';
        
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
            initiativeObject.Planned__c = 100;
            initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = initiatives[0].Id;
        pay.Date__c = system.today();
        pay.Amount__c = 25;
        pay.status__c = 'Paid';
        insert pay;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        conDummy.currentPageNumber = 1;
        conDummy.strFilter ='Must';
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
        businessCase.Strategic_Area__c = strategicArea.Id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Work_Brief__c = workObj.Id;
            initiative.Planned__c = 50.00;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
       
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
    
    static testMethod void unitTestAssociateInitiatives7() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = investmentAreaObject.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Organisation__c = accountObject.Id;
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
            initiativeObject.Planned__c = 100;
            initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = initiatives[0].Id;
        pay.Date__c = system.today();
        pay.Amount__c = 25;
        pay.status__c = 'Paid';
        insert pay;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        conDummy.currentPageNumber = 1;
        conDummy.strFilter ='Must';
        conDummy.totalAllocatedFund = 5000;
        conDummy.totalFundConsumed = 2500;
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
        businessCase.Strategic_Area__c = strategicArea.Id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Work_Brief__c = workObj.Id;
            initiative.Planned__c = 50.00;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        //con.populateDisplayedRows
       con.displayedRows[0].bSelected = true;
        //con.displayedRows[1].bSelected = true;
        //con.computeSelected();
        con.first();
        con.next();
        con.previous();
        con.last();
        Integer i = con.totalPages;
        i = con.pageNumber;
        Boolean b = con.hasNext;
        b = con.hasPrevious;
        con.filterRecords();
        con.toggleSort();   
        con.addPageMessage('Test Class Message');
        con.processRecords();
        con.first();
        con.displayedRows[0].bSelected = false;
        //con.displayedRows[1].bSelected = false;
        con.next();
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
    
    static testMethod void unitTestAssociateInitiatives8() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c fAllocation = new Funding_Allocation__c();
        fAllocation.Financial_Year__c='2014/15';
        fAllocation.Funding_Allocation_End_Date__c=system.Today().addDays(90);
        fAllocation.Funding_Allocation_Start_Date__c= system.Today();
        fAllocation.Funding_Amount__c =500;
        fAllocation.Strategic_Area__c = strategicAreaObject.Id;
        insert fAllocation;
        
        Investment_Area_Allocation__c invAreaAllocation = new Investment_Area_Allocation__c();
        invAreaAllocation.Amount__c = 500;
        invAreaAllocation.Investment_Area__c = investmentAreaObject.Id;
        invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
        invAreaAllocation.Status__c = 'Draft';
        insert invAreaAllocation;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Organisation__c = accountObject.Id;
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
            initiativeObject.Planned__c = 100;
            initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = initiatives[0].Id;
        pay.Date__c = system.today();
        pay.Amount__c = 25;
        pay.status__c = 'Paid';
        pay.Investment_Area_Allocation__c = invAreaAllocation.Id;
        insert pay;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        conDummy.currentPageNumber = 1;
        conDummy.strFilter ='Must';
        conDummy.totalAllocatedFund = 5000;
        conDummy.totalFundConsumed = 2500;
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
        businessCase.Strategic_Area__c = strategicArea.Id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Work_Brief__c = workObj.Id;
            initiative.Planned__c = 50.00;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        //con.populateDisplayedRows
       con.displayedRows[0].bSelected = true;
        //con.displayedRows[1].bSelected = true;
        //con.computeSelected();
        con.first();
        con.next();
        con.previous();
        con.last();
        Integer i = con.totalPages;
        i = con.pageNumber;
        Boolean b = con.hasNext;
        b = con.hasPrevious;
        con.filterRecords();
        con.toggleSort();   
        con.addPageMessage('Test Class Message');
        con.processRecords();
        con.first();
        con.displayedRows[0].bSelected = false;
        //con.displayedRows[1].bSelected = false;
        con.next();
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
    
        static testMethod void unitTestAssociateInitiatives9() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
            Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
            
        //Create Account
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c fAllocation = new Funding_Allocation__c();
        fAllocation.Financial_Year__c='2014/15';
        fAllocation.Funding_Allocation_End_Date__c=system.Today().addDays(90);
        fAllocation.Funding_Allocation_Start_Date__c= system.Today();
        fAllocation.Funding_Amount__c =500;
        fAllocation.Strategic_Area__c = strategicAreaObject.Id;
        insert fAllocation;
        
        Investment_Area_Allocation__c invAreaAllocation = new Investment_Area_Allocation__c();
        invAreaAllocation.Amount__c = 500;
        invAreaAllocation.Investment_Area__c = investmentAreaObject.Id;
        invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
        invAreaAllocation.Status__c = 'Draft';
        insert invAreaAllocation;
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
         //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Organisation__c = accountObject.Id;
        insert businessCaseObject;
        
        //Create Initiatives
        List<Initiative__c> initiatives = new List<Initiative__c>();
       // for(Integer i=0; i<6; i++) {
            Initiative__c initiativeObject = new Initiative__c();
            initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
            initiativeObject.Name = 'Test Initiative';
            initiativeObject.Plan__c = planObject.id;
            initiativeObject.Type__c = 'Paid to Partner';
            initiativeObject.Start_Date__c = date.today();
            initiativeObject.End_Date__c = date.today().addDays(5);
            initiativeObject.Requested__c = 100;
            initiativeObject.Planned__c = 100;
            initiativeObject.Work_Brief__c = workObj.Id;
            initiativeObject.Priority__c = 'Must';
            initiativeObject.Initiative_Owner__c = userObject.id;
            initiativeObject.Investment_Area__c = investmentAreaObject.id;
            initiativeObject.Business_Case__c = businessCaseObject.Id;
            initiatives.add(initiativeObject);
        //}
        insert initiatives;
        
        List<Payment__c> payments = new List<Payment__c>();
        Payment__c pay = new Payment__c();
        pay.Initiative__c = initiatives[0].Id;
        pay.Date__c = system.today();
        pay.Amount__c = 25;
        pay.status__c = 'Paid';
        pay.Investment_Area_Allocation__c = invAreaAllocation.Id;
        payments.add(pay);
        
        
        Payment__c pay1 = new Payment__c();
        pay1.Initiative__c = initiatives[0].Id;
        pay1.Date__c = system.today();
        pay1.Amount__c = 25;
        pay1.status__c = 'Paid';
        pay1.Investment_Area_Allocation__c = invAreaAllocation.Id;
        payments.add(pay1);
        
        Payment__c pay2 = new Payment__c();
        pay2.Initiative__c = initiatives[0].Id;
        pay2.Date__c = system.today();
        pay2.Amount__c = 25;
        pay2.status__c = 'Draft';
        pay2.Investment_Area_Allocation__c = invAreaAllocation.Id;
        payments.add(pay2);
        insert payments;
        
        PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);
        
        AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        conDummy.currentPageNumber = 1;
        conDummy.strFilter ='Must';
        conDummy.totalAllocatedFund = 5000;
        conDummy.totalFundConsumed = 2500;
        AssociateInitiatives.InvestmentAreaWrapper ivWrapper = new AssociateInitiatives.InvestmentAreaWrapper();
        AssociateInitiatives.OverDuePaymentHandler overDueWrapper = new AssociateInitiatives.OverDuePaymentHandler(true,null);
        AssociateInitiatives.DisplayedRow dRow = new AssociateInitiatives.DisplayedRow();
        AssociateInitiatives.InvestmentAreaWrapper invWrapper = new AssociateInitiatives.InvestmentAreaWrapper();  
        //conDummy.populateInitiativesList();
        conDummy.computeInvestmentAreaInitiative();
        //conDummy.populateDisplayedRows();
        conDummy.computeInvestmentAreaInitiative();
        conDummy.isValidInitiative(initiatives);
        conDummy.processRecords();
        conDummy.addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        conDummy.addPageMessage('No Initiatives found');
        
        Strategic_Area__c strategicArea = new Strategic_Area__c();
        strategicArea.Name = 'Auckland';
        Database.insert(strategicArea);

        Investment_Area__c investmentArea = new Investment_Area__c();
        investmentArea.Start_Date__c = system.today();
        investmentArea.End_Date__c = system.today().addDays(30);
        investmentArea.Strategic_Area__c = strategicArea.Id;
        investmentArea.Status__c = 'Active';
        Database.insert(investmentArea);
        
        Business_Case__c businessCase = new Business_Case__c();
        businessCase.Investment_Area__c = investmentArea.Id;
            businessCase.Strategic_Area__c = strategicArea.Id;
        Database.insert(businessCase);
        
        Account account = new Account();
        account.Name = 'Test Account';
        Database.insert(account);
        Plan__c plan = new Plan__c();
        plan.Partner__c = account.Id;
        Database.insert(plan);
        List<Initiative__c> initiatives2 = new List<Initiative__c>();
        for(Integer i=0; i<6; i++) {
            Initiative__c initiative = new Initiative__c();
            initiative.Investment_Area__c = investmentArea.Id;
            initiative.Priority__c = 'Must';
            initiative.Plan__c = plan.Id;   
            initiative.Requested__c = 100.00;
            initiative.Work_Brief__c = workObj.Id;
            initiative.Planned__c = 50.00;
            initiatives2.add(initiative);
        }       
       // AssociateInitiatives conDummy = new AssociateInitiatives(new ApexPages.standardController(businessCase));
        Database.insert(initiatives2);
        
        

        // Start Test
        Test.startTest();
        
       /* PageReference pref = Page.AssociateInitiatives;
        pref.getParameters().put('Id', businessCaseObject.Id);
        pref.getParameters().put('pagesize', '2');
        pref.getParameters().put('returnURL', businessCaseObject.Id);
        Test.setCurrentPage(pref);*/
        AssociateInitiatives con = new AssociateInitiatives(new ApexPages.standardController(businessCaseObject));
        //con.populateDisplayedRows
       con.displayedRows[0].bSelected = true;
        //con.displayedRows[1].bSelected = true;
        //con.computeSelected();
        con.first();
        con.next();
        con.previous();
        con.last();
        Integer i = con.totalPages;
        i = con.pageNumber;
        Boolean b = con.hasNext;
        b = con.hasPrevious;
        con.filterRecords();
        con.toggleSort();   
        con.addPageMessage('Test Class Message');
        con.processRecords();
        con.first();
        con.displayedRows[0].bSelected = false;
        //con.displayedRows[1].bSelected = false;
        con.next();
        con.processRecords();
        con.bThrowException = true;
        try {
            con.processRecords();
        }   
        catch (Exception e) {
            system.debug('Expected Error');
        }
           
        Test.stopTest();  
    }
}