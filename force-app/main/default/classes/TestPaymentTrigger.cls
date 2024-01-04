@isTest(SeeAllData=true)
private class TestPaymentTrigger {
    
    static testMethod void testupdatePartnerMethod() {
        
        //Record Types
        Id accountPartnerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organisation').getRecordTypeId(); 
        Id investmentAreaStandardInvestmentRecordTypeId = Schema.SObjectType.Investment_Area__c.getRecordTypeInfosByName().get('Standard Investment').getRecordTypeId();  
        Id planPartnerPlanRecordTypeId = Schema.SObjectType.Plan__c.getRecordTypeInfosByName().get('Partner Plan').getRecordTypeId();
        Id initiativePartnerPlanRecordTypeId = Schema.SObjectType.Initiative__c.getRecordTypeInfosByName().get('Partner Plan').getRecordTypeId(); 
        Id paymentPaymentRecordTypeId = Schema.SObjectType.Payment__c.getRecordTypeInfosByName().get('Payment').getRecordTypeId(); 
        /*
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Partner'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id paymentPaymentRecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        */
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
        
        // updated on 27th june
        Funding_Allocation__c fAllocation = new Funding_Allocation__c();
           fAllocation.Financial_Year__c='2014/15';
           fAllocation.Funding_Allocation_End_Date__c=system.Today().addDays(90);
           fAllocation.Funding_Allocation_Start_Date__c= system.Today();
           fAllocation.Funding_Amount__c =500;
           fAllocation.Strategic_Area__c = strategicAreaObject.Id;
           
           insert fAllocation;
           
           Investment_Area_Allocation__c invAreaAllocation = new Investment_Area_Allocation__c();
           invAreaAllocation.Amount__c = 400;
           invAreaAllocation.Investment_Area__c = investmentAreaObject.Id;
           invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
           invAreaAllocation.Status__c = 'Draft';
        
        
        //Create Payment
       /* Payment__c paymentObject = new Payment__c();
        paymentObject.RecordTypeId = paymentPaymentRecordTypeId;
        paymentObject.Initiative__c = initiativeObject.id;
        paymentObject.Date__c = system.Today().addDays(5);
        paymentObject.Amount__c = 100;
        insert paymentObject;
        */
        //Test - Check Partner Lookup populated on inserted Payment
        Test.startTest();       
        //List<Payment__c> insertedPayment = [select Partner__c from Payment__c where id=:paymentObject.id];      
        //System.assertEquals(insertedPayment[0].Partner__c,accountObject.Id);                
        Test.stopTest();        
    }

    static testMethod void testCheckRequirementsMethod() {
        Id accountPartnerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organisation').getRecordTypeId(); 
        Id investmentAreaStandardInvestmentRecordTypeId = Schema.SObjectType.Investment_Area__c.getRecordTypeInfosByName().get('Standard Investment').getRecordTypeId();  
        Id planPartnerPlanRecordTypeId = Schema.SObjectType.Plan__c.getRecordTypeInfosByName().get('Partner Plan').getRecordTypeId();
        Id initiativePartnerPlanRecordTypeId = Schema.SObjectType.Initiative__c.getRecordTypeInfosByName().get('Partner Plan').getRecordTypeId(); 
        Id requirementInitiativeRequirementRecordTypeId = Schema.SObjectType.Requirement__c.getRecordTypeInfosByName().get('Initiative Requirement').getRecordTypeId(); 
        /*
        // Kahiwi Fixes - commented out code related to 'Organisation Requirement' record type
        Id orgRequirementRecordTypeId = Schema.SObjectType.Requirement__c.getRecordTypeInfosByName().get('Organisation Requirement').getRecordTypeId();        
        */
        Id paymentPaymentRecordTypeId = Schema.SObjectType.Payment__c.getRecordTypeInfosByName().get('Payment').getRecordTypeId(); 

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

        test.startTest(); 
        //create initiative requirements
        //Initiative Requirement // Pending
        List<Requirement__c> requirementsToCreateList = new List<Requirement__c>();
        for(Integer i=0; i<200; i++) {
            Requirement__c requirementObject = new Requirement__c();
            requirementObject.Initiative__c = initiativeObject.Id;
            requirementObject.RecordTypeId = requirementInitiativeRequirementRecordTypeId;
            requirementObject.Name = 'Test Initiative Requirement';
            requirementObject.Hold_Payments__c = true;
            requirementObject.Due_Date__c = date.today().addDays(1);
            requirementObject.Description__c = 'Test';
            requirementObject.Partner__c = accountObject.Id; 
            requirementsToCreateList.add(requirementObject); 
        }  
         
        insert requirementsToCreateList;   
        
        //!01 Test Insert Payment Trigger
        //List<Payment__c> paymentsToCreateList = new List<Payment__c>();
        //Create Bulk Payment
   /*     for(Integer i=0;i <500; i ++) {
            Payment__c paymentObject = new Payment__c();
            paymentObject.Partner__c = accountObject.Id; 
            paymentObject.RecordTypeId = paymentPaymentRecordTypeId;
            paymentObject.Initiative__c = initiativeObject.id;
            paymentObject.Date__c = date.today().addDays(5);
            paymentObject.Amount__c = 100;
            paymentsToCreateList.add(paymentObject);
        }
        insert paymentsToCreateList;
        
        Payment__c paymentObj = [Select Id, Date__c, Pending_Requirements__c From Payment__c LIMIT 1];
        system.assertEquals(true, paymentObj.pending_requirements__c);
*/
		/*
		// Kahiwi Fixes - commented out code related to 'Organisation Requirement' record type
        //Organization Requirement // Overdue Insert
        List<Requirement__c> orgRequirementsToCreateList = new List<Requirement__c>();
        for(Integer i=0; i<500; i++) {
            Requirement__c requirementObject = new Requirement__c();
            //requirementObject.Initiative__c = initiativeObject.Id; Not the same initiative
            requirementObject.RecordTypeId = orgRequirementRecordTypeId;
            requirementObject.Name = 'Test Org Requirement';
            requirementObject.Hold_Payments__c = true;
            requirementObject.Due_Date__c = date.today().addDays(-5); //overdue
            requirementObject.Description__c = 'Test';
            requirementObject.Partner__c = accountObject.Id; 
            requirementObject.Initiative__c = initiativeObject.Id;
            orgRequirementsToCreateList.add(requirementObject); 
        } 

        insert orgRequirementsToCreateList;
        */

 /*       //02 update the dates
        List<Payment__c> paymentsToUpdateList = new List<Payment__c>();
        for(Payment__c p : paymentsToCreateList) {
            p.Date__c = date.today().addDays(6);
            paymentsToUpdateList.add(p);
        }
        update paymentsToUpdateList;

         Payment__c paymentUpObj = [Select Id, Date__c, Overdue_Requirements__c, Pending_Requirements__c From Payment__c LIMIT 1];
         system.assertEquals(true, paymentUpObj.pending_requirements__c);
         system.assertEquals(true, paymentUpObj.Overdue_Requirements__c);

        delete paymentsToUpdateList;
        undelete paymentsToUpdateList;

        //03 delete pending reqs
        delete requirementsToCreateList;
        delete orgRequirementsToCreateList;
       Payment__c paymentDelObj = [Select Id, Date__c, Overdue_Requirements__c, Pending_Requirements__c From Payment__c LIMIT 1];
        system.assertEquals(false, paymentDelObj.pending_requirements__c);
        system.assertEquals(false, paymentDelObj.Overdue_Requirements__c);

        //04 undelete reqs
        undelete requirementsToCreateList;
        undelete orgRequirementsToCreateList;       
        Payment__c paymentUnDelObj = [Select Id, Date__c, Overdue_Requirements__c, Pending_Requirements__c From Payment__c LIMIT 1];
        system.assertEquals(true, paymentUnDelObj.pending_requirements__c);
        system.assertEquals(true, paymentUnDelObj.Overdue_Requirements__c);
        
   */     
        test.stopTest();
    }


    /**
    static testMethod void testCheckRequirementsMethod() {
        
        //Record Types
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Partner'].Id;
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Id requirementInitiativeRequirementRecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Id paymentPaymentRecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        
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
        insert requirementObject;
        
        //Test 2 - Pending Requirement
        List<Payment__c> insertedPayment2 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        System.assertEquals(insertedPayment2[0].pending_requirements__c,true);
        System.assertEquals(insertedPayment2[0].overdue_requirements__c,false);
        
        //Overdue Requirement
        Requirement__c requirementObject2 = new Requirement__c(id=requirementObject.Id);
        requirementObject2.Due_Date__c = date.today().addDays(-1);
        update requirementObject2;
        
        //Test 3 - Overdue Requirement
        List<Payment__c> insertedPayment3 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        System.assertEquals(insertedPayment3[0].pending_requirements__c,false);
        System.assertEquals(insertedPayment3[0].overdue_requirements__c,true);
        
        //Delete Requirement
        Requirement__c requirementObject3 = new Requirement__c(id=requirementObject.Id);    
        delete requirementObject3;
        
        //Test 4 - No Pending or Overdue Requirements
        List<Payment__c> insertedPayment4 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        System.assertEquals(insertedPayment4[0].pending_requirements__c,false);
        System.assertEquals(insertedPayment4[0].overdue_requirements__c,false);
        
        //Undelete Requirement      
        Requirement__c requirementObject4 = new Requirement__c(id=requirementObject.Id);
        undelete requirementObject4;
        
        //Test 5 - Overdue Requirement
        List<Payment__c> insertedPayment5 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        System.assertEquals(insertedPayment5[0].pending_requirements__c,false);
        System.assertEquals(insertedPayment5[0].overdue_requirements__c,true);
        
        //Complete Requirement
        Requirement__c requirementObject5 = new Requirement__c(id=requirementObject.Id);
        requirementObject5.Status__c = 'Completed';
        requirementObject5.Completed_Date__c = date.today();
        update requirementObject5;
        
        //Test 6 - No Pending or Overdue Requirements
        List<Payment__c> insertedPayment6 = [select pending_requirements__c, overdue_requirements__c from Payment__c where id=:paymentObject.id];
        System.assertEquals(insertedPayment6[0].pending_requirements__c,false);
        System.assertEquals(insertedPayment6[0].overdue_requirements__c,false); 
                
        Test.stopTest();
    }
    
    **/
}