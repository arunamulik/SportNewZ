@isTest(SeeAllData=true) 
private class TestInitiativeTrigger {

    static testMethod void initiativeCreate() {
        
        //Creating test data
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test Work';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        List<Account> accountToInsertList = new List<Account>();
        Account accountObject = new Account();
        accountObject.Name = 'Athletics NZ';
        accountObject.Type = 'National Sporting Organization';
        accountToInsertList.add(accountObject);

        Account accountObjectLimited = new Account();
        accountObjectLimited.Name = 'Athletics Limited ';
        accountObjectLimited.Type = 'National Sporting Organization';
        accountToInsertList.add(accountObjectLimited);
        
        insert accountToInsertList;
        
    
        
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Community Sport';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        insert strategicAreaObject;
        
        
        
        List<Plan__c> planObjectInsertList = new List<Plan__c>();

        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and DeveloperName = 'Partner_Plan'].Id;
        //planObject.investment_area__c = investmentAreaObject.id;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Draft';
        planObjectInsertList.add(planObject);

        Plan__c planObjectLimited = new Plan__c();
        planObjectLimited.Partner__c = accountObjectLimited.id;
        planObjectLimited.RecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and DeveloperName = 'Bundled_Plan' ].Id;
        //planObjectLimited.investment_area__c = investmentAreaObject.id;
        planObjectLimited.Start_Date__c = date.today();
        planObjectLimited.End_Date__c = date.today().addDays(5);
        planObjectLimited.Status__c = 'Draft';
        planObjectInsertList.add(planObjectLimited);
        
        insert planObjectInsertList;
        
        list<Investment_Area__c> investmentAreaList = new list<Investment_Area__c>();
        
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Sports NSO';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        investmentAreaList.add(investmentAreaObject);
        
        Investment_Area__c investmentAreaObject2 = new Investment_Area__c();
        investmentAreaObject2.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject2.Name = 'Sports NSO212';
        investmentAreaObject2.Start_Date__c = date.today();
        investmentAreaObject2.End_Date__c = date.today().addDays(5);
        investmentAreaObject2.Status__c = 'Active';
        investmentAreaList.add(investmentAreaObject2);
        insert investmentAreaList;
        
        list<Business_Case__c> BusLst = new list<Business_Case__c>();
        
        Business_Case__c businesscaseparentobject = new Business_Case__c();
        
        businesscaseparentobject.name= 'Testing Parent Business Case';
        businesscaseparentobject.Executive_Summary__c ='bla bla bla ';
        businesscaseparentobject.Status__c= 'Draft';
        businesscaseparentobject.Investment_Area__c = investmentAreaObject.id;
        Buslst.Add(businesscaseparentobject);
        
        Business_Case__c businesscaseChild1object = new Business_Case__c();
        
        businesscaseChild1object.name= 'Testing Parent Business Case';
        businesscaseChild1object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild1object.Parent_Business_Case__c= businesscaseparentobject.id;
        businesscaseChild1object.Status__c= 'Draft';
        businesscaseChild1object.Investment_Area__c = investmentAreaObject2.id;
       // businesscaseChild1object.Total_Amount__c = 0;
        Buslst.Add(businesscaseChild1object);
        
        Business_Case__c businesscaseChild2object = new Business_Case__c();
        
        businesscaseChild2object.name= 'Testing Parent Business Case';
        businesscaseChild2object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild2object.Status__c= 'Draft';
        businesscaseChild2object.Parent_Business_Case__c= businesscaseparentobject.id;
        businesscaseChild2object.Investment_Area__c = investmentAreaObject2.id;
        //businesscaseChild2object.Total_Amount__c = 0;
        Buslst.Add(businesscaseChild2object);
        
        insert Buslst;
        // Added on 27 june 2015
         updateInvestmentAreaTriggerHandler.isExecuted = false;
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='rajput', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
            
            insert usr;
            
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
        // End 27 june
        
        List<Initiative__c> initiativeObjectLst = new List<Initiative__c>();
        
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Name = 'Init';
        initiativeObject.RecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and DeveloperName = 'Bundled_Plan'].Id;
        //initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Investment_Area__c = iArea.Id;
        
        initiativeObject.Planned__c = 22132;
        initiativeObject.Business_Case__c = businesscaseChild1object.id;
        initiativeObject.Partner__c = accountObject.id;
        initiativeObject.Work_Brief__c = workObj.Id;
        //insert initiativeObject;
        initiativeObjectLst.add(initiativeObject);
        
        Initiative__c initiativeObjectLimited = new Initiative__c();
        initiativeObjectLimited.Plan__c = planObjectLimited.id;
        initiativeObjectLimited.Name = 'Init 2';
        initiativeObjectLimited.RecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and DeveloperName = 'Partner_Plan'].Id;
        initiativeObjectLimited.Investment_Area__c = investmentAreaObject2.id;
        initiativeObjectLimited.Planned__c = 34235;
        initiativeObjectLimited.Partner__c = accountObject.id;
        initiativeObjectLimited.Work_Brief__c = workObj.Id;
        initiativeObjectLimited.Business_Case__c = businesscaseChild2object.id;
        initiativeObjectLst.add(initiativeObjectLimited);
        system.debug('@@@@ initiavie : ' + initiativeObjectLst);
        insert initiativeObjectLst;
        
    
        planObject.investment_area__c = investmentAreaObject.id;
        update planObject;
        
        planObjectLimited.investment_area__c = investmentAreaObject2.id;
        update planObjectLimited;
        
        
        Test.startTest();
        
        list<Payment__c> payList = new list<Payment__c>();
   /*     
        Payment__c paymentobject = new Payment__c();
        paymentobject.Amount__c = 343;
        paymentobject.Date__c = Date.Today().addDays(10); 
        paymentobject.Partner__c = accountobject.Id;
        paymentobject.Status__c ='On Hold' ;
        paymentobject.Hold_reason__c= 'Overdue Requirement (Initiative)';
        //paymentobject.Initiative__c = initiativeObject.id;
        paymentobject.Initiative__c = initiativeObjectLst[0].Id;
        payList.add(paymentobject);
        
        
        Payment__c paymentobject2 = new Payment__c();
        paymentobject2.Amount__c = 343;
        paymentobject2.Date__c = Date.Today().addDays(10);       
        paymentobject2.Partner__c = accountobject.Id;
        paymentobject2.Status__c ='On Hold' ;
        paymentobject2.Hold_reason__c= 'Overdue Requirement (Organization)';
        paymentobject2.Initiative__c = initiativeObject.id;
        payList.add(paymentobject2);
        
        Payment__c paymentobject3 = new Payment__c();
        paymentobject3.Amount__c = 343;
        paymentobject3.Date__c =Date.Today().addDays(10);       
        paymentobject3.Partner__c = accountobject.Id;
        paymentobject3.Status__c ='On Hold' ;
        paymentobject3.Hold_reason__c= 'Overdue Requirement (Organization)';
        paymentobject3.Initiative__c = initiativeObject.id;
        payList.add(paymentobject3);
        
        Payment__c paymentobject4 = new Payment__c();
        paymentobject4.Amount__c = 343;
        paymentobject4.Date__c = Date.Today().addDays(10);       
        paymentobject4.Partner__c = accountobject.Id;
        paymentobject4.Status__c ='Scheduled' ;
        paymentobject4.Hold_reason__c= 'On Hold';
        paymentobject4.Initiative__c = initiativeObject.id;
        payList.add(paymentobject4);
        
        Payment__c paymentobject5 = new Payment__c();
        paymentobject5.Amount__c = 343;
        paymentobject5.Date__c = Date.Today().addDays(10);       
        paymentobject5.Partner__c = accountobject.Id;
        paymentobject5.Status__c ='Scheduled' ;
         paymentobject5.Hold_reason__c= 'On Hold';
        paymentobject5.Initiative__c = initiativeObject.id;
        payList.add(paymentobject5);
       
       
        insert payList;
        */ 
        
        
        list<Requirement__c> ReqList = new list<Requirement__c>();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Name = 'Testing';
        requirementobject.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(10);       
        requirementobject.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        requirementobject.Initiative__c = initiativeObject.id;
        requirementobject.Partner__c = accountObject.id;
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = initiativeObjectLst[0].Id;
        
        ReqList.add(requirementobject);
        
        Requirement__c requirementobject2 = new Requirement__c();
        requirementobject2.Name = 'Testing';
        requirementobject2.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject2.Description__c ='Description Testing the test class';
        requirementobject2.Due_Date__c = Date.Today().addDays(10);       
        requirementobject2.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and DeveloperName = 'Initiative_Requirement'].Id;
        requirementobject2.Initiative__c = initiativeObject.id;
        requirementobject2.Partner__c = accountObject.id;
        requirementobject2.Status__c = 'Overdue';
        requirementobject2.Hold_Payments__c = true;
        requirementObject2.Initiative__c = initiativeObjectLst[0].Id;
        
        ReqList.add(requirementobject2);
        
        Requirement__c requirementobject3 = new Requirement__c();
        requirementobject3.Name = 'Testing';
        requirementobject3.Comments__c = 'Comments Testing rthe Test Class';
       requirementobject3.Description__c ='Description Testing the test class';
        requirementobject3.Due_Date__c = Date.Today().addDays(10);                                                                     
        requirementobject3.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and DeveloperName = 'Initiative_Requirement'].Id;
        requirementobject3.Status__c = 'Overdue';
        requirementobject3.Hold_Payments__c = true;
        //requirementobject3.Partner__c = accountobject.Id;
        //requirementobject2.Initiative__c = initiativeObject.id;
        requirementObject3.Initiative__c = initiativeObjectLst[0].Id;
    
            ReqList.add(requirementobject3);
        
        Requirement__c requirementobject4 = new Requirement__c();
        requirementobject4.Name = 'Testing';
        requirementobject4.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject4.Description__c ='Description Testing the test class';
        requirementobject4.Due_Date__c = Date.Today().addDays(10);                                                                    
        //requirementobject4.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and DeveloperName = 'Organisation_Requirement'].Id;
        requirementobject4.Status__c = 'Overdue';
        requirementobject4.Hold_Payments__c = true;
        requirementobject4.Partner__c = accountobject.Id;
        requirementobject4.Plan__c = planObject.id;
        requirementObject4.Initiative__c = initiativeObjectLst[0].Id;
        
        ReqList.add(requirementobject4);
        
        Requirement__c requirementobject5 = new Requirement__c();
        requirementobject5.Name = 'Testing';
        requirementobject5.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject5.Description__c ='Description Testing the test class';
        requirementobject5.Due_Date__c = Date.Today().addDays(10);                                                                       
        //requirementobject5.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and DeveloperName = 'Organisation_Requirement'].Id;
        requirementobject5.Status__c = 'Overdue';
        requirementobject5.Hold_Payments__c = true;
        requirementobject5.Partner__c = accountobject.Id;
        requirementObject5.Initiative__c = initiativeObjectLst[0].Id; 
        requirementobject5.Plan__c = planObject.id;
            ReqList.add(requirementobject5);
        
        Requirement__c requirementobject6 = new Requirement__c();
        requirementobject6.Name = 'Testing';
        requirementobject6.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject6.Description__c ='Description Testing the test class';
        requirementobject6.Due_Date__c = Date.Today().addDays(10);                                                                 
        //requirementobject6.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and DeveloperName = 'Organisation_Requirement'].Id;
        requirementobject6.Status__c = 'Overdue';
        requirementobject6.Hold_Payments__c = true;
        requirementobject6.Partner__c = accountobject.Id;
        requirementObject6.Initiative__c = initiativeObjectLst[0].Id;
        requirementobject6.Plan__c = planObject.id;
        
        ReqList.add(requirementobject6);
        
        insert ReqList;
        
        Measure__c measureobject = new Measure__c();
        
        measureobject.Name = 'Testing Test Class';
        //No longer required - DH 22/09/2014
        //measureobject.Requirement__c =requirementobject6.id;
        measureobject.RecordTypeid = [Select Id From Recordtype where sobjecttype = 'Measure__c' and DeveloperName = 'Percent'].Id;
        measureobject.Status__c ='Pending';
        
        
        
    
        
        
        insert measureobject; 
        List<Initiative__c> initiativeList = [Select Id, Partner__r.Id from Initiative__c where id=:initiativeObject.id];
        if(initiativeList.size() > 0){
            //System.assertEquals(initiativeList.get(0).Partner__r.id, accountObject.id);
        }
        
        //before update
        initiativeObject.Plan__c = planObjectLimited.id;
        update initiativeObject;
        
        initiativeObjectLimited.Plan__c = planObjectLimited.id;
        update initiativeObjectLimited;
        
        businesscaseChild1object.Parent_Business_Case__c= businesscaseparentobject.id;
        update businesscaseChild1object;
      
            businesscaseChild2object.Parent_Business_Case__c= businesscaseparentobject.id;
        update businesscaseChild2object;
          
      /*  requirementobject.Status__c ='Completed';
        requirementobject.Completed_Date__c = date.today();
        update requirementobject;
        
        requirementobject3.Status__c ='Completed';
        requirementobject3.Completed_Date__c = date.today();
        update requirementobject3;
      */  
        requirementobject4.status__c ='Overdue';        
        update requirementobject4;
       /* 
        requirementobject5.Status__c ='Completed';
        requirementobject5.Completed_Date__c = date.today();
        update requirementobject5;
       */ 
        requirementobject6.status__c ='Overdue';
        update requirementobject6;
        //assert calls
        List<Initiative__c> initiativeLimitedList = [Select Id, Partner__r.Id from Initiative__c where id=:initiativeObject.id];
        if(initiativeLimitedList.size() > 0){
            //System.assertEquals(initiativeLimitedList.get(0).Partner__r.id, accountObjectLimited.id);
        }
        Test.stopTest();
        
    }
    
    static testMethod void initiativeCreate2() {
        Account accountObject = new Account();
        accountObject.Name = 'Athletics NZ';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;

        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Community Sport';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        insert strategicAreaObject;
        
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Sports NSO';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        
        Investment_Area__c investmentAreaObject2 = new Investment_Area__c();
        investmentAreaObject2.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject2.Name = 'Sports RSO';
        investmentAreaObject2.Start_Date__c = date.today();
        investmentAreaObject2.End_Date__c = date.today().addDays(5);
        investmentAreaObject2.Status__c = 'Active';
        insert investmentAreaObject2;
        
         Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 100000;
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
        
                Investment_Area_Allocation__c objInv2 = new Investment_Area_Allocation__c();
        objInv2.Investment_Area__c = investmentAreaObject2.id;
        objInv2.Funding_Allocation__c = objFund.id;
        objInv2.Amount__c = 10000;
        objInv2.Status__c= 'Active';
        insert objInv2;
        
        
        Plan__c partnerPlanObject = new Plan__c();
        partnerPlanObject.Partner__c = accountObject.id;
        partnerPlanObject.RecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and DeveloperName = 'Partner_Plan'].Id;
        partnerPlanObject.Start_Date__c = date.today();
        partnerPlanObject.End_Date__c = date.today().addDays(5);
        partnerPlanObject.Status__c = 'Draft';
        insert partnerPlanObject;
        
        Plan__c bundledPlanObject = new Plan__c();
        bundledPlanObject.Investment_Area__c = investmentAreaObject.id;
        bundledPlanObject.RecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and DeveloperName = 'Bundled_Plan'].Id;
        bundledPlanObject.Start_Date__c = date.today();
        bundledPlanObject.End_Date__c = date.today().addDays(5);
        bundledPlanObject.Status__c = 'Draft';
        insert bundledPlanObject;
        
        //Creating test data
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test Work';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        Initiative__c partnerInitiative = new Initiative__c();
        partnerInitiative.Plan__c = partnerPlanObject.Id;
        partnerInitiative.Name = 'Test';
        partnerInitiative.RecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and DeveloperName = 'Partner_Plan'].Id;
        partnerInitiative.Investment_Area__c = investmentAreaObject.id;
        partnerInitiative.Work_Brief__c = workObj.Id;
        insert partnerInitiative;
        
        Initiative__c bundledInitiative = new Initiative__c();
        bundledInitiative.Plan__c = bundledPlanObject.Id;
        bundledInitiative.Name = 'Test';
        bundledInitiative.Work_Brief__c = workObj.Id;
        bundledInitiative.RecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and DeveloperName = 'Bundled_Plan'].Id;
        bundledInitiative.Investment_Area__c = investmentAreaObject2.id;
        insert bundledInitiative;
        
        Test.startTest();
        
        List<Initiative__c> testPartner = [SELECT Partner__c FROM Initiative__c WHERE Id =: partnerInitiative.Id];
        List<Initiative__c> testBundled = [SELECT Investment_Area__c FROM Initiative__c WHERE Id =: bundledInitiative.Id];
        
        System.AssertEquals(testPartner[0].Partner__c,accountObject.Id);
        //System.AssertEquals(testBundled[0].Investment_Area__c,investmentAreaObject.Id);
    
        Test.stopTest();
        
    }
    
    static testMethod void initiativeWithVariation() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
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
        
        
        Variation__c objVariation1 = RUL_Util.createVariation()[0];
        objVariation1.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation1;
        
         //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        Initiative__c initiativeObject2 = new Initiative__c();
        initiativeObject2.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject2.Name = 'Test Initiative -1';
        initiativeObject2.Plan__c = planObject.id;
        initiativeObject2.Type__c = 'Paid to Partner';
        initiativeObject2.Start_Date__c = date.today();
        initiativeObject2.End_Date__c = date.today().addDays(5);
        initiativeObject2.Requested__c = 100;
        initiativeObject2.Planned__c = 1000;
        initiativeObject2.Priority__c = 'Must';
        initiativeObject2.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject2.Investment_Area__c = investmentAreaObject.id;
        initiativeObject2.Business_Case__c = businessCaseObject.id;
        initiativeObject2.Investment_Schedule_Variation__c = objVariation1.Id;
        initiativeObject2.Work_Brief__c = workObj.Id;
       // initiativeObject2.Initiative_Verified_del__c = true;
        insert initiativeObject2;
       
       Payment__c objPayment2 = new Payment__c();
       objPayment2.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       objPayment2.Status__c = 'Paid';
       objPayment2.Amount__c = 100;
       objPayment2.Date__c = Date.Today();
       objPayment2.Initiative__c = initiativeObject2.Id;
       insert objPayment2;
       
       List<Requirement__c> requirements1 = RUL_Util.createRequirements(5);
       for(Requirement__c objRequirement : requirements1){
           objRequirement.Name = 'Testing';
           objRequirement.Initiative__c = initiativeObject2.Id;
           objRequirement.Status__c = 'Completed';
           objRequirement.Completed_Date__c = Date.today();
       }
       
      
       List<Measure__c> measures1 = RUL_Util.createMeasures(5);
       for(Measure__c objMeasure : measures1){
           objMeasure.Name = 'Testing';
           objMeasure.Partner__c = accountObject.Id;
           objMeasure.Initiative__c = initiativeObject2.Id;
           objMeasure.Status__c = 'Met';
       }
       
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
        
         //Create Initiatives
        
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Initiative Record';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 1000;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        initiativeObject.Work_Brief__c = workObj.Id;
       // initiativeObject.Initiative_Verified_del__c = true;
        insert initiativeObject;
       
       Payment__c objPayment = new Payment__c();
       objPayment.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       objPayment.Status__c = 'Paid';
       objPayment.Amount__c = 100;
       objPayment.Date__c = Date.Today();
       objPayment.Initiative__c = initiativeObject.Id;
       insert objPayment;
       
       List<Requirement__c> requirements = RUL_Util.createRequirements(5);
       for(Requirement__c objRequirement : requirements){
           objRequirement.Initiative__c = initiativeObject.Id;
           objRequirement.Status__c = 'Completed';
           objRequirement.Completed_Date__c = Date.today();
       }
       
      
       List<Measure__c> measures = RUL_Util.createMeasures(5);
       for(Measure__c objMeasure : measures){
           objMeasure.Partner__c = accountObject.Id;
           objMeasure.Initiative__c = initiativeObject.Id;
           objMeasure.Status__c = 'Met';
       }
       
       

         //Create Initiatives
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'New Initiative';
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
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        initiativeObject1.Work_Brief__c = workObj.Id;
        //initiativeObject1.Initiative_Verified_del__c = true;
        insert initiativeObject1;
       
       Payment__c objPayment1 = new Payment__c();
       objPayment1.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       objPayment1.Status__c = 'Paid';
       objPayment1.Amount__c = 100;
       objPayment1.Date__c = Date.Today();
       objPayment1.Initiative__c = initiativeObject1.Id;
       insert objPayment1;
       
     
       for(Requirement__c objRequirement : requirements){
           objRequirement.Initiative__c = initiativeObject1.Id;
           objRequirement.Status__c = 'Completed';
           objRequirement.Completed_Date__c = Date.today();
       }
       insert requirements;
      
       
       for(Measure__c objMeasure : measures){
           objMeasure.Partner__c = accountObject.Id;
           objMeasure.Initiative__c = initiativeObject1.Id;
           objMeasure.Status__c = 'Met';
       }
       insert measures;

       Test.startTest();
        //initiativeObject1.End_Date__c = date.today().addDays(1);
        //update initiativeObject1;
        businessCaseObject.Status__c = 'Approved';
        update businessCaseObject;
       Test.stopTest();
        
    }
    static testMethod void initiativeWithCompleted() {
        
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
       // investmentAreaObject.a
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
        businessCaseObject.Status__c = 'Being Varied';
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
        //Creating test data
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test Work';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Id initiativePartnerPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Read Only Initiative'].Id;
        Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 1000;
        initiativeObject1.Work_Brief__c = workObj.Id;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Old_RecordTypeID__c =initiativeProjectPlanRecordTypeId1;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        //initiativeObject1.Initiative_Verified_del__c = true;
        initiatives.add(initiativeObject1);
        
        //Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject.Name = 'New Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 1000;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
        initiativeObject.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Old_RecordTypeID__c = initiativeProjectPlanRecordTypeId1;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
       // initiativeObject.Initiative_Verified_del__c = true;
        initiatives.add(initiativeObject);
        insert initiatives;
        
       List<Payment__c> payments = new List<Payment__c>();
       Payment__c objPayment2 = new Payment__c();
       objPayment2.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment2.Status__c = 'Paid';
       objPayment2.Amount__c = 100;
       objPayment2.Date__c = Date.Today();
       objPayment2.Initiative__c = initiatives[0].Id;
       objPayment2.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       payments.add(objPayment2);
       
       Payment__c objPayment1 = new Payment__c();
       objPayment1.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment1.Status__c = 'Paid';
       objPayment1.Amount__c = 200;
       objPayment1.Date__c = Date.Today();
       objPayment1.Initiative__c = initiatives[0].Id;
       objPayment1.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       payments.add(objPayment1);
       
        Payment__c objPayment = new Payment__c();
       objPayment.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment.Status__c = 'Paid';
       objPayment.Amount__c = 300;
       objPayment.Date__c = Date.Today();
       objPayment.Initiative__c = initiatives[1].Id;
       objPayment.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       payments.add(objPayment);
       
        Payment__c objPayment3 = new Payment__c();
       objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment3.Status__c = 'Paid';
       objPayment3.Amount__c = 100;
       objPayment3.Date__c = Date.Today();
       objPayment3.Initiative__c = initiatives[1].Id;
       objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       payments.add(objPayment3);
       
       Test.startTest();
        insert payments;
        
        for(Initiative__c objInitiative : initiatives){
            objInitiative.RecordTypeId = initiativeProjectPlanRecordTypeId1;
        }
        update initiatives;
        
        Test.stopTest();
       
       
       
       /*
       List<Requirement__c> requirements1 = RUL_Util.createRequirements(1);
       for(Requirement__c objRequirement : requirements1){
           objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'RUL Read Only'].Id;
           objRequirement.Initiative__c = initiativeObject1.Id;
           objRequirement.Status__c = 'Completed';
           objRequirement.Completed_Date__c = Date.today();
           objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
       }
       insert requirements1;
      
       List<Measure__c> measures1 = RUL_Util.createMeasures(1);
       for(Measure__c objMeasure : measures1){
            objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'RUL Text Read Only'].Id;
			objMeasure.Partner__c = accountObject.Id;
           objMeasure.Initiative__c = initiativeObject1.Id;
           objMeasure.Status__c = 'Met';
           objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       }
       insert measures1;
       
       Test.startTest();
           initiativeObject1.Name = 'Testing Initiative 2 ----';
          initiativeObject1.RecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
          update initiativeObject1;
        
        Test.stopTest();*/
    }
    
    static testMethod void initiativeWithInCompletedPayments() {
        
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
        businessCaseObject.Status__c = 'Being Varied';
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
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Id initiativePartnerPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Read Only Initiative'].Id;
        Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.Work_Brief__c = workObj.Id;
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 10000;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Work_Brief__c = workObj.Id;
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Old_RecordTypeID__c =initiativeProjectPlanRecordTypeId1;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        //initiativeObject1.Initiative_Verified_del__c = false;
        initiatives.add(initiativeObject1);
        
        //Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject.Name = 'New Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 10000;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
        initiativeObject.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Old_RecordTypeID__c = initiativeProjectPlanRecordTypeId1;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        //initiativeObject.Initiative_Verified_del__c = false;
        
        initiatives.add(initiativeObject);
        insert initiatives;
        
        List<Payment__c> payments = new List<Payment__c>();
        Payment__c objPayment2 = new Payment__c();
        objPayment2.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
        objPayment2.Status__c = 'Draft';
        objPayment2.Amount__c = 100;
        objPayment2.Date__c = Date.Today();
        objPayment2.Initiative__c = initiatives[0].Id;
        objPayment2.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        payments.add(objPayment2);
       
        Payment__c objPayment1 = new Payment__c();
       objPayment1.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment1.Status__c = 'Draft';
       objPayment1.Amount__c = 100;
       objPayment1.Date__c = Date.Today();
       objPayment1.Initiative__c = initiatives[0].Id;
       objPayment1.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       payments.add(objPayment1);
       
        Payment__c objPayment = new Payment__c();
       objPayment.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment.Status__c = 'Draft';
       objPayment.Amount__c = 100;
       objPayment.Date__c = Date.Today();
       objPayment.Initiative__c = initiatives[1].Id;
       objPayment.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       payments.add(objPayment);
       
       Payment__c objPayment3 = new Payment__c();
       objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment3.Status__c = 'Draft';
       objPayment3.Amount__c = 100;
       objPayment3.Date__c = Date.Today();
       objPayment3.Initiative__c = initiatives[1].Id;
       objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
       payments.add(objPayment3);
       
       Test.startTest();
        insert payments;
       
        for(Initiative__c objInitiative : initiatives){
            objInitiative.RecordTypeId = initiativeProjectPlanRecordTypeId1;
        }
        update initiatives;
        
        Test.stopTest();
    }
    
    static testMethod void initiativeWithInCompletedRequirements() {
        
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
        businessCaseObject.Status__c = 'Being Varied';
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
        
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Id initiativePartnerPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Read Only Initiative'].Id;
        Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject1.Name = 'Test Initiative';
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
        initiativeObject1.Work_Brief__c = workObj.Id;
        initiativeObject1.Old_RecordTypeID__c =initiativeProjectPlanRecordTypeId1;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        //initiativeObject1.Initiative_Verified_del__c = false;
        initiatives.add(initiativeObject1);
        
        //Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject.Name = 'New Initiative';
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 100;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Work_Brief__c = workObj.Id;
        initiativeObject.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Old_RecordTypeID__c = initiativeProjectPlanRecordTypeId1;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        //initiativeObject.Initiative_Verified_del__c = false;
        initiatives.add(initiativeObject);
        insert initiatives;
        
       List<Requirement__c> requirements1 = RUL_Util.createRequirements(1);
       for(Requirement__c objRequirement : requirements1){
           objRequirement.Name = 'Testing';
           objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Read Only'].Id;
           objRequirement.Initiative__c = initiatives[1].Id;
           objRequirement.Status__c = 'Pending';
           objRequirement.Completed_Date__c = Date.today();
           objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
       }
       
       Test.startTest();

        insert requirements1;

        for(Initiative__c objInitiative : initiatives){
            objInitiative.RecordTypeId = initiativeProjectPlanRecordTypeId1;
        }
        update initiatives;
        
        Test.stopTest();
    }
    
        static testMethod void initiativeWithInCompletedMeasures() {
        
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
        businessCaseObject.Status__c = 'Being Varied';
        insert businessCaseObject;
        
        Work_Brief__c workObj = new Work_Brief__c();
            workObj.Name = 'Test';
            workObj.Stage__c = 'Active';
            insert workObj;
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
        
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Id initiativePartnerPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Read Only Initiative'].Id;
        Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject1.Name = 'Test Initiative';
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
            initiativeObject1.Work_Brief__c = workObj.Id;
        initiativeObject1.Old_RecordTypeID__c =initiativeProjectPlanRecordTypeId1;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        //initiativeObject1.Initiative_Verified_del__c = false;
        initiatives.add(initiativeObject1);
        
        //Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject.Name = 'New Initiative';
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
        initiativeObject.Old_RecordTypeID__c = initiativeProjectPlanRecordTypeId1;
            initiativeObject.Work_Brief__c = workObj.Id;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        //initiativeObject.Initiative_Verified_del__c = false;
        initiatives.add(initiativeObject);
        insert initiatives;
        
       List<Measure__c> measures1 = RUL_Util.createMeasures(1);
       for(Measure__c objMeasure : measures1){
           objMeasure.name = 'Testing';
            objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text Read Only'].Id;
            objMeasure.Partner__c = accountObject.Id;
           objMeasure.Initiative__c = initiatives[0].Id;
           objMeasure.Status__c = 'Not Met';
           objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       }
       
       
       
       Test.startTest();
      
        insert measures1;
        RecursionHandler.TrgInitiativeBypassAfter = false;
        RecursionHandler.executionCount = 0;
        for(Initiative__c objInitiative : initiatives){
            objInitiative.RecordTypeId = initiativeProjectPlanRecordTypeId1;
        }
        update initiatives;
        
        Test.stopTest();
    }
    
    
    static testMethod void initiativeWithInCompletedAll() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
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
        businessCaseObject.Status__c = 'Being Varied';
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
        
        
        
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Id initiativePartnerPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Read Only Initiative'].Id;
        Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Work_Brief__c = workObj.Id;
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Old_RecordTypeID__c =initiativeProjectPlanRecordTypeId1;
        
       // initiativeObject1.Initiative_Verified_del__c = false;
        insert initiativeObject1;

       Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
       objMeasure.Name = 'Testing';
       objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text Read Only'].Id;
       objMeasure.Partner__c = accountObject.Id;
       objMeasure.Initiative__c = initiativeObject1.Id;
       objMeasure.Status__c = 'Not Met';
       objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       
       Payment__c objPayment3 = new Payment__c();
       objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment3.Status__c = 'Draft';
       objPayment3.Amount__c = 100;
       objPayment3.Date__c = Date.Today();
       objPayment3.Initiative__c = initiativeObject1.Id;
       objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
      
       
       
       Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
       
       objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Read Only'].Id;
       objRequirement.Initiative__c = initiativeObject1.Id;
       objRequirement.Status__c = 'Pending';
       objRequirement.Completed_Date__c = Date.today();
       objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
      
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
       
       insert objPayment3;
       insert objRequirement;
       insert objMeasure;
       
       Test.startTest();
           RecursionHandler.TrgInitiativeBypassAfter = false;
           RecursionHandler.executionCount = 0;
		   initiativeObject1.RecordTypeId = initiativeProjectPlanRecordTypeId1;
		   initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
		   update initiativeObject1;
        Test.stopTest();
    }
    static testMethod void newInitiativeWithInCompletedAll() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        
        Work_Brief__c workObj = new Work_Brief__c();
            workObj.Name = 'Test';
            workObj.Stage__c = 'Active';
            insert workObj;
        
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
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
         objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Plan__c planObject1 = new Plan__c();
        planObject1.Partner__c = accountObject.id;
        planObject1.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject1.Start_Date__c = date.today();
        planObject1.End_Date__c = date.today().addDays(5);
        planObject1.Status__c = 'Active';
        insert planObject1;
        
        
        
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Id initiativePartnerPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Read Only Initiative'].Id;
        Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
		initiativeObject1.Partner__c = accountObject.id;        
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 1000;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Old_RecordTypeID__c =initiativeProjectPlanRecordTypeId1;
        initiativeObject1.Work_Brief__c = workObj.Id;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        
       // initiativeObject1.Initiative_Verified_del__c = false;
        insert initiativeObject1;

       Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
       objMeasure.name='Testing';
       objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text Read Only'].Id;
       objMeasure.Partner__c = accountObject.Id;
       objMeasure.Initiative__c = initiativeObject1.Id;
       objMeasure.Status__c = 'Not Met';
        
       objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       
       Payment__c objPayment3 = new Payment__c();
       objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment3.Status__c = 'Draft';
       objPayment3.Amount__c = 100;
       objPayment3.Date__c = Date.Today();
       objPayment3.Initiative__c = initiativeObject1.Id;
       objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
      
       
       
       Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
       objRequirement.name = 'Testing';
       objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Read Only'].Id;
       objRequirement.Initiative__c = initiativeObject1.Id;
       objRequirement.Status__c = 'Pending';
       objRequirement.Completed_Date__c = Date.today();
       objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
      
        
       
       insert objPayment3;
       insert objRequirement;
       insert objMeasure;
       
       Test.startTest();
        	List<Initiative__c> listInit = new List<initiative__c>([Select id, name,plan__c from initiative__c where id =: initiativeObject1.id]);
        	//listInit[0].Description__c= 'Testing';
        listInit[0].plan__c= planObject1.id;
        	update listInit;
           RecursionHandler.TrgInitiativeBypassAfter = false;
           RecursionHandler.executionCount = 0;
		   initiativeObject1.RecordTypeId = initiativeProjectPlanRecordTypeId1;
		   initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
		   update initiativeObject1;
        Test.stopTest();
    }
     static testMethod void newInitiativeWithInCompletedAll1() {
        
        //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
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
        businessCaseObject.Status__c = 'Being Varied';
        insert businessCaseObject;
         
          Business_Case__c businessCaseObject1 = new Business_Case__c();
        businessCaseObject1.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject1.Name = 'Test Business Case';
        businessCaseObject1.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject1.Approval_Type__c = 'Manager Delegation';
        businessCaseObject1.Status__c = 'Being Varied';
        insert businessCaseObject1;
         
         Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
         objVariation.Is_Active__c = true;
        insert objVariation;
        
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
        
        
        
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Id initiativePartnerPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Read Only Initiative'].Id;
        Id initiativeProjectPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId1;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
         initiativeObject1.Work_Brief__c = workObj.Id;
        initiativeObject1.Initiative_Owner__c = UserInfo.getUserId();
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Old_RecordTypeID__c =initiativeProjectPlanRecordTypeId1;
        
       // initiativeObject1.Initiative_Verified_del__c = false;
        insert initiativeObject1;

       Measure__c objMeasure = RUL_Util.createMeasures(1)[0];
       objMeasure.Name = 'Testing';
       objMeasure.RecordTypeId = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text Read Only'].Id;
       objMeasure.Partner__c = accountObject.Id;
       objMeasure.Initiative__c = initiativeObject1.Id;
       objMeasure.Status__c = 'Not Met';
       objMeasure.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Measure__c' and Name = 'Text'].Id;
       
       Payment__c objPayment3 = new Payment__c();
       objPayment3.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment Read Only'].Id;
       objPayment3.Status__c = 'Draft';
       objPayment3.Amount__c = 100;
       objPayment3.Date__c = Date.Today();
       objPayment3.Initiative__c = initiativeObject1.Id;
       objPayment3.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
      
       
       
       Requirement__c objRequirement = RUL_Util.createRequirements(1)[0];
       
       objRequirement.RecordTypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Read Only'].Id;
       objRequirement.Initiative__c = initiativeObject1.Id;
       objRequirement.Status__c = 'Pending';
       objRequirement.Completed_Date__c = Date.today();
       objRequirement.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
      
        
       insert objPayment3;
       insert objRequirement;
       insert objMeasure;
       
       Test.startTest();
           RecursionHandler.TrgInitiativeBypassAfter = false;
           RecursionHandler.executionCount = 0;
		   initiativeObject1.RecordTypeId = initiativeProjectPlanRecordTypeId1;
          // initiativeObject1.Description__c='test 2';
         initiativeObject1.Business_Case__c = businessCaseObject1.id;
		   //initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
		   update initiativeObject1;
         
       
        Test.stopTest();
    }
    
}