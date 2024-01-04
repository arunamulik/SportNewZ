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
private class InvestmentAreaOwnerChangeTriggerTest {

    static testMethod void InvestmentAreaOwnerChangeTriggerTest() {
         
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
           
           Business_Case__c bCase = new Business_Case__c();
           bCase.Name = 'test owner change';
           bCase.Investment_Area__c = iArea.Id;
           bCase.Investment_Area_Owner__c = usr.Id;
           bCase.Strategic_Area__c = sArea.Id;
           bCase.Strategic_Area_Owner__c = usr.Id;
           
           insert bCase;
           
         Test.startTest();  
            sArea.OwnerId = UserInfo.getUserId(); 
            update sArea;
           
           iArea.Investment_Area_Owner__c = UserInfo.getUserId();
           update iArea;
           
         Test.stopTest();
         
    }
}