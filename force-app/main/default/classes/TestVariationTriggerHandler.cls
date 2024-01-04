@isTest(SeeAllData=true) 
private class TestVariationTriggerHandler {

    static testMethod void updateValidation() {
        
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
        businessCaseObject.Strategic_Area__c=strategicAreaObject.Id;
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
        initiativeObject.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        insert initiativeObject;
        
        Variation__c variation = RUL_Util.createVariation()[0];
        variation.Investment_Schedule__c = businessCaseObject.id;
        
        insert variation;
       
       
        //Create Initiatives
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative 2';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        
       Test.startTest();
            variation.Payments_Varied__c = true;
            update variation;
       Test.stopTest();
        
    }
    
    static testMethod void updateValidationCatch() {
        
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
        businessCaseObject.Strategic_Area__c=strategicAreaObject.Id;
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
        initiativeObject.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        insert initiativeObject;
        
        Variation__c variation = RUL_Util.createVariation()[0];
        variation.Investment_Schedule__c = businessCaseObject.id;
        VariationTriggerHandler.getCatch = true;
        insert variation;
       
       
        //Create Initiatives
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative 2';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        
       Test.startTest();
            variation.Payments_Varied__c = true;
            VariationTriggerHandler.getCatch = true;
            update variation;
       Test.stopTest();
        
    }
    static testMethod void insertValidation() {
        
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
        businessCaseObject.Strategic_Area__c=strategicAreaObject.Id;
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
        initiativeObject.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        insert initiativeObject;
        
        Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
       objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       objMeasure.Partner__c = accountObject.Id;
       objMeasure.Initiative__c = initiativeObject.Id;
       objMeasure.Status__c = 'Met';
       objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       insert objMeasure;
       
       Payment__c objPayment3 = new Payment__c();
       objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       objPayment3.Status__c = 'Paid';
       objPayment3.Amount__c = 100;
       objPayment3.Date__c = Date.Today();
       objPayment3.Initiative__c = initiativeObject.Id;
       objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       insert objPayment3;
       
       
       Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
       
       objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
       objRequirement.Initiative__c = initiativeObject.Id;
       objRequirement.Status__c = 'Completed';
       objRequirement.Completed_Date__c = Date.today();
       objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        insert objRequirement;
       
       
        //Create Initiatives
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative 2';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        insert initiativeObject1;
       Test.startTest();
            RecursionHandler.TrgVariationBypassAfterUpdate = false;
            RecursionHandler.TrgVariationBypassBeforeInsert = false;
            RecursionHandler.executionCount = 0;
            Variation__c variation = RUL_Util.createVariation()[0];
        		variation.Investment_Schedule__c = businessCaseObject.id;
        	insert variation;
       Test.stopTest();
        
    }
    static testMethod void insertValidation1() {
        
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
        businessCaseObject.Strategic_Area__c=strategicAreaObject.Id;
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
        initiativeObject.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        insert initiativeObject;
        
        Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
       objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       objMeasure.Partner__c = accountObject.Id;
       objMeasure.Initiative__c = initiativeObject.Id;
       objMeasure.Status__c = 'Not Met';
       objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       insert objMeasure;
       
       Payment__c objPayment3 = new Payment__c();
       objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       objPayment3.Status__c = 'Draft';
       objPayment3.Amount__c = 100;
       objPayment3.Date__c = Date.Today();
       objPayment3.Initiative__c = initiativeObject.Id;
       objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       insert objPayment3;
       
       
       Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
       
       objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
       objRequirement.Initiative__c = initiativeObject.Id;
       objRequirement.Status__c = 'Pending';
       objRequirement.Completed_Date__c = Date.today();
       objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        insert objRequirement;
       
       
        //Create Initiatives
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative 2';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        insert initiativeObject1;
       Test.startTest();
            RecursionHandler.TrgVariationBypassAfterUpdate = false;
            RecursionHandler.TrgVariationBypassBeforeInsert = false;
            RecursionHandler.executionCount = 0;
            Variation__c variation = RUL_Util.createVariation()[0];
        		variation.Investment_Schedule__c = businessCaseObject.id;
        	insert variation;
       Test.stopTest();
        
    }
}