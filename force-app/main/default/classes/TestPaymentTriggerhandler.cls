/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestPaymentTriggerhandler {

    static testMethod void TestPaymentTriggerhandler() {
        
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
        
        Test.startTest();
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
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=Buslst[0].Id,Expense_Code__c = expCode.Id,
                                              Cost_Centre__c = cstCenter.Id,Planned__c = 500);
        Initiative__c inv1 = new Initiative__c(Name='Test Inv121',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                               Payments_Scheduled__c = true,Business_Case__c=Buslst[1].Id,Expense_Code__c = expCode.Id,
                                               Cost_Centre__c = cstCenter.Id,Planned__c = 500);
        
        lstOfInitiative.add(inv);
        lstOfInitiative.add(inv1);
        
        insert lstOfInitiative;
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing rthe Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(10);       
        requirementobject.RecordTypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        //requirementobject.Initiative__c = lstOfInitiative[0].id;
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
        pay.Partner__c = testAccount.id;
        
        insert pay;
        
        pay.status__c = 'Scheduled';
        update pay;
        Test.StopTest();
    }
    
   /* static testMethod void TestupdateInvestmentArea() {
    
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
        //iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;
        
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
                                   
        Business_Case__c businesscaseobject = new Business_Case__c();
        businesscaseobject.name= 'Testing Parent Business Case';
        businesscaseobject.Executive_Summary__c ='bla bla bla ';
        businesscaseobject.Status__c= 'Signed';
        businesscaseobject.Investment_Area__c = iArea.id;
        insert businesscaseobject;
        
        Funding_Allocation__c fAllocation = new Funding_Allocation__c();
        fAllocation.Financial_Year__c='2017/18';
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
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Plan__c=plan.Id,Investment_Area__c=iArea.Id,Expense_Code__c = expCode.Id,Cost_Centre__c = cstCenter.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=businesscaseobject.Id,
                                              Planned__c = 500);
        insert inv;
        
           
        
        Test.starttest();
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Amount__c = 300;
        pay.status__c = 'Draft';
        
        insert pay;
        
        Test.stoptest();                                      
        Business_Case__c obj = [Select Payment_Status__c from Business_Case__c limit 1];
        System.assertEquals('Not Paid',obj.Payment_Status__c);
    }*/
    
    static testMethod void TestupdateInvestmentSchedule() {
    
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
        //iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;
       
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = sArea.id;
        objFund.Financial_Year__c = '2022/23';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = iArea.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
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
                                   
        Business_Case__c businesscaseobject = new Business_Case__c();
        businesscaseobject.name= 'Testing Parent Business Case';
        businesscaseobject.Executive_Summary__c ='bla bla bla ';
        businesscaseobject.Status__c= 'Signed';
        businesscaseobject.Investment_Area__c = iArea.id;
        businesscaseobject.Strategic_Area__c = sArea.Id;
        insert businesscaseobject;
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Plan__c=plan.Id,Investment_Area__c=iArea.Id,Expense_Code__c = expCode.Id,Cost_Centre__c = cstCenter.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=businesscaseobject.Id,
                                              Planned__c = 500);
        insert inv;
        
        Test.starttest();
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Amount__c = 100;
        pay.status__c = 'Paid';
        Pay.Partner__c = testAccount.id;
        
        insert pay;
        
        Payment__c pay1 = new Payment__c();
        pay1.Initiative__c = inv.Id;
        pay1.Date__c = system.today();
        pay1.Amount__c = 200;
        pay1.status__c = 'Draft'; 
        Pay1.Partner__c = testAccount.id;
        
        insert pay1;
        
        
        Test.stoptest();                                      
        Business_Case__c obj = [Select Payment_Status__c from Business_Case__c limit 1];
        //System.assertEquals('Partially Paid',obj.Payment_Status__c);
    }
    
    static testMethod void TestupdateInvestmentSchedule1() {
    
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
        //iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;
       
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = sArea.id;
        objFund.Financial_Year__c = '2022/23';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = iArea.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
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
                                   
        Business_Case__c businesscaseobject = new Business_Case__c();
        businesscaseobject.name= 'Testing Parent Business Case';
        businesscaseobject.Executive_Summary__c ='bla bla bla ';
        businesscaseobject.Status__c= 'Signed';
        businesscaseobject.Investment_Area__c = iArea.id;
        businesscaseobject.Strategic_Area__c = sArea.Id;

        insert businesscaseobject;
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Plan__c=plan.Id,Investment_Area__c=iArea.Id,Expense_Code__c = expCode.Id,Cost_Centre__c = cstCenter.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=businesscaseobject.Id,
                                              Planned__c = 500);
        insert inv;
        
        Test.starttest();
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Amount__c = 100;
        pay.status__c = 'Draft';
        Pay.Partner__c = testAccount.id;
        insert pay;
          
        
         Payment__c pay1 = new Payment__c();
        pay1.Initiative__c = inv.Id;
        pay1.Date__c = system.today();
        pay1.Amount__c = 200;
        pay1.status__c = 'Draft';
        Pay1.Partner__c = testAccount.id;
        insert pay1;
        
        Payment__c payobj=[select status__c from Payment__c limit 1];
        payobj.Status__c='Not Paid';
        update payobj;
        Payment__c payobj1=[select status__c from Payment__c where Amount__c=200 limit 1];
        delete payobj1;
        Test.stoptest();                                      
        Business_Case__c obj = [Select Payment_Status__c from Business_Case__c limit 1];
        
        //System.assertEquals('Partially Paid',obj.Payment_Status__c);
    }

    static testMethod void TestupdateInvestmentSchedule1Catch() {
    
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
        //iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;
       
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = sArea.id;
        objFund.Financial_Year__c = '2022/23';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = iArea.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
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
                                   
        Business_Case__c businesscaseobject = new Business_Case__c();
        businesscaseobject.name= 'Testing Parent Business Case';
        businesscaseobject.Executive_Summary__c ='bla bla bla ';
        businesscaseobject.Status__c= 'Signed';
        businesscaseobject.Strategic_Area__c = sArea.Id;
        businesscaseobject.Investment_Area__c = iArea.id;
        insert businesscaseobject;
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Plan__c=plan.Id,Investment_Area__c=iArea.Id,Expense_Code__c = expCode.Id,Cost_Centre__c = cstCenter.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=businesscaseobject.Id,
                                              Planned__c = 500);
        insert inv;
        
        Test.starttest();
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Amount__c = 100;
        pay.status__c = 'Draft';
        Pay.Partner__c = testAccount.id;
        insert pay;
          
        
         Payment__c pay1 = new Payment__c();
        pay1.Initiative__c = inv.Id;
        pay1.Date__c = system.today();
        pay1.Amount__c = 200;
        pay1.status__c = 'Draft';
        Pay1.Partner__c = testAccount.id;
        insert pay1;
        
        Payment__c payobj=[select status__c from Payment__c limit 1];
        payobj.Status__c='Not Paid';
        RecursionHandler.executionCount = 1;
        PaymentTriggerhandler.getCatch = true;
        update payobj;
        Payment__c payobj1=[select status__c from Payment__c where Amount__c=200 limit 1];
        delete payobj1;
        Test.stoptest();                                      
        Business_Case__c obj = [Select Payment_Status__c from Business_Case__c limit 1];
        
        //System.assertEquals('Partially Paid',obj.Payment_Status__c);
    }
        
    static testMethod void TestupdateInvestmentSchedule4() {
    
        Account testAccount = new Account( Name = 'Test Account', Type = 'Other');
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
        
        Funding_Allocation__c fAllo = new Funding_Allocation__c();
        fAllo.Strategic_Area__c = sArea.id;
        fAllo.Financial_Year__c = '2022/23';
        fAllo.Funding_Allocation_Start_Date__c = system.Today();
        fAllo.Funding_Allocation_End_Date__c = system.Today().addDays(2);
        fAllo.Status__c = 'Approved';
        fAllo.Funding_Amount__c = 20000;
        insert fAllo;
        
        Investment_Area__c iArea = new Investment_Area__c();
        iArea.Name = 'Davanti';
        iArea.Strategic_Area__c = sArea.Id;
        iArea.Status__c = 'Active';
        iArea.Start_Date__c = system.Today();
        iArea.End_Date__c = system.Today().addDays(2);
        //iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;
        
        Investment_Area_Allocation__c iAreaAll = new Investment_Area_Allocation__c();
        iAreaAll.Amount__c = 5000;
        iAreaAll.Status__c = 'Active';
        iAreaAll.Funding_Allocation__c = fAllo.Id;
        iAreaAll.Investment_Area__c = iArea.id;
        insert iAreaAll;
        Set<Id> iaaIDs = new set<Id>();
        iaaIDs.add(iAreaAll.id);
        
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
                                   
        Business_Case__c businesscaseobject = new Business_Case__c();
        businesscaseobject.name= 'Testing Parent Business Case';
        businesscaseobject.Executive_Summary__c ='bla bla bla ';
        //businesscaseobject.Status__c= 'Approved';
        businesscaseobject.Investment_Area__c = iArea.id;
        businesscaseobject.Strategic_Area__c = sArea.Id;
        businesscaseobject.Payment_Status__c='Not Paid';
        insert businesscaseobject;
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Plan__c=plan.Id,Investment_Area__c=iArea.Id,Expense_Code__c = expCode.Id,Cost_Centre__c = cstCenter.Id,
                                              Payments_Scheduled__c = false, Business_Case__c=businesscaseobject.Id,type__c = 'Paid Direct',
                                              Planned__c = 500);
        insert inv;
        
        Test.starttest();
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Investment_Area_Allocation__c = iAreaAll.id;
        //pay.Supplier_Invoice_Date__c = system.today();
        //pay.Supplier_Invoice_Number__c = '8098908';
        pay.Amount__c = 300;
        pay.status__c = 'Draft';
        
        insert pay;
        
        
        Test.stoptest(); 
        
        PaymentTriggerhandler.rollupPaymentsOnIAA(iaaIDs);    
        
        Business_Case__c obj = [Select Payment_Status__c from Business_Case__c limit 1];
        System.assertEquals('Not Paid',obj.Payment_Status__c);
    }
    
    static testMethod void TestupdateOrganisation() {
    
        Account testAccount = new Account( Name = 'Test Account', Type = 'Other');
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
        
        Funding_Allocation__c fAllo = new Funding_Allocation__c();
        fAllo.Strategic_Area__c = sArea.id;
        fAllo.Financial_Year__c = '2022/23';
        fAllo.Funding_Allocation_Start_Date__c = system.Today();
        fAllo.Funding_Allocation_End_Date__c = system.Today().addDays(2);
        fAllo.Status__c = 'Approved';
        fAllo.Funding_Amount__c = 20000;
        insert fAllo;
        
        Investment_Area__c iArea = new Investment_Area__c();
        iArea.Name = 'Davanti';
        iArea.Strategic_Area__c = sArea.Id;
        iArea.Status__c = 'Active';
        iArea.Start_Date__c = system.Today();
        iArea.End_Date__c = system.Today().addDays(2);
        //iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;
        
        Investment_Area_Allocation__c iAreaAll = new Investment_Area_Allocation__c();
        iAreaAll.Amount__c = 5000;
        iAreaAll.Status__c = 'Active';
        iAreaAll.Funding_Allocation__c = fAllo.Id;
        iAreaAll.Investment_Area__c = iArea.id;
        insert iAreaAll;
        Set<Id> iaaIDs = new set<Id>();
        iaaIDs.add(iAreaAll.id);
        
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
                                   
        Business_Case__c businesscaseobject = new Business_Case__c();
        businesscaseobject.name= 'Testing Parent Business Case';
        businesscaseobject.Executive_Summary__c ='bla bla bla ';
        //businesscaseobject.Status__c= 'Approved';
        businesscaseobject.Strategic_Area__c = sArea.Id;
        businesscaseobject.Investment_Area__c = iArea.id;
        insert businesscaseobject;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Plan__c=plan.Id,Investment_Area__c=iArea.Id,Expense_Code__c = expCode.Id,
                                              Cost_Centre__c = cstCenter.Id,Payments_Scheduled__c = false, Business_Case__c=businesscaseobject.Id,
                                              type__c = 'Paid Direct',Planned__c = 500, RecordTypeId = initiativePartnerPlanRecordTypeId , Partner__c = testAccount.id );
        insert inv;
        
        Test.starttest();
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Investment_Area_Allocation__c = iAreaAll.id;
        //pay.Supplier_Invoice_Date__c = system.today();
        //pay.Supplier_Invoice_Number__c = '8098908';
        pay.Amount__c = 300;
        pay.status__c = 'Draft';
        
        insert pay;
        
        Test.stoptest();        
        //PaymentTriggerhandler.rollupPaymentsOnIAA(iaaIDs);                             
        List<Initiative__c> obj = [Select Partner__c from Initiative__c limit 1];
        List<Payment__c>objPay = [Select Partner__c from Payment__c limit 1];
        System.assertEquals(obj[0].Partner__c,objPay[0].Partner__c);
    }
    
     static testMethod void testUpdateOrganisationForProjectPlan() {
    
        Account testAccount = new Account( Name = 'Test Account', Type = 'Other');
        insert testAccount;
        
        
                
        Strategic_Area__c sArea = new Strategic_Area__c();
        sArea.Name = 'Wellington';
        sArea.Entity__c = 'Sportz Anz';
        sArea.Status__c = 'Draft';
        sArea.Start_Date__c = system.Today();
        sArea.End_Date__c = system.Today().addDays(2);
        insert sArea;        
        
        Funding_Allocation__c fAllo = new Funding_Allocation__c();
        fAllo.Strategic_Area__c = sArea.id;
        fAllo.Financial_Year__c = '2022/23';
        fAllo.Funding_Allocation_Start_Date__c = system.Today();
        fAllo.Funding_Allocation_End_Date__c = system.Today().addDays(2);
        fAllo.Status__c = 'Approved';
        fAllo.Funding_Amount__c = 20000;
        insert fAllo;
        
        Investment_Area__c iArea = new Investment_Area__c();
        iArea.Name = 'Davanti';
        iArea.Strategic_Area__c = sArea.Id;
        iArea.Status__c = 'Active';
        iArea.Start_Date__c = system.Today();
        iArea.End_Date__c = system.Today().addDays(2);
        //iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;      
        
        Investment_Area_Allocation__c iAreaAll = new Investment_Area_Allocation__c();
        iAreaAll.Amount__c = 5000;
        iAreaAll.Status__c = 'Active';
        iAreaAll.Funding_Allocation__c = fAllo.Id;
        iAreaAll.Investment_Area__c = iArea.id;
        insert iAreaAll;
        Set<Id> iaaIDs = new set<Id>();
        iaaIDs.add(iAreaAll.id);
         
        Id initiativePartnerPlanRecordTypeId1 = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Project Plan'].Id;
        
        Plan__c plan = new Plan__c(Status__c='Draft',Start_Date__c=system.today(),
                                   End_Date__c = system.today().addDays(20), Investment_Area__c = iArea.id , RecordTypeId =initiativePartnerPlanRecordTypeId1 );
        insert plan; 
         System.debug('plan>>>>>'+plan);
        
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
                                   
        Business_Case__c businesscaseobject = new Business_Case__c();
        businesscaseobject.name= 'Testing Parent Business Case';
        businesscaseobject.Executive_Summary__c ='bla bla bla ';
        //businesscaseobject.Status__c= 'Approved';
        businesscaseobject.Strategic_Area__c = sArea.Id;
        businesscaseobject.Investment_Area__c = iArea.id;
        insert businesscaseobject;
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Project Plan'].Id;
        
        Initiative__c inv = new Initiative__c(Name='Test Inv',Plan__c=plan.Id,Investment_Area__c=iArea.Id,Expense_Code__c = expCode.Id,
                                              Cost_Centre__c = cstCenter.Id,Payments_Scheduled__c = false, Business_Case__c=businesscaseobject.Id,
                                              type__c = 'Paid Direct',Planned__c = 500, RecordTypeId = initiativePartnerPlanRecordTypeId );
        insert inv;
        
        Test.starttest();
        
        Payment__c pay = new Payment__c();
        pay.Initiative__c = inv.Id;
        pay.Date__c = system.today();
        pay.Investment_Area_Allocation__c = iAreaAll.id;
        //pay.Supplier_Invoice_Date__c = system.today();
        //pay.Supplier_Invoice_Number__c = '8098908';
        pay.Amount__c = 300;
        pay.status__c = 'Draft';
        pay.Partner__c = testAccount.id;        
        insert pay;
        
        Test.stoptest();        
        //PaymentTriggerhandler.rollupPaymentsOnIAA(iaaIDs);                             
        List<Initiative__c> obj = [Select Partner__c, recordtype.developername from Initiative__c limit 1];
         system.debug('obj>>>>>>>>'+obj);
        List<Payment__c>objPay = [Select Partner__c from Payment__c limit 1];
        //System.assertNotEquals(obj[0].Partner__c,objPay[0].Partner__c);
    }

}