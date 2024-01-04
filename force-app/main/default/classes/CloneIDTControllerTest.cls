@isTest
public class CloneIDTControllerTest {

    public static testmethod void testMethod1()
    {
        
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
        
		
        Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id,
                                                 Payments_Scheduled__c = false);
        insert inv;
        
        
        
		Initiative_Development_Template__c idt = new Initiative_Development_Template__c();
        idt.Amount_of_Investment_Year_1__c= 100;
        idt.Financial_Year__c = '2021 - 2022';
        idt.How_will_you_measure_success_in_Year_1__c='test'; 
        idt.How_will_you_measure_success_in_Year_2__c='test'; 
        idt.How_will_you_measure_success_in_Year_3__c='test'; 
        idt.Initiative_Name__c='Test Inv'; 
        idt.Investment_Area__c='Active Recreation'; 
        idt.Organisation_Name__c=testAccount.id;
        idt.Number_of_FTE_Allocated__c='test'; 
        idt.Status__c='Approved';
        idt.What_Risks_have_been_identified__c='test'; 
        idt.What_activity_will_you_do_in_Year_1__c='test';
        idt.What_activity_will_you_do_in_Year_2__c='test';
        idt.What_activity_will_you_do_in_Year_3__c='test';
        idt.What_outcomes_will_you_achieve__c='test';
        idt.Who_will_lead_this_area__c='test';
        idt.Amount_of_Investment_Year_2__c=100;
        idt.Amount_of_Investment_Year_3__c=100;
        idt.Sport_NZ_Feedback__c='test';
        idt.SME_Comments__c='test';
        idt.SME_Approvers__c='test'; 
        idt.How_will_you_measure_success_in_Year_4__c='test'; 
        idt.What_activity_will_you_do_in_Year_4__c='test';
        
        insert idt;
        System.debug('IDT:- '+idt);
        ApexPages.CurrentPage().getparameters().put('id', idt.Id); //Record Id
        
        Apexpages.StandardController sc = new Apexpages.StandardController(idt); //Record

        Test.startTest();

        CloneIDTController objSyncCustomer = new CloneIDTController(sc); //Standard Controller

        objSyncCustomer.cloneIDT();

        Test.stopTest();
       
        
    }
}