@isTest(SeeAllData=true)
private class TestRequirementTrigger {
    
    static testMethod void testUpdatePlanMethod() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        
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
        
        
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        //Create Initiative
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
        initiativeObject.Initiative_Owner__c = userObject.id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        insert initiativeObject;
        
        //Create Requirement
        Requirement__c requirementObject = new Requirement__c();
        requirementObject.Initiative__c = initiativeObject.Id;
        requirementObject.Name = 'Test Requirement';
        requirementObject.Due_Date__c = date.today().addDays(5);
        //requirementObject.Description__c = 'Test';
        insert requirementObject;
        
        
        //Test - Check Partner and Plan lookups populated on inserted Requirement
        Test.startTest();       
        List<Requirement__c> insertedRequirement = [select Partner__c, Plan__c,Name from Requirement__c where id=:requirementObject.id];   
        insertedRequirement[0].Name = ' Test';
        update insertedRequirement;
        System.assertEquals(insertedRequirement[0].Partner__c,accountObject.Id);
        System.assertEquals(insertedRequirement[0].Plan__c,planObject.Id);      
        Test.stopTest();
        
    }
    
    
    static testMethod void testCheckRequirementsMethod(){
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id paymentPaymentRecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        
        //Profile
        //Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        // Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
        //Id sportNZProfile = [Select Id from Profile where Name = 'Sport NZ'].Id;
        Id sportNZProfile = [Select Id from Profile where Name ='Kahiwi'].Id;
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
        
        //Create Initiative
        
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
        initiativeObject.Initiative_Owner__c = userObject.id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        insert initiativeObject;
        
        //Create Payment
        Payment__c paymentObject = new Payment__c();
        paymentObject.RecordTypeId = paymentPaymentRecordTypeId;
        paymentObject.Initiative__c = initiativeObject.id;
        paymentObject.Date__c = date.today().addDays(5);
        paymentObject.Amount__c = 100;
        insert paymentObject;
        
        //Test 1 - No Requirements
        Test.startTest();
        List<Payment__c> insertedPayment1 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        System.assertEquals(insertedPayment1[0].pending_requirements__c,false);
        System.assertEquals(insertedPayment1[0].overdue_requirements__c,false);
        
        //Pending Requirement
        Requirement__c requirementObject = new Requirement__c();
        requirementObject.Initiative__c = initiativeObject.Id;
        requirementObject.RecordTypeId = requirementInitiativeRequirementRecordTypeId;
        requirementObject.Name = 'Test Initiative Requirement';
        requirementObject.Hold_Payments__c = true;
        requirementObject.Due_Date__c = date.today().addDays(5);
        requirementObject.Description__c = 'Test';
        system.runAs(userObject){
            insert requirementObject;
            
        }
        
        //Test 2 - Pending Requirement
        List<Payment__c> insertedPayment2 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        //System.assertEquals(insertedPayment2[0].pending_requirements__c,true);
        //System.assertEquals(insertedPayment2[0].overdue_requirements__c,false);
        
        //Overdue Requirement
        Requirement__c requirementObject2 = new Requirement__c(id=requirementObject.Id);
        requirementObject2.Due_Date__c = date.today().addDays(-1);
        system.runAs(userObject){
            update requirementObject2;
        }
        
        
        //Test 3 - Overdue Requirement
        List<Payment__c> insertedPayment3 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        //System.assertEquals(insertedPayment3[0].pending_requirements__c,true);
        //System.assertEquals(insertedPayment3[0].overdue_requirements__c,true);
        
        //Delete Requirement
        Requirement__c requirementObject3 = new Requirement__c(id=requirementObject.Id);    
        delete requirementObject3;
        
        //Test 4 - No Pending or Overdue Requirements
        List<Payment__c> insertedPayment4 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        //System.assertEquals(insertedPayment4[0].pending_requirements__c,false);
        //System.assertEquals(insertedPayment4[0].overdue_requirements__c,false);
        
        //Undelete Requirement      
        Requirement__c requirementObject4 = new Requirement__c(id=requirementObject.Id);
        undelete requirementObject4;
        
        //Test 5 - Overdue Requirement
        List<Payment__c> insertedPayment5 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        //System.assertEquals(insertedPayment5[0].pending_requirements__c,false);
        //System.assertEquals(insertedPayment5[0].overdue_requirements__c,true);
        
        //Complete Requirement
        /*Requirement__c requirementObject5 = new Requirement__c(id=requirementObject.Id);
requirementObject5.Status__c = 'Completed';
requirementObject5.Completed_Date__c = date.today();
update requirementObject5;

//Test 6 - No Pending or Overdue Requirements
List<Payment__c> insertedPayment6 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
System.assertEquals(insertedPayment6[0].pending_requirements__c,false);
System.assertEquals(insertedPayment6[0].overdue_requirements__c,false); */
        
        Test.stopTest();
        
    }
    
    static testMethod void testCheckRequirementsMethod2(){
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id paymentPaymentRecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name ='Kahiwi'].Id;
        system.debug('sportNZProfile>>>>>'+sportNZProfile);
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
        system.debug('userProfilebefore>>'+userObject.ProfileId);
        insert userObject;
        system.debug('userProfileafter>>'+userObject.ProfileId);
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
        
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        businessCaseObject.Strategic_Area__c=strategicAreaObject.Id;
        insert businessCaseObject;
        
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        //Create Initiative
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 100;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Initiative_Owner__c = userObject.id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        insert initiativeObject;
        
        //Create Payment
        Payment__c paymentObject = new Payment__c();
        paymentObject.RecordTypeId = paymentPaymentRecordTypeId;
        paymentObject.Initiative__c = initiativeObject.id;
        paymentObject.Date__c = date.today().addDays(5);
        paymentObject.Amount__c = 100;
        insert paymentObject;
        
        //Test 1 - No Requirements
        system.runAs(userObject){
        Test.startTest();
        List<Payment__c> insertedPayment1 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        System.assertEquals(insertedPayment1[0].pending_requirements__c,false);
        System.assertEquals(insertedPayment1[0].overdue_requirements__c,false);
        
        //Pending Requirement
        Requirement__c requirementObject = new Requirement__c();
        requirementObject.Initiative__c = initiativeObject.Id;
        requirementObject.RecordTypeId = requirementInitiativeRequirementRecordTypeId;
        requirementObject.Name = 'Test Initiative Requirement';
        requirementObject.Hold_Payments__c = true;
        requirementObject.Due_Date__c = date.today().addDays(5);
        requirementObject.Status__c = 'Overdue';
        requirementObject.Description__c = 'Test';
          
        insert requirementObject;
             
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        objVariation.Is_Active__c = true;
        objVariation.Comments__c = 'test';
        insert objVariation;
        
        
        
        //Test 2 - Pending Requirement
        List<Payment__c> insertedPayment2 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        System.assertEquals(insertedPayment2[0].pending_requirements__c,false);
        System.assertEquals(insertedPayment2[0].overdue_requirements__c,false);
        
		Requirement__c reqObj = [ Select id,Reporting_Type__c from Requirement__c where id=:requirementObject.id];
        reqObj.Reporting_Type__c = 'Written';
        //requirementObject.Status__c = 'Overdue';
        system.debug('userObject>>>>>'+userObject.Profile.Name);
        
            update reqObj;  
        
        
        
        //Test 3 - Overdue Requirement
        List<Payment__c> insertedPayment3 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        //System.assertEquals(insertedPayment3[0].pending_requirements__c,true);
        //System.assertEquals(insertedPayment3[0].overdue_requirements__c,true);
        
        //Delete Requirement
        Requirement__c requirementObject3 = new Requirement__c(id=requirementObject.Id);    
        delete requirementObject3;
        
        //Test 4 - No Pending or Overdue Requirements
        List<Payment__c> insertedPayment4 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        //System.assertEquals(insertedPayment4[0].pending_requirements__c,false);
        //System.assertEquals(insertedPayment4[0].overdue_requirements__c,false);
        
        //Undelete Requirement      
        Requirement__c requirementObject4 = new Requirement__c(id=requirementObject.Id);
        undelete requirementObject4;
        requirementObject4.Reporting_Type__c = 'Written';
        //requirementObject4.Initiative__c =initiativeObject.Id;
        update requirementObject4;
        
        //Test 5 - Overdue Requirement
        List<Payment__c> insertedPayment5 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        
        Test.stopTest();
        }
    }
    
    static testMethod void testCheckRequirementsMethod3(){
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id paymentPaymentRecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name ='Kahiwi'].Id;
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
        
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        businessCaseObject.Strategic_Area__c=strategicAreaObject.Id;
        insert businessCaseObject;
        
        
        //Create Plan
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        //Create Initiative
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 100;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Initiative_Owner__c = userObject.id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        insert initiativeObject;
        
        /*Initiative__c initiativeObject2 = new Initiative__c();
        initiativeObject2.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject2.Name = 'Test Initiative';
        initiativeObject2.Plan__c = planObject.id;
        initiativeObject2.Type__c = 'Paid to Partner';
        initiativeObject2.Start_Date__c = date.today();
        initiativeObject2.End_Date__c = date.today().addDays(5);
        initiativeObject2.Requested__c = 100;
        initiativeObject2.Planned__c = 100;
        initiativeObject2.Business_Case__c = businessCaseObject.id;
        initiativeObject2.Priority__c = 'Must';
        initiativeObject2.Initiative_Owner__c = userObject.id;
        initiativeObject2.Investment_Area__c = investmentAreaObject.id;
        insert initiativeObject2;*/
        
        //Create Payment
        Payment__c paymentObject = new Payment__c();
        paymentObject.RecordTypeId = paymentPaymentRecordTypeId;
        paymentObject.Initiative__c = initiativeObject.id;
        paymentObject.Date__c = date.today().addDays(5);
        paymentObject.Amount__c = 100;
        insert paymentObject;
        
        
        Requirement__c requirementObject = new Requirement__c();
        requirementObject.Initiative__c = initiativeObject.Id;
        requirementObject.RecordTypeId = requirementInitiativeRequirementRecordTypeId;
        requirementObject.Name = 'Test Initiative Requirement';
        requirementObject.Hold_Payments__c = true;
        requirementObject.Due_Date__c = date.today().addDays(5);
        requirementObject.Status__c = 'Overdue';
        requirementObject.Description__c = 'Test';
        insert requirementObject;
        
        
        
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        objVariation.Is_Active__c = true;
        insert objVariation;
        
        
        requirementObject.Reporting_Type__c = 'Written';
        
        system.runAs(userObject){
            Test.startTest();
            update requirementObject;
            Test.stopTest();
        }
        
    }
    
    
}