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
@isTest(SeeAllData=true)
private class TestAssessorTriggerHandler {

    static testMethod void TestAssessorTriggerHandler() {
        
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
        strategicAreaObject.Status__c ='Active';
        insert strategicAreaObject;
        
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Contestable Investment'].Id;
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Application_Round__c appRound = new Application_Round__c();
        appRound.Application_End_Date__c = system.now().addDays(7);
        appRound.Application_Start_Date__c = system.now();
        appRound.Create_Assessments__c = true;
        appRound.Status__c = 'Open';
        appRound.Shortlisting_Date__c = system.now();
        appRound.Investment_Area__c = investmentAreaObject.Id;
        insert appRound;
        
        Application_Round__c appRound1 = new Application_Round__c();
        appRound1.Application_End_Date__c = system.now().addDays(7);
        appRound1.Application_Start_Date__c = system.now();
        appRound1.Create_Assessments__c = true;
        appRound1.Status__c = 'Pending Assessment';
        appRound1.Shortlisting_Date__c = system.now();
        appRound1.Investment_Area__c = investmentAreaObject.Id;
        insert appRound1;
        
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        Contact con = new Contact(lastName='test1',AccountId=accountObject.id);
        insert con;
        
        Application__c application = new Application__c();
        application.Name__c = 'testApp';
        application.Applicant__c = accountObject.Id;
        application.Contact__c = con.Id;
        application.Application_Round__c = appRound.Id;
        application.Date_Acknowledged__c = system.today().addDays(7);
        application.Date_Received__c = system.today().addDays(2);
        application.Date_Shortlisted__c = system.today().addDays(10);
        
        insert application;
        
        List<Assessor__c> lstAssessor = new list<Assessor__c>();
        Assessor__c assessor1 = new Assessor__c();
        assessor1.Application_Round__c = appRound.Id;
        assessor1.Assessor__c = userObject.Id; 
        lstAssessor.add(assessor1);
        
        Assessor__c assessor2 = new Assessor__c();
        assessor2.Application_Round__c = appRound1.Id;
        assessor2.Assessor__c = userObject.Id;
        lstAssessor.add(assessor2);
        
        insert lstAssessor;
        
        Assessment__c assessment = new Assessment__c();
        assessment.Application__c = application.Id;
        assessment.Assessor__c =userObject.Id;
        
        insert assessment;
        
        AssessorTriggerHandler.avoidAssessorDuplicate(lstAssessor);
        AssessorTriggerHandler.deleteOwnedAssessment(lstAssessor);
        
    }
}