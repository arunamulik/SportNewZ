@isTest
public class TestBatchApexForPaymentFromFlow {

    @isTest
    static void testBatchExecution() {
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
                       
       Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                              Payments_Scheduled__c = false,Business_Case__c=Buslst[0].Id,Expense_Code__c = expCode.Id,
                                              Cost_Centre__c = cstCenter.Id,Planned__c = 500);
        insert inv;
        // Create test data for Payment__c records
        List<Payment__c> payments = new List<Payment__c>();
        for (Integer i = 0; i < 5; i++) {
            Payment__c payment = new Payment__c(
                Date__c = Date.today(),
                Status__c = 'Variation',
                Initiative__c = inv.id,
                 Amount__c = 300
                
            );
            payments.add(payment);
        }
        insert payments;

        // Create FlowInputs for the batch
        BatchApexForPaymentFromFlow.FlowInputs flowInputs = new BatchApexForPaymentFromFlow.FlowInputs();
        flowInputs.pDate = new List<Date>{Date.today()};

        // Start the batch
        Test.startTest();
        BatchApexForPaymentFromFlow.getPaymentRecords(new List<BatchApexForPaymentFromFlow.FlowInputs>{flowInputs});
        Test.stopTest();

        // Verify that the status of Payment__c records has been changed to 'Scheduled'
        List<Payment__c> updatedPayments = [SELECT Id, Status__c FROM Payment__c WHERE Id IN :payments];
        for (Payment__c updatedPayment : updatedPayments) {
            System.assertEquals('Scheduled', updatedPayment.Status__c);
        }

     }
}