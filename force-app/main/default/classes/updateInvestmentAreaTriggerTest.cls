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
private class updateInvestmentAreaTriggerTest {

    static testMethod void investmentAreaTriggerTest() {
        
        Test.startTest();
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
           
           Initiative__c inv = new Initiative__c(Name='Test Inv',Investment_Area__c=iArea.Id,Plan__c=plan.Id,Initiative_Owner__c=usr.Id);
           insert inv;
           
           Payment__c pay = new Payment__c();
           pay.Initiative__c = inv.Id;
           pay.Date__c = system.today();
           pay.Amount__c = 300;
           pay.status__c = 'Draft';
           
           insert pay;
           
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
           
           inv.Expense_Code__c = expCode.Id;
           inv.Cost_Centre__c = cstCenter.Id;
           inv.Planned__c = 500;
           
           update inv;
             
           pay.status__c = 'Scheduled';
           
           update pay;
           
        Test.stopTest();
        
    }
   
}