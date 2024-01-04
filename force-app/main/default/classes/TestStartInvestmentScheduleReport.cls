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
private class TestStartInvestmentScheduleReport {

    static testMethod void TestStartInvestmentScheduleReport() {
        
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
        
        //list<Business_Case__c> BusLst = new list<Business_Case__c>();
        
        Business_Case__c businesscaseparentobject = new Business_Case__c();
        
        businesscaseparentobject.name= 'Testing Parent Business Case';
        businesscaseparentobject.Executive_Summary__c ='bla bla bla ';
        businesscaseparentobject.Status__c= 'Draft';
        businesscaseparentobject.Investment_Area__c = investmentAreaObject.id;
        //Buslst.Add(businesscaseparentobject);
        
        insert businesscaseparentobject;
        
        Test.startTest();
        
			ApexPages.StandardController stCon = new ApexPages.StandardController(businesscaseparentobject);
			StartInvestmentScheduleReportController invScheduleRep = new StartInvestmentScheduleReportController(stCon);
			invScheduleRep.startInvestmentScheduleReport();
			
			try {
				businesscaseparentobject=null;
				update businesscaseparentobject;
			 
			} catch (Exception e){
				system.debug('e.getMessage() >>>>>>>>>>>>> '+e.getMessage());
				Boolean expectedExceptionThrown =  e.getMessage().contains('Attempt to de-reference a null object') ? true : false;
				system.debug('expectedExceptionThrown >>>>>>>>>>>>> '+expectedExceptionThrown);
				System.AssertEquals(expectedExceptionThrown, true);
				
			}
		Test.stopTest();	
		
		
        
    }
}