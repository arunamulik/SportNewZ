@isTest
private class TestInitiativeTriggerHandler {
    
    /*static testMethod void TestInitiativeTriggerHandler() {
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
           invAreaAllocation.Amount__c = 400;
           invAreaAllocation.Investment_Area__c = iArea.Id;
           invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
           invAreaAllocation.Status__c = 'Draft';
           
           insert invAreaAllocation;
           
           Skip_Trigger__c isSkipTrigger = new Skip_Trigger__c();
           isSkipTrigger.Name = 'skipped';
           isSkipTrigger.is_Skipped__c=false;
           
           insert isSkipTrigger;
           
           List<Initiative__c> lstOfInitiative = new List<Initiative__c>();
           
           Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                                 Payments_Scheduled__c = false);
           Initiative__c inv1 = new Initiative__c(Name='Test Inv121',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                                  Payments_Scheduled__c = true);
           
           lstOfInitiative.add(inv);
           lstOfInitiative.add(inv1);
           
           insert lstOfInitiative;
           
            Requirement__c requirementobject = new Requirement__c();
            requirementobject.Comments__c = 'Comments Testing rthe Test Class';
            requirementobject.Description__c ='Description Testing the test class';
            requirementobject.Due_Date__c = Date.Today().addDays(10);       
            requirementobject.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
           // requirementobject.Initiative__c = lstOfInitiative[0].id;
            //requirementobject.Partner__c = accountObject.id;
            requirementobject.Status__c = 'Overdue';
            requirementobject.Hold_Payments__c = true;
            requirementObject.Initiative__c = lstOfInitiative[0].Id;
            
            insert requirementObject;
            
            
           Payment__c pay = new Payment__c();
           pay.Initiative__c = lstOfInitiative[0].Id;
           pay.Date__c = system.today();
           pay.Amount__c = 300;
           pay.status__c = 'Draft';
           
           insert pay;
            
           Test.startTest();
            List<Business_Case__c> Buslst = new List<Business_Case__c>(); 
            InitiativeTriggerHandler invHandler = new InitiativeTriggerHandler();
            InitiativeTriggerHandler.updatePartner(lstOfInitiative,true);
           //   InitiativeTriggerHandler.updateChildPaymentNRequirement(lstOfInitiative,);
            Business_Case__c businesscaseChild1object = new Business_Case__c();
            businesscaseChild1object.name= 'Testing Parent Business Case';
            businesscaseChild1object.Executive_Summary__c ='bla bla bla ';
           // businesscaseChild1object.Parent_Business_Case__c= businesscaseparentobject.id;
            businesscaseChild1object.Status__c= 'Draft';
            businesscaseChild1object.Investment_Area__c = iArea.id;
         	businesscaseChild1object.Strategic_Area__c= sArea.Id;
           // businesscaseChild1object.Total_Amount__c = 0;
            Buslst.Add(businesscaseChild1object);
            
            Business_Case__c businesscaseChild2object = new Business_Case__c();
            
            businesscaseChild2object.name= 'Testing Parent Business Case';
            businesscaseChild2object.Executive_Summary__c ='bla bla bla ';
            businesscaseChild2object.Status__c= 'Draft';
            //businesscaseChild2object.Parent_Business_Case__c= businesscaseparentobject.id;
            businesscaseChild2object.Investment_Area__c = iArea.id;
         	businesscaseChild2object.Strategic_Area__c= sArea.Id;
            //businesscaseChild2object.Total_Amount__c = 0;
            Buslst.Add(businesscaseChild2object);
            
            insert Buslst;
           
           Expense_Code__c expCode = new Expense_Code__c();
           expCode.Expenditure_Description__c = 'Test Expense';
           expCode.Expense_Name__c ='myExpense';
           expCode.Status__c = 'Active';
           insert expCode;
           
           Cost_Centre__c cstCenter = new Cost_Centre__c();
           cstCenter.Description__c = 'Test Cost Center';
           cstCenter.Status__c = 'Active';
           cstCenter.Unique_Code__c = '122134223';
           
           insert cstCenter;
           
           lstOfInitiative[0].Expense_Code__c = expCode.Id;
           lstOfInitiative[0].Cost_Centre__c = cstCenter.Id;
           lstOfInitiative[0].Planned__c = 500;
           
           lstOfInitiative[0].Payments_Scheduled__c=true;
           lstOfInitiative[0].Business_Case__c = Buslst[0].Id;
           FundingAllocationTriggerHandler handler = new FundingAllocationTriggerHandler();
          // lstOfInitiative[1].Payments_Scheduled__c=false;
          // lstOfInitiative[1].Business_Case__c = Buslst[1].Id;
           
           update lstOfInitiative;
           
           Test.stopTest();
           
     }
    
    
    
    @testSetup static void setup(){
         
       Skip_Trigger__c isSkipTrigger = new Skip_Trigger__c(Name='skipped',is_Skipped__c=False);
       insert isSkipTrigger;
        
         
        
        Account org=new Account(Name='Test1Org',Type='Supplier');
        insert org;
        
        Work_Brief__c wf=new Work_Brief__c(Work_Brief_Name__c='Test1wf',Name='5742',Stage__c='Active');
        insert wf;
        
        Activity_ID__c actid=new  Activity_ID__c(Name='TestClass Act');
        insert actid;
        
        Project_ID__c proid= new Project_ID__c(Name='TestClass Project');
        insert proid;
        
        Plan__c pl=new Plan__c(Partner__c=org.Id,Status__c='Draft',Start_Date__c=Date.newInstance(2020, 10, 1),End_Date__c=Date.newInstance(2021, 12, 25));
        insert pl;
        
        Strategic_Area__c sa=new Strategic_Area__c(Name='Test1SA',Entity__c='Sport NZ',Start_Date__c=Date.newInstance(2015,8,8),End_Date__c=Date.newInstance(2021,12,12));
        insert sa;
        
        Business_Case__c busi=new 	Business_Case__c(Name='TestInvestment TesttClassRecord',Status__c='Pending Approval',Strategic_Area__c=sa.Id);
        insert busi;
        
        Investment_Area__c ia=new Investment_Area__c(Name='Test1IA',Status__c='Active',Investment_Area_Owner__c='0056F00000CkUzyQAF',Strategic_Area__c=sa.Id,Start_Date__c=Date.newInstance(2021,8,8),End_Date__c=Date.newInstance(2021,12,12));
        insert ia;
        
        Initiative__c ini=new Initiative__c(
        RecordTypeId='01290000000mWNJAA2',
        Name='TestInitiative23',
        Planned__c=800,
        Business_Case__c=busi.Id,
        Investment_Area__c=ia.Id,
        Plan__c=pl.id,
        Start_Date__c=Date.newInstance(2021, 10, 20),
        End_Date__c=Date.newInstance(2021, 11, 16),
        Initiative_Owner__c='0056F00000CkUzyQAF',
        Close_the_Initiative__c=true,
        Priority__c='Could',
        Type__c='Time & Advice',
        Work_Brief__c=wf.id,
        Partner__c=org.Id
       // ActivityID__c=actid.id,
        //Project_ID__c=proid.id 
        );
        insert ini;
    }
    
    public static TestMethod void checkParent(){
        
        Test.startTest();  
        
        Initiative__c newlist=[select Id,Description__c,Status__c,Business_Case__r.Status__c from Initiative__c limit 1];
        newlist.End_Date__c=Date.newInstance(2021, 11, 14);
        update newlist;
 
		System.debug('Initiative Status-'+newlist.Status__c);
        System.debug('InvestmentSchedule Status-'+newlist.Business_Case__r.Status__c);
        
        Test.stopTest();
        
    }
    
    public static TestMethod void checkTrigger()
    {
         
       Test.startTest();   
        	Initiative__c newlist=[select Id,Description__c from Initiative__c limit 1];
        	
                newlist.Description__c='Testing';
        
     
        update newlist;
       
        
        System.debug('newlist***'+newlist);
		Test.stopTest();
    }*/
      static testMethod void TestInitiativeTriggerHandler() {
         
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
          
		Plan__c plan2 = new Plan__c(Partner__c=testAccount.Id,Status__c='Draft',Start_Date__c=system.today(),
                                   End_Date__c = system.today().addDays(20));
        insert plan2;
          
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
        fAllocation.Financial_Year__c='2022/23';
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
           
        Skip_Trigger__c isSkipTrigger = new Skip_Trigger__c();
        isSkipTrigger.Name = 'skipped';
        isSkipTrigger.is_Skipped__c=false;
        insert isSkipTrigger;
        
        List<Business_Case__c> Buslst = new List<Business_Case__c>(); 
        Business_Case__c businesscaseChild1object = new Business_Case__c();
        businesscaseChild1object.name= 'Testing Parent Business Case';
        businesscaseChild1object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild1object.Status__c= 'Approved';
        businesscaseChild1object.Strategic_Area__c = sArea.Id;
        businesscaseChild1object.Investment_Area__c = iArea.id;
        Buslst.Add(businesscaseChild1object);
        
        Business_Case__c businesscaseChild2object = new Business_Case__c();
        businesscaseChild2object.name= 'Testing Parent Business Case';
        businesscaseChild2object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild2object.Status__c= 'Signed';
        //businesscaseChild2object.Parent_Business_Case__c= businesscaseparentobject.id;
        businesscaseChild2object.Investment_Area__c = iArea.id;
        //businesscaseChild2object.Total_Amount__c = 0;
        Buslst.Add(businesscaseChild2object);
        businesscaseChild2object.Strategic_Area__c = sArea.Id;
        
        insert Buslst;
        
          
          
           Variation__c var = new Variation__c();
           var.Initiatives_Varied__c=false;
           var.Is_Active__c=true;
           var.Investment_Schedule__c=Buslst[1].Id;
           insert var;
       
        Expense_Code__c expCode = new Expense_Code__c();
        expCode.Expenditure_Description__c = 'Test Expense';
        expCode.Expense_Name__c ='myExpense';
        expCode.Status__c = 'Active';
        insert expCode;
        
        Cost_Centre__c cstCenter = new Cost_Centre__c();
        cstCenter.Description__c = 'Test Cost Center';
        cstCenter.Status__c = 'Active';
        cstCenter.Unique_Code__c = '122134223';
        insert cstCenter;
                       
        List<Initiative__c> lstOfInitiative = new List<Initiative__c>();
        List<Initiative__c> lstOfInitiativeold = new List<Initiative__c>();
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=Buslst[0].Id,Expense_Code__c = expCode.Id,
                                              Cost_Centre__c = cstCenter.Id,Planned__c = 500);
        Initiative__c inv1 = new Initiative__c(Name='Test Inv121',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                               Payments_Scheduled__c = true,Business_Case__c=Buslst[1].Id,Expense_Code__c = expCode.Id,
                                               Cost_Centre__c = cstCenter.Id,Planned__c = 500);
         Initiative__c inv2 = new Initiative__c(Name='Test Inv122',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                               Payments_Scheduled__c = true,Business_Case__c=Buslst[1].Id,Expense_Code__c = expCode.Id,
                                               Cost_Centre__c = cstCenter.Id,Planned__c = 600);
        
        lstOfInitiative.add(inv);          
       lstOfInitiative.add(inv1);
       //lstOfInitiativeold.add(inv2);
     
        
        insert lstOfInitiative;
          
       // insert lstOfInitiativeold;
          
           Payment__c pay = new Payment__c();
       // pay.Initiative__c = lstOfInitiative[0].Id;
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Amount__c = 300;
        pay.status__c = 'Draft';
        pay.Partner__c = testAccount.id;
       
        insert pay;
        
       // pay.status__c = 'Scheduled';
        //update pay;
          
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(10);       
        requirementobject.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        //requirementobject.Initiative__c = lstOfInitiative[0].id;
        //requirementobject.Partner__c = accountObject.id;
        requirementobject.Status__c = 'Overdue';
        requirementobject.Initiatives_Owner_Email__c='demo@gmail.com';
        requirementobject.Hold_Payments__c = true;
        //requirementObject.Initiative__c = lstOfInitiative[0].Id;
        requirementobject.Initiative__c = inv.Id;
          
          system.debug('Check' +lstOfInitiative[0].Id);
        
        insert requirementobject;
          
          Requirement__c requirementobject1 = new Requirement__c();
        requirementobject1.Comments__c = 'Comments Testing rthe Test Class1';
        requirementobject1.Description__c ='Description Testing the test class 1';
        requirementobject1.Due_Date__c = Date.Today().addDays(10);       
      //  requirementobject1.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
          requirementobject1.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].id;
          
     
        //requirementobject.Initiative__c = lstOfInitiative[0].id;
        //requirementobject.Partner__c = accountObject.id;
        requirementobject1.Status__c = 'Overdue';
        requirementobject1.Hold_Payments__c = true;
        //requirementObject.Initiative__c = lstOfInitiative[0].Id;
        requirementobject1.Initiative__c = inv.Id;
          
          system.debug('Check' +lstOfInitiative[0].Id);
        
         insert requirementobject1;
          
          
          Test.startTest();
          inv.Name= 'Demo Test 121';
          inv.Payments_Scheduled__c = true;
          inv.Plan__c = plan2.Id;
          lstOfInitiativeold.add(inv);
          //update inv;
          
          inv1.Name= 'Update Demo Test 121';
          inv1.Payments_Scheduled__c = true;
          lstOfInitiativeold.add(inv1);
         
         // update inv1;
       
         InitiativeTriggerHandler.updatePartner(lstOfInitiative,true);
      InitiativeTriggerHandler.updateChildPaymentNRequirement(lstOfInitiative, lstOfInitiativeold);
         InitiativeTriggerHandler.updateBusinessCaseAmount(lstOfInitiative, lstOfInitiativeold);
        Test.StopTest();
    }
    
    
        static testMethod void TestInitiativeTriggerHandlersize2() {
         
        updateInvestmentAreaTriggerHandler.isExecuted = true;
      //  Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='sharma', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
        
        Account testAccount = new Account( Name = 'Test Account1' );
        insert testAccount;
        
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
        
        Plan__c plan = new Plan__c(Investment_Area__c=iArea.Id,Status__c='Draft',Start_Date__c=system.today(),
                                   End_Date__c = system.today().addDays(20));
        insert plan;
          
		Plan__c plan2 = new Plan__c(Investment_Area__c=iArea.Id,Status__c='Draft',Start_Date__c=system.today(),
                                   End_Date__c = system.today().addDays(20));
        insert plan2;
          
        
        
       
        
        Funding_Allocation__c fAllocation = new Funding_Allocation__c();
        fAllocation.Financial_Year__c='2022/23';
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
           
       
        
        
        
        
        Skip_Trigger__c isSkipTrigger = new Skip_Trigger__c();
        isSkipTrigger.Name = 'skipped';
        isSkipTrigger.is_Skipped__c=false;
        insert isSkipTrigger;
        
        List<Business_Case__c> Buslst = new List<Business_Case__c>(); 
        Business_Case__c businesscaseChild1object = new Business_Case__c();
        businesscaseChild1object.name= 'Testing Parent Business Case';
        businesscaseChild1object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild1object.Status__c= 'Approved';
        businesscaseChild1object.Strategic_Area__c = sArea.Id;
        businesscaseChild1object.Investment_Area__c = iArea.id;
        Buslst.Add(businesscaseChild1object);
        
        Business_Case__c businesscaseChild2object = new Business_Case__c();
        businesscaseChild2object.name= 'Testing Parent Business Case';
        businesscaseChild2object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild2object.Status__c= 'Signed';
       // businesscaseChild2object.Parent_Business_Case__c= businesscaseparentobject.id;
        businesscaseChild2object.Investment_Area__c = iArea.id;
     //   businesscaseChild2object.Total_Amount__c = 0;
        Buslst.Add(businesscaseChild2object);
        businesscaseChild2object.Strategic_Area__c = sArea.Id;
        
        Business_Case__c businesscaseChild3object = new Business_Case__c();
        businesscaseChild3object.name= 'Testing Parent Business Case';
        businesscaseChild3object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild3object.Status__c= 'Signed';
       // businesscaseChild2object.Parent_Business_Case__c= businesscaseparentobject.id;
        businesscaseChild3object.Investment_Area__c = iArea.id;
     //   businesscaseChild2object.Total_Amount__c = 0;
        Buslst.Add(businesscaseChild3object);
       // insert businesscaseChild3object;   
            
            
        insert Buslst;
        
           Variation__c var = new Variation__c();
           var.Initiatives_Varied__c=true;
           var.Is_Active__c=true;
           var.Investment_Schedule__c=Buslst[0].Id;
           insert var;
         
        
        
        Expense_Code__c expCode = new Expense_Code__c();
        expCode.Expenditure_Description__c = 'Test Expense';
        expCode.Expense_Name__c ='myExpense';
        expCode.Status__c = 'Active';
        insert expCode;
        
        Cost_Centre__c cstCenter = new Cost_Centre__c();
        cstCenter.Description__c = 'Test Cost Center';
        cstCenter.Status__c = 'Active';
        cstCenter.Unique_Code__c = '122134223';
        insert cstCenter;
                       
        List<Initiative__c> lstOfInitiative = new List<Initiative__c>();
        List<Initiative__c> lstOfInitiativeold = new List<Initiative__c>();
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan2.Id,Initiative_Owner__c=usr.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=null,Expense_Code__c = expCode.Id,
                                              Cost_Centre__c = cstCenter.Id,Planned__c = 500,Partner__c=null,Investment_Schedule_Variation__c = null);
        Initiative__c inv1 = new Initiative__c(Name='Test Inv121',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                               Payments_Scheduled__c = true,Business_Case__c=Buslst[0].Id,Expense_Code__c = expCode.Id,
                                               Cost_Centre__c = cstCenter.Id,Planned__c = 500,Partner__c=null);
         Initiative__c inv2 = new Initiative__c(Name='Test Inv122',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                               Payments_Scheduled__c = true,Business_Case__c=Buslst[1].Id,Expense_Code__c = expCode.Id,
                                               Cost_Centre__c = cstCenter.Id,Planned__c = 600,Partner__c=null);
        
            Initiative__c inv3 = new Initiative__c(Name='Test Inv123',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                               Payments_Scheduled__c = true,Business_Case__c=Buslst[1].Id,Expense_Code__c = expCode.Id,
                                               Cost_Centre__c = cstCenter.Id,Planned__c = 600,Partner__c=null);
        
        
        
        
        lstOfInitiative.add(inv);          
       lstOfInitiative.add(inv1);
           lstOfInitiative.add(inv3);
            
       //lstOfInitiativeold.add(inv2);
     
        
        insert lstOfInitiative;
            insert inv2;
          
       // insert lstOfInitiativeold;
          
           Payment__c pay = new Payment__c();
       // pay.Initiative__c = lstOfInitiative[0].Id;
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Amount__c = 300;
        pay.status__c = 'Draft';
        pay.Partner__c = testAccount.id;
                           
        insert pay;
        
        //pay.status__c = 'Scheduled';
       // update pay;
         
       
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(10);       
        requirementobject.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        //requirementobject.Initiative__c = lstOfInitiative[0].id;
        //requirementobject.Partner__c = accountObject.id;
        requirementobject.Status__c = 'Overdue';
      
        requirementobject.Hold_Payments__c = true;
        //requirementObject.Initiative__c = lstOfInitiative[0].Id;
        requirementobject.Initiative__c = inv.Id;
          
          system.debug('Check' +lstOfInitiative[0].Id);
        
        insert requirementobject;
          
          Requirement__c requirementobject1 = new Requirement__c();
        requirementobject1.Comments__c = 'Comments Testing rthe Test Class1';
        requirementobject1.Description__c ='Description Testing the test class 1';
        requirementobject1.Due_Date__c = Date.Today().addDays(10);       
      //  requirementobject1.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
          requirementobject1.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].id;
          
     
        //requirementobject.Initiative__c = lstOfInitiative[0].id;
        //requirementobject.Partner__c = accountObject.id;
        requirementobject1.Status__c = 'Overdue';
        requirementobject1.Hold_Payments__c = true;
        //requirementObject.Initiative__c = lstOfInitiative[0].Id;
        requirementobject1.Initiative__c = inv.Id;
          
          system.debug('Check' +lstOfInitiative[0].Id);
        
         insert requirementobject1;
          
          
          Test.startTest();
          inv.Name= 'Demo Test 121';
          inv.Payments_Scheduled__c = true;
           
          inv.Plan__c = plan2.Id;
          lstOfInitiativeold.add(inv);
         // update inv;
         
          inv3.Name= 'Demo Test 1256';
          inv3.Plan__c = plan.Id;
           inv3.Investment_Area__c=null;
            inv3.Business_Case__c =Buslst[2].Id;
         
            lstOfInitiativeold.add(inv2);
            
          
          inv1.Name= 'Update Demo Test 121';
          inv1.Payments_Scheduled__c = true;
          inv1.Plan__c = plan.Id;
         inv.Investment_Area__c=iArea.Id;
          lstOfInitiativeold.add(inv1);
         
         // update inv1;
       
                  InitiativeTriggerHandler.updatePartner(lstOfInitiative,true);
            
            System.debug('lstOfInitiative '+ lstOfInitiative);
            System.debug('lstOfInitiative old '+ lstOfInitiativeold);
            
               InitiativeTriggerHandler.updateChildPaymentNRequirement(lstOfInitiative, lstOfInitiativeold);
         InitiativeTriggerHandler.updateBusinessCaseAmount(lstOfInitiative, lstOfInitiativeold);
        Test.StopTest();
    } 
    
    
    
    static testMethod void TestInitiativeTriggerHandlersize() {
         
        updateInvestmentAreaTriggerHandler.isExecuted = true;
      //  Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
         Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='sharma', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
        
        Account testAccount = new Account( Name = 'Test Account1' );
        insert testAccount;
        
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
        
        Plan__c plan = new Plan__c(Investment_Area__c=iArea.Id,Status__c='Draft',Start_Date__c=system.today(),
                                   End_Date__c = system.today().addDays(20));
        insert plan;
          
		Plan__c plan2 = new Plan__c(Investment_Area__c=iArea.Id,Status__c='Draft',Start_Date__c=system.today(),
                                   End_Date__c = system.today().addDays(20));
        insert plan2;
          
        
        
       
        
        Funding_Allocation__c fAllocation = new Funding_Allocation__c();
        fAllocation.Financial_Year__c='2022/23';
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
           
       
        
        
        
        
        Skip_Trigger__c isSkipTrigger = new Skip_Trigger__c();
        isSkipTrigger.Name = 'skipped';
        isSkipTrigger.is_Skipped__c=false;
        insert isSkipTrigger;
        
        List<Business_Case__c> Buslst = new List<Business_Case__c>(); 
        Business_Case__c businesscaseChild1object = new Business_Case__c();
        businesscaseChild1object.name= 'Testing Parent Business Case';
        businesscaseChild1object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild1object.Status__c= 'Approved';
        businesscaseChild1object.Strategic_Area__c = sArea.Id;
        businesscaseChild1object.Investment_Area__c = iArea.id;
        Buslst.Add(businesscaseChild1object);
        
        Business_Case__c businesscaseChild2object = new Business_Case__c();
        businesscaseChild2object.name= 'Testing Parent Business Case';
        businesscaseChild2object.Executive_Summary__c ='bla bla bla ';
        businesscaseChild2object.Status__c= 'Signed';
       // businesscaseChild2object.Parent_Business_Case__c= businesscaseparentobject.id;
        businesscaseChild2object.Investment_Area__c = iArea.id;
     //   businesscaseChild2object.Total_Amount__c = 0;
        Buslst.Add(businesscaseChild2object);
        businesscaseChild2object.Strategic_Area__c = sArea.Id;
        
        insert Buslst;
        
           Variation__c var = new Variation__c();
           var.Initiatives_Varied__c=true;
           var.Is_Active__c=true;
           var.Investment_Schedule__c=Buslst[0].Id;
           insert var;
              
        
        Expense_Code__c expCode = new Expense_Code__c();
        expCode.Expenditure_Description__c = 'Test Expense';
        expCode.Expense_Name__c ='myExpense';
        expCode.Status__c = 'Active';
        insert expCode;
        
        Cost_Centre__c cstCenter = new Cost_Centre__c();
        cstCenter.Description__c = 'Test Cost Center';
        cstCenter.Status__c = 'Active';
        cstCenter.Unique_Code__c = '122134223';
        insert cstCenter;
                       
        List<Initiative__c> lstOfInitiative = new List<Initiative__c>();
        List<Initiative__c> lstOfInitiativeold = new List<Initiative__c>();
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan2.Id,Initiative_Owner__c=usr.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=null,Expense_Code__c = expCode.Id,
                                              Cost_Centre__c = cstCenter.Id,Planned__c = 500,Partner__c=null,Investment_Schedule_Variation__c = null);
        Initiative__c inv1 = new Initiative__c(Name='Test Inv121',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                               Payments_Scheduled__c = true,Business_Case__c=Buslst[0].Id,Expense_Code__c = expCode.Id,
                                               Cost_Centre__c = cstCenter.Id,Planned__c = 500,Partner__c=null);
         Initiative__c inv2 = new Initiative__c(Name='Test Inv122',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                               Payments_Scheduled__c = true,Business_Case__c=Buslst[1].Id,Expense_Code__c = expCode.Id,
                                               Cost_Centre__c = cstCenter.Id,Planned__c = 600,Partner__c=null);
        
        
        
        
        
        lstOfInitiative.add(inv);          
       lstOfInitiative.add(inv1);
       //lstOfInitiativeold.add(inv2);
     
        
        insert lstOfInitiative;
          
       // insert lstOfInitiativeold;
          
           Payment__c pay = new Payment__c();
       // pay.Initiative__c = lstOfInitiative[0].Id;
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Amount__c = 300;
        pay.status__c = 'Draft';
        pay.Partner__c = testAccount.id;
                           
        insert pay;
        
        //pay.status__c = 'Scheduled';
       // update pay;
         
       
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(10);       
        requirementobject.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        //requirementobject.Initiative__c = lstOfInitiative[0].id;
        //requirementobject.Partner__c = accountObject.id;
        requirementobject.Status__c = 'Overdue';
      
        requirementobject.Hold_Payments__c = true;
        //requirementObject.Initiative__c = lstOfInitiative[0].Id;
        requirementobject.Initiative__c = inv.Id;
          
          system.debug('Check' +lstOfInitiative[0].Id);
        
        insert requirementobject;
          
          Requirement__c requirementobject1 = new Requirement__c();
        requirementobject1.Comments__c = 'Comments Testing rthe Test Class1';
        requirementobject1.Description__c ='Description Testing the test class 1';
        requirementobject1.Due_Date__c = Date.Today().addDays(10);       
      //  requirementobject1.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
          requirementobject1.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement Completed'].id;
          
     
        //requirementobject.Initiative__c = lstOfInitiative[0].id;
        //requirementobject.Partner__c = accountObject.id;
        requirementobject1.Status__c = 'Overdue';
        requirementobject1.Hold_Payments__c = true;
        //requirementObject.Initiative__c = lstOfInitiative[0].Id;
        requirementobject1.Initiative__c = inv.Id;
          
          system.debug('Check' +lstOfInitiative[0].Id);
        
         insert requirementobject1;
          
          
          Test.startTest();
          inv.Name= 'Demo Test 121';
          inv.Payments_Scheduled__c = true;
           
          inv.Plan__c = plan2.Id;
          lstOfInitiativeold.add(inv);
         // update inv;
          
          inv1.Name= 'Update Demo Test 121';
          inv1.Payments_Scheduled__c = true;
          inv1.Plan__c = plan.Id;
         inv.Investment_Area__c=iArea.Id;
          lstOfInitiativeold.add(inv1);
         
         // update inv1;
       
                  InitiativeTriggerHandler.updatePartner(lstOfInitiative,true);
               InitiativeTriggerHandler.updateChildPaymentNRequirement(lstOfInitiative, lstOfInitiativeold);
         InitiativeTriggerHandler.updateBusinessCaseAmount(lstOfInitiative, lstOfInitiativeold);
        Test.StopTest();
    }      
   
}