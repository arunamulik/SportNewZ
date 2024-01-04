@isTest(SeeAllData=true)
private class TestBusinessCaseTrigger {
    static testMethod void testApprovalOfInvestmentSchedule() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Draft';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
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
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject1);
        insert initiatives;
        
        /*Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
        
        objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        objMeasure.Partner__c = accountObject.Id;
        objMeasure.Initiative__c = initiatives[0].Id;
        objMeasure.Status__c = 'Not Met';
        objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        insert objMeasure;*/
        
        /*Payment__c objPayment3 = new Payment__c();
        objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment3.Status__c = 'Draft';
        objPayment3.Amount__c = 100;
        objPayment3.Date__c = Date.Today();
        objPayment3.Initiative__c = initiatives[0].Id;
        objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment3;*/
        
        
        /*Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
        objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        objRequirement.Initiative__c = initiatives[0].Id;
        objRequirement.Status__c = 'Pending';
        objRequirement.Completed_Date__c = Date.today();
        objRequirement.Due_Date__c = Date.today().adddays(1);
        objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        insert objRequirement;*/
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.Status__c = 'Approved';
        update businessCaseObject;
        
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        System.assertEquals(insertedBusinessCase[0].Status__c,'Approved');
        
        Test.stopTest();
    }
    
    static testMethod void testBeingVariedOfInvestmentSchedule() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        objFund.Financial_Year__c = '2022/23';
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
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Being Varied';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
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
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject1);
        insert initiatives;
        
        /*Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
        
        objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        objMeasure.Partner__c = accountObject.Id;
        objMeasure.Initiative__c = initiatives[0].Id;
        objMeasure.Status__c = 'Not Met';
        objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        insert objMeasure;
        
        Payment__c objPayment3 = new Payment__c();
        objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment3.Status__c = 'Draft';
        objPayment3.Amount__c = 100;
        objPayment3.Date__c = Date.Today();
        objPayment3.Initiative__c = initiatives[0].Id;
        objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment3;
        
        Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
        
        objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        objRequirement.Initiative__c = initiatives[0].Id;
        objRequirement.Status__c = 'Pending';
        objRequirement.Completed_Date__c = Date.today();
        objRequirement.Due_Date__c = Date.today().adddays(1);
        objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        insert objRequirement;*/
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Rural Travel Fund T&C', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'BC 2015 T&C', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.Status__c = 'Draft';
        update businessCaseObject;
        
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        System.assertEquals(insertedBusinessCase[0].Status__c,'Draft');
        
        Test.stopTest();
    }
    
    static testMethod void testTermAndConditions() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        objFund.Financial_Year__c = '2022/23';
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
        
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Being Varied';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        objVariation.Variation_Completed_Date__c=date.today();
        insert objVariation;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
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
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject1);
        insert initiatives;
        
        /*Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
        
        objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        objMeasure.Partner__c = accountObject.Id;
        objMeasure.Initiative__c = initiatives[0].Id;
        objMeasure.Status__c = 'Not Met';
        objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        insert objMeasure;
        
        Payment__c objPayment3 = new Payment__c();
        objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment3.Status__c = 'Draft';
        objPayment3.Amount__c = 100;
        objPayment3.Date__c = Date.Today();
        objPayment3.Initiative__c = initiatives[0].Id;
        objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment3;
        
        Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
        
        objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        objRequirement.Initiative__c = initiatives[0].Id;
        objRequirement.Status__c = 'Pending';
        objRequirement.Completed_Date__c = Date.today();
        objRequirement.Due_Date__c = Date.today().adddays(1);
        objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        insert objRequirement;*/
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Test 123', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'Test 321', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.Status__c = 'Draft';
        update businessCaseObject;
        
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        System.assertEquals(insertedBusinessCase[0].Status__c,'Draft');
        
        Test.stopTest();
    }
    static testMethod void testMethod4() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        objFund.Financial_Year__c = '2022/23';
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
        
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Being Varied';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
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
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject1);
        insert initiatives;
        
        /*Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
        
        objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        objMeasure.Partner__c = accountObject.Id;
        objMeasure.Initiative__c = initiatives[0].Id;
        objMeasure.Status__c = 'Not Met';
        objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        insert objMeasure;
        
        Payment__c objPayment3 = new Payment__c();
        objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment3.Status__c = 'Draft';
        objPayment3.Amount__c = 100;
        objPayment3.Date__c = Date.Today();
        objPayment3.Initiative__c = initiatives[0].Id;
        objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment3;
        
        
        Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
        
        objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        objRequirement.Initiative__c = initiatives[0].Id;
        objRequirement.Status__c = 'Pending';
        objRequirement.Completed_Date__c = Date.today();
         objRequirement.Due_Date__c = Date.today().adddays(1);
        objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        insert objRequirement;*/
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Rural Travel Fund T&C', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'BC 2015 T&C', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.Status__c = 'Signed';
        update businessCaseObject;
        
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        System.assertEquals(insertedBusinessCase[0].Status__c,'Signed');
        
        Test.stopTest();
    }
    
    static testMethod void testMethod5() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        objFund.Financial_Year__c = '2022/23';
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
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 1000;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Partner__c = accountObject.id;
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Third Party';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 1000;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Partner__c = accountObject.id; 
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject1);
        insert initiatives;
        
        /*Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
        objMeasure.name = 'Testing';
        objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Number'].Id;
        objMeasure.Partner__c = accountObject.Id;
        objMeasure.Initiative__c = initiatives[0].Id;
        objMeasure.Status__c = 'Variation';
        objMeasure.Old_Status__c = 'Not Met';
        objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        insert objMeasure;
        
        Payment__c objPayment3 = new Payment__c();
        objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment3.Status__c = 'Variation';
        objPayment3.Old_Status__c = 'Draft';
        objPayment3.Amount__c = 100;
        objPayment3.Partner__c = accountObject.id;
        objPayment3.Date__c = Date.Today();
        objPayment3.Initiative__c = initiatives[0].Id;
        objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment3;
        
        Payment__c objPayment4 = new Payment__c();
        objPayment4.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment4.Status__c = 'Draft';
        objPayment4.Old_Status__c = 'Draft';
        objPayment4.Supplier_Invoice_Date__c = system.today();
        objPayment4.Supplier_Invoice_Number__c = '123';
        objPayment4.Amount__c = 100;
        objPayment4.Partner__c = accountObject.id;
        objPayment4.Date__c = Date.Today();
        objPayment4.Initiative__c = initiatives[1].Id;
        objPayment4.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment4;           
        
        Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
        
        objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        objRequirement.Initiative__c = initiatives[0].Id;
        objRequirement.Status__c = 'Variation';
        objRequirement.Old_Status__c = 'Pending';
         objRequirement.Due_Date__c = Date.today().adddays(1);
        objRequirement.Completed_Date__c = Date.today();
        objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        insert objRequirement;*/
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Rural Travel Fund T&C', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'BC 2015 T&C', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.Status__c = 'Approved';
        
        update businessCaseObject;
        objVariation.Variation_Completed_Date__c = system.today();
        update objVariation;
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        Test.stopTest();
    }
    static testMethod void testMethod6() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        //accountObject.Vendor_Id__c='1234';
        insert accountObject;
        
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 1000;
        initiativeObject.Partner__c = accountObject.id;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Third Party';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 1000;
        initiativeObject1.Partner__c = accountObject.id;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject1);
        insert initiatives;
        
        Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
        objMeasure.name = 'Testing';
        objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'CUrrency'].Id;
        objMeasure.Partner__c = accountObject.Id;
        objMeasure.Initiative__c = initiatives[0].Id;
        objMeasure.Status__c = 'Variation';
        objMeasure.Old_Status__c = 'Not Met';
        objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        insert objMeasure;
        
        Payment__c objPayment5 = new Payment__c();
        objPayment5.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment5.Status__c = 'Sent for Payment';
        objPayment5.Old_Status__c = 'Draft';
        objPayment5.Partner__c = accountObject.id;
        objPayment5.Amount__c = 100;
        objPayment5.Date__c = Date.Today();
        objPayment5.Initiative__c = initiatives[0].Id;
        objPayment5.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment5;
        
        Payment__c objPayment3 = new Payment__c();
        objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Credit'].Id;
        objPayment3.Status__c = 'Draft';
        objPayment3.Old_Status__c = 'Draft';
        objPayment3.Partner__c = accountObject.id;
        objPayment3.Related_Payment__c = objPayment5.id;
        objPayment3.Amount__c = -100;
        objPayment3.Date__c = Date.Today();
        objPayment3.Initiative__c = initiatives[0].Id;
        objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Credit'].Id;
        insert objPayment3;
        
        /*Payment__c objPayment4 = new Payment__c();
        objPayment4.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment4.Status__c = 'Draft';
        objPayment4.Old_Status__c = 'Draft';
        objPayment4.Partner__c = accountObject.id;
        objPayment4.Supplier_Invoice_Date__c = system.today();
        objPayment4.Supplier_Invoice_Number__c = '123';
        objPayment4.Vendor__c=accountObject.Vendor_Id__c;
        objPayment4.Amount__c = 100;
        objPayment4.Date__c = Date.Today();
        objPayment4.Initiative__c = initiatives[1].Id;
        objPayment4.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment4;   */        
        
        Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
        
        objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].Id;
        objRequirement.Initiative__c = initiatives[0].Id;
        objRequirement.Status__c = 'Variation';
         objRequirement.Due_Date__c = Date.today().adddays(1);
        objRequirement.Old_Status__c = 'Pending';
        objRequirement.Completed_Date__c = Date.today();
        objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].Id;
        insert objRequirement;
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Rural Travel Fund T&C', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'BC 2015 T&C', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.Status__c = 'Approved';
        
        update businessCaseObject;
        objVariation.Variation_Completed_Date__c = system.today();
        update objVariation;
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        Test.stopTest();
    }
    
    static testMethod void testMethod7() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Third Party';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 1000;
        initiativeObject.Partner__c = accountObject.id;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Third Party';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Partner__c = accountObject.id;
        initiativeObject1.Planned__c = 1000;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiatives.add(initiativeObject1);
        insert initiatives;
        
        /*Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
        objMeasure.name = 'Testing';
        objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'CUrrency'].Id;
        objMeasure.Partner__c = accountObject.Id;
        objMeasure.Initiative__c = initiatives[0].Id;
        objMeasure.Status__c = 'Variation';
        objMeasure.Old_Status__c = 'Not Met';
        objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        insert objMeasure;
        
        Payment__c objPayment5 = new Payment__c();
        objPayment5.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment5.Status__c = 'Draft';
        objPayment5.Old_Status__c = 'Draft';
        objPayment5.Supplier_Invoice_Date__c = system.today();
        objPayment5.Supplier_Invoice_Number__c = '123';
        objPayment5.Amount__c = 100;
        objPayment5.Partner__c = accountObject.id;
        objPayment5.Date__c = Date.Today();
        objPayment5.Initiative__c = initiatives[0].Id;
        objPayment5.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment5;
        
        Payment__c objPayment4 = new Payment__c();
        objPayment4.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment4.Status__c = 'Draft';
        objPayment4.Old_Status__c = 'Draft';
        objPayment4.Partner__c = accountObject.id;
        objPayment4.Supplier_Invoice_Date__c = system.today();
        objPayment4.Supplier_Invoice_Number__c = '123';
        objPayment4.Amount__c = 100;
        objPayment4.Date__c = Date.Today();
        objPayment4.Initiative__c = initiatives[1].Id;
        objPayment4.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment4;           
        
        Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
        
        objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].Id;
        objRequirement.Initiative__c = initiatives[0].Id;
        objRequirement.Status__c = 'Variation';
         objRequirement.Due_Date__c = Date.today().adddays(1);
        objRequirement.Old_Status__c = 'Pending';
        objRequirement.Completed_Date__c = Date.today();
        objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].Id;
        insert objRequirement;*/
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Rural Travel Fund T&C', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'BC 2015 T&C', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.Status__c = 'Approved';
        
        update businessCaseObject;
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        Test.stopTest();
    }
    
    static testMethod void testMethod8() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'Supplier';
        insert accountObject;
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid Direct';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 1000;
        initiativeObject.Partner__c = accountObject.id;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid Direct';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Partner__c = accountObject.id;
        initiativeObject1.Planned__c = 1000;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiatives.add(initiativeObject1);
        insert initiatives;
        
        Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
        objMeasure.name = 'Testing';
        objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'CUrrency'].Id;
        objMeasure.Partner__c = accountObject.Id;
        objMeasure.Initiative__c = initiatives[0].Id;
        objMeasure.Status__c = 'Variation';
        objMeasure.Old_Status__c = 'Not Met';
        objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
        insert objMeasure;
        
        Payment__c objPayment5 = new Payment__c();
        objPayment5.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment5.Status__c = 'Draft';
        objPayment5.Old_Status__c = 'Draft';
        objPayment5.Supplier_Invoice_Date__c = system.today();
        objPayment5.Supplier_Invoice_Number__c = '123';
        objPayment5.Partner__c = accountObject.id;
        objPayment5.Amount__c = 100;
        objPayment5.Date__c = Date.Today();
        objPayment5.Initiative__c = initiatives[0].Id;
        objPayment5.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment5;
        
        Payment__c objPayment4 = new Payment__c();
        objPayment4.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment4.Status__c = 'Draft';
        objPayment4.Partner__c = accountObject.id;
        objPayment4.Old_Status__c = 'Draft';
        objPayment4.Supplier_Invoice_Date__c = system.today();
        objPayment4.Supplier_Invoice_Number__c = '123';
        objPayment4.Amount__c = 100;
        objPayment4.Date__c = Date.Today();
        objPayment4.Initiative__c = initiatives[1].Id;
        objPayment4.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment4;           
        
        Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
        
        objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].Id;
        objRequirement.Initiative__c = initiatives[0].Id;
        objRequirement.Status__c = 'Variation';
        objRequirement.Old_Status__c = 'Pending';
        objRequirement.Completed_Date__c = Date.today();
        objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].Id;
        insert objRequirement;
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Rural Travel Fund T&C', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'BC 2015 T&C', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.External_Signatory__c = 'Test';
        businessCaseObject.Date_Signed_By_External_Party__c = system.today();
        businessCaseObject.Document_Link_1__c='test';
        
        update businessCaseObject;
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        Test.stopTest();
    }
    
    static testMethod void testSignOffCondition() {
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
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
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
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
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'Supplier';
        insert accountObject;
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid Direct';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 1000;
        initiativeObject.Partner__c = accountObject.id;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiatives.add(initiativeObject);
        insert initiatives; 
              
        Payment__c objPayment5 = new Payment__c();
        objPayment5.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment5.Status__c = 'Draft';
        objPayment5.Old_Status__c = 'Draft';
        objPayment5.Supplier_Invoice_Date__c = system.today();
        objPayment5.Supplier_Invoice_Number__c = '123';
        objPayment5.Partner__c = accountObject.id;
        objPayment5.Amount__c = 100;
        objPayment5.Date__c = Date.Today();
        objPayment5.Initiative__c = initiatives[0].Id;
        objPayment5.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment5;
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Rural Travel Fund T&C', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'BC 2015 T&C', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.External_Signatory__c = 'Test';
        businessCaseObject.Date_Signed_By_External_Party__c = system.today();
        businessCaseObject.Document_Link_1__c='test';
        
        update businessCaseObject;
        List<Business_Case__c> insertedBusinessCase = [select Id, Status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Initiative__c> initiativesChanged = [SELECT Id, RecordType.Name FROM Initiative__c WHERE Business_Case__c =: businessCaseObject.id];
        //system.assertEquals(insertedBusinessCase[0].status__c, 'Signed');
        Test.stopTest();
    }
    
     static testMethod void testSignOffApproval() {
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        //strategicAreaObject.OwnerId = userObject.Id;
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        //investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
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
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        //businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'Supplier';
        insert accountObject;
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid Direct';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 1000;
        initiativeObject.Partner__c = accountObject.id;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiatives.add(initiativeObject);
        insert initiatives; 
              
        Payment__c objPayment5 = new Payment__c();
        objPayment5.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment5.Status__c = 'Draft';
        objPayment5.Old_Status__c = 'Draft';
        objPayment5.Supplier_Invoice_Date__c = system.today();
        objPayment5.Supplier_Invoice_Number__c = '123';
        objPayment5.Partner__c = accountObject.id;
        objPayment5.Amount__c = 100;
        objPayment5.Date__c = Date.Today();
        objPayment5.Initiative__c = initiatives[0].Id;
        objPayment5.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment5;
        
        List<Terms_and_Conditions__c> termsAndConditions = new List<Terms_and_Conditions__c>();
        Terms_and_Conditions__c tc = new Terms_and_Conditions__c(Name = 'Rural Travel Fund T&C', PDF__c = '123');
        termsAndConditions.add(tc);
        Terms_and_Conditions__c tc1 = new Terms_and_Conditions__c(Name = 'BC 2015 T&C', PDF__c = '321');
        termsAndConditions.add(tc1);
        insert termsAndConditions;
        
        Test.startTest();
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        RecursionHandler.executionCount = 0;
        businessCaseObject.T_Cs__c ='BC 2015 T&C';
        businessCaseObject.External_Signatory__c = 'Test';
        businessCaseObject.Date_Signed_By_External_Party__c = system.today();
        businessCaseObject.Document_Link_1__c='test';

        update businessCaseObject;
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        //Variation after signoff
         Variation__c objVariation = RUL_Util.createVariation()[0];
         objVariation.Investment_Schedule__c = businessCaseObject.id;
         insert objVariation;
        
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        List<Business_Case__c>listIS2 = [Select id,status__c, External_Signatory__c, Date_Signed_By_External_Party__c, Document_Link_1__c from Business_Case__c where id=:businessCaseObject.id];
        System.assertEquals('Being Varied',listIS2[0].status__c );
        
        listIS2[0].status__c='Approved';
        update listIS2[0];
        RecursionHandler.TrgInvestmentScheduleBypassUpdate = false;
        List<Business_Case__c>listIS1 = [Select id,status__c from Business_Case__c where id=:businessCaseObject.id];
        List<Sign_Off_History__c> insertedSignOff = [select Id,External_Signatory__c,Document_Link_1__c,Date_Signed__c from Sign_Off_History__c where Business_Case__c =:listIS1[0].id];
        system.assertEquals(insertedSignOff[0].External_Signatory__c, 'Test');
        system.assertEquals(insertedSignOff[0].Document_Link_1__c, 'test');
        system.assertEquals(insertedSignOff[0].Date_Signed__c, system.today());
        system.assertEquals(insertedSignOff.size(),1);
        Test.stopTest();
    }
 }