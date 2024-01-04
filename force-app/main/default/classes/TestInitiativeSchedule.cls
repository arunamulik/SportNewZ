@isTest
public class TestInitiativeSchedule {
                                   
    public static testMethod void testInitiativeScheduleExtension() {  
        
        List<RecordType> planIdList = ([SELECT Id 
                                          FROM RecordType 
                                         WHERE sobjectType = 'Plan__c' AND DeveloperName = 'Partner_Plan']);
        List<RecordType> initiativeIdList = [SELECT Id 
                                               FROM RecordType 
                                              WHERE sobjectType = 'Initiative__c' AND DeveloperName = 'Bundled_Plan'];
        List<RecordType> requirementIdList = [SELECT Id 
                                                FROM RecordType 
                                               WHERE sobjectType = 'Requirement__c' AND Name = 'Initiative Requirement'];
        List<RecordType> measureIdList = [SELECT Id 
                                            FROM Recordtype 
                                           WHERE sobjecttype = 'Measure__c' AND DeveloperName = 'Percent'];
        List<Profile> profileIdList = [SELECT Id 
                                         FROM Profile 
                                        WHERE Name='Standard User'];    
                                   
        List<Account> accountToInsertList = new List<Account>();
        Account accountObject = new Account();
        accountObject.Name = 'Athletics NZ';
        accountObject.Type = 'National Sporting Organization';
        accountToInsertList.add(accountObject);
        insert accountToInsertList;
    
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Community Sport';
        strategicAreaObject.Name = 'Active';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        insert strategicAreaObject;
        
        List<Plan__c> planObjectInsertList = new List<Plan__c>();
        
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planIdList[0].Id;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Draft';
        planObjectInsertList.add(planObject);
        insert planObjectInsertList;
        
        list<Investment_Area__c> investmentAreaList = new list<Investment_Area__c>();
        
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Sports NSO';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        investmentAreaList.add(investmentAreaObject);
        insert investmentAreaList;
        
        list<Business_Case__c> BusLst = new list<Business_Case__c>();
        
        Business_Case__c businesscaseparentobject = new Business_Case__c();
        
        businesscaseparentobject.name= 'Testing Parent Business Case';
        businesscaseparentobject.Executive_Summary__c ='bla bla bla ';
        businesscaseparentobject.Status__c= 'Draft';
        businesscaseparentobject.Investment_Area__c = investmentAreaObject.id;
        Buslst.Add(businesscaseparentobject);
        insert Buslst;
        
        updateInvestmentAreaTriggerHandler.isExecuted = false;
        Profile p = profileIdList[0]; 
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
        fAllocation.Financial_Year__c = '2015/16';
        fAllocation.Funding_Allocation_End_Date__c = system.Today().addDays(90);
        fAllocation.Funding_Allocation_Start_Date__c = system.Today();
        fAllocation.Funding_Amount__c = 50000;
        fAllocation.Strategic_Area__c = sArea.Id;
        
        insert fAllocation;
        
        Investment_Area_Allocation__c invAreaAllocation = new Investment_Area_Allocation__c();
        invAreaAllocation.Amount__c = 40000;
        invAreaAllocation.Investment_Area__c = iArea.Id;
        invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
        invAreaAllocation.Status__c = 'Draft';
        
        insert invAreaAllocation;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name='Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        List<Initiative__c> initiativeObjectLst = new List<Initiative__c>();
        
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Start_Date__c = Date.Today();
        initiativeObject.Name = 'Init';
        initiativeObject.RecordTypeId = initiativeIdList[0].Id;
        initiativeObject.Investment_Area__c = iArea.Id;
        initiativeObject.Work_Brief__c = workObj.Id;
        initiativeObject.Planned__c = 22132;
        initiativeObject.Business_Case__c = businesscaseparentobject.id;
        initiativeObject.Partner__c = accountObject.id;
        initiativeObjectLst.add(initiativeObject);
        
        Initiative__c initiativeObjectLimited = new Initiative__c();
        initiativeObjectLimited.Start_Date__c = Date.Today();
        initiativeObjectLimited.Plan__c = planObject.id;
        initiativeObjectLimited.Name = 'Init 2';
        initiativeObjectLimited.RecordTypeId = initiativeIdList[0].Id;
        initiativeObjectLimited.Investment_Area__c = iArea.id;
        initiativeObjectLimited.Planned__c = 34235;
        initiativeObjectLimited.Work_Brief__c = workObj.Id;
        initiativeObjectLimited.Partner__c = accountObject.id;
        initiativeObjectLimited.Business_Case__c = businesscaseparentobject.id;
        initiativeObjectLst.add(initiativeObjectLimited);
        insert initiativeObjectLst;
        
        
        list<Payment__c> payList = new list<Payment__c>();
        
        Payment__c paymentobject = new Payment__c();
        paymentobject.Amount__c = 343;
        paymentobject.Date__c = Date.Today().addDays(10); 
        paymentobject.Partner__c = accountobject.Id;
        paymentobject.Status__c ='Active';
        paymentobject.Initiative__c = initiativeObject.id;
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
        
        list<Requirement__c> ReqList = new list<Requirement__c>();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Name = 'Requirement';
        requirementobject.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(10);       
        requirementobject.RecordTypeid = requirementIdList[0].Id;
        requirementobject.Initiative__c = initiativeObject.id;
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = initiativeObjectLst[0].Id;
        
        ReqList.add(requirementobject);
        
        Requirement__c requirementobject2 = new Requirement__c();
        requirementobject.Name = 'Requirement';
        requirementobject2.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject2.Description__c ='Description Testing the test class';
        requirementobject2.Due_Date__c = Date.Today().addDays(10);       
        requirementobject2.RecordTypeid = requirementIdList[0].Id;
        requirementobject2.Initiative__c = initiativeObject.id;
        requirementobject2.Status__c = 'Overdue';
        requirementobject2.Hold_Payments__c = true;
        requirementObject2.Initiative__c = initiativeObjectLst[0].Id;
        
        ReqList.add(requirementobject2);
        
        Requirement__c requirementobject3 = new Requirement__c();
        requirementobject.Name = 'Requirement';
        requirementobject3.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject3.Description__c ='Description Testing the test class';
        requirementobject3.Due_Date__c = Date.Today().addDays(10);                                                                     
        requirementobject3.RecordTypeid = requirementIdList[0].Id;
        requirementobject3.Status__c = 'Overdue';
        requirementobject3.Hold_Payments__c = true;
        requirementObject3.Initiative__c = initiativeObjectLst[0].Id;
        
        ReqList.add(requirementobject3);
        
        Requirement__c requirementobject4 = new Requirement__c();
        requirementobject.Name = 'Requirement';
        requirementobject4.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject4.Description__c ='Description Testing the test class';
        requirementobject4.Due_Date__c = Date.Today().addDays(10);                                                                    
        requirementobject4.Status__c = 'Overdue';
        requirementobject4.Hold_Payments__c = true;
        requirementobject4.Partner__c = accountobject.Id;
        requirementobject4.Plan__c = planObject.id;
        requirementObject4.Initiative__c = initiativeObjectLst[0].Id;
        
        ReqList.add(requirementobject4);
        
        Requirement__c requirementobject5 = new Requirement__c();
        requirementobject.Name = 'Requirement 01';
        requirementobject5.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject5.Description__c ='Description Testing the test class';
        requirementobject5.Due_Date__c = Date.Today().addDays(10);                                                                       
        requirementobject5.Status__c = 'Overdue';
        requirementobject5.Hold_Payments__c = true;
        requirementobject5.Partner__c = accountobject.Id;
        requirementObject5.Initiative__c = initiativeObjectLst[0].Id; 
        requirementobject5.Plan__c = planObject.id;
        ReqList.add(requirementobject5);
        
        Requirement__c requirementobject6 = new Requirement__c();
        requirementobject.Name = 'Requirement';
        requirementobject6.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject6.Description__c ='Description Testing the test class';
        requirementobject6.Due_Date__c = Date.Today().addDays(10);                                                                 
        requirementobject6.Status__c = 'Overdue';
        requirementobject6.Hold_Payments__c = true;
        requirementobject6.Partner__c = accountobject.Id;
        requirementObject6.Initiative__c = initiativeObjectLst[0].Id;
        requirementobject6.Plan__c = planObject.id;
        
        ReqList.add(requirementobject6);
        
        insert ReqList;
        
        list<Measure__c > measureLst = new list<Measure__c >();
        
        Measure__c measureobject = new Measure__c();
        
        measureobject.Name = 'Testing Test Class';     
        measureobject.RecordTypeid = measureIdList[0].Id;
        measureobject.Status__c ='Pending'; 
        measureobject.Description__c = '';
        measureobject.Partner__c = accountobject.Id;    
        measureobject.Initiative__c = initiativeObjectLst[0].Id;   
        measureLst.add(measureobject); 
        
        Measure__c measureobject2 = new Measure__c();
        
        measureobject2.Name = 'Testing Test Class';     
        measureobject2.RecordTypeid = measureIdList[0].Id;
        measureobject2.Status__c ='Pending';
        measureobject2.Description__c = 'Test Description'; 
        measureobject2.Partner__c = accountobject.Id;    
        measureobject2.Initiative__c = initiativeObjectLst[0].Id;     
        measureLst.add(measureobject2);       
        
        insert measureLst;
                      
        ApexPages.StandardController stdCon = new ApexPages.standardController(businesscaseparentobject);
        InitiativeSchedule InitiativeScheduleInstance = new InitiativeSchedule(stdCon);
        Test.startTest();
        InitiativeScheduleInstance.fetchInitiative();
        Test.stopTest();
        System.assertEquals('Draft',InitiativeScheduleInstance.objBusinessCase.status__c,'Assert Failed');
        System.assertEquals(initiativeObjectLst.size(), InitiativeScheduleInstance.lstInitiative.size());
        System.assertEquals(payList.size(), InitiativeScheduleInstance.lstPayment.size());
    }
    
}