public with sharing class TestAssessorScoringController {
		/*
		public static void init() {
    	//Accounts
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
		//Contact
		List<Contact> contactInsertList = new List<Contact>();
		Contact contactObject = new Contact();
		contactObject.LastName = 'PO';
		contactObject.Email = 'tst@davanti.co.nz';
		contactObject.AccountId = accountObjectLimited.id;
		contactInsertList.add(contactObject);
		insert contactInsertList;
		//Strategic Area
		Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
		strategicAreaObject.Name = 'Community Sport';
		strategicAreaObject.Start_Date__c = date.today();
		strategicAreaObject.End_Date__c = date.today().addDays(5);
		insert strategicAreaObject;
		//Plan
	    List<Plan__c> planObjectInsertList = new List<Plan__c>();
		Plan__c planObject = new Plan__c();
		planObject.Partner__c = accountObject.id;
	    planObject.RecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Project Plan'].Id;
		planObject.Start_Date__c = date.today();
		planObject.End_Date__c = date.today().addDays(5);
		planObject.Status__c = 'Draft';
		planObjectInsertList.add(planObject);
		insert planObjectInsertList;
		//Investment Area
		list<Investment_Area__c> investmentAreaList = new list<Investment_Area__c>();
		Investment_Area__c investmentAreaObject = new Investment_Area__c();
		investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
		investmentAreaObject.Name = 'Sports NSO';
		investmentAreaObject.Start_Date__c = date.today();
		investmentAreaObject.End_Date__c = date.today().addDays(5);
	    investmentAreaObject.RecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Contestable Investment'].Id;
		investmentAreaObject.Status__c = 'Active';
		investmentAreaList.add(investmentAreaObject);
		insert investmentAreaList;
		//Application Round
		List<Application_Round__c> appRoundList = new List<Application_Round__c>();
		Application_Round__c appRound1 = new Application_Round__c();
		appRound1.Name = 'Round 1';
		appRound1.Investment_Area__c = investmentAreaObject.id;
		appRound1.Status__c = 'Open';
		appRoundList.add(appRound1);
		insert appRoundList;
		//Application
		List<Application__c> applicationInsertList = new List<Application__c>();
		Application__c applicationObject = new Application__c();
		applicationObject.Applicant__c = accountObjectLimited.id;
		applicationObject.Application_Round__c = appRound1.id;
		applicationObject.Contact__c = contactObject.id;
		applicationObject.Date_Received__c = date.today();
		applicationInsertList.add(applicationObject);
		insert applicationInsertList;
		//User
       	Profile p = [Select Id From Profile where Name='Sport NZ - Finance'];
       	User u = new User(Alias='testpr', email='test@test.com', emailEncodingKey='UTF-8', lastname='Testing', languageLocaleKey='en_US',
	   	localeSidKey='en_US', profileId = p.Id,
    	timeZonesIdKey='Pacific/Auckland',
    	username='user1@sportsnz.org.nz.dev');
    	insert u;
		//Assessor
		Assessor__c assessorObject = new Assessor__c();
		assessorObject.Application_Round__c = appRound1.id;
		assessorObject.Assessor__c = u.id;
		insert assessorObject;
		//Assessment Criteria
		Assessment_Criteria__c assCriteriaObject = new Assessment_Criteria__c();
		assCriteriaObject.Name = 'Criteria 1';
		assCriteriaObject.Application_Round__c = appRound1.id;
		assCriteriaObject.Description__c = 'test';
		assCriteriaObject.Weighting__c = 20;
		insert assCriteriaObject;
		
		//update application round
		appRound1.Create_Assessments__c = true;
		update appRound1;
		
	}
	*/
	

}