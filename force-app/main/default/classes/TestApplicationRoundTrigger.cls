@isTest(SeeAllData=true)
private class TestApplicationRoundTrigger{
	
	static testMethod void applicationRoundTest() {
    	
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
		applicationObject.Name__c = 'Hillary Fund';
		applicationObject.Applicant__c = accountObjectLimited.id;
		applicationObject.Application_Round__c = appRound1.id;
		applicationObject.Contact__c = contactObject.id;
		applicationObject.Date_Received__c = date.today();
		applicationInsertList.add(applicationObject);
		Application__c applicationObject1= new Application__c();
		applicationObject1.Name__c = 'Hillary Fund2';
		applicationObject1.Applicant__c = accountObjectLimited.id;
		applicationObject1.Application_Round__c = appRound1.id;
		applicationObject1.Contact__c = contactObject.id;
		applicationObject1.Date_Received__c = date.today();
		applicationInsertList.add(applicationObject1);
		insert applicationInsertList;
		
		//User
		Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
		Profile p = [Select Id From Profile where Name=:profile.Value__c];
       	//Profile p = [Select Id From Profile where Name='Sport NZ'];
       	
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
		Assessor__c assessorObject1 = new Assessor__c();
		assessorObject1.Application_Round__c = appRound1.id;
		assessorObject1.Assessor__c = userInfo.getUserId();
		insert assessorObject1;


		//Assessment Criteria
		List<Assessment_Criteria__c> assCriteriaList = new List<Assessment_Criteria__c>();
		Assessment_Criteria__c assCriteriaObject = new Assessment_Criteria__c();
		assCriteriaObject.Name = 'Criteria 1';
		assCriteriaObject.Application_Round__c = appRound1.id;
		assCriteriaObject.Description__c = 'test';
		assCriteriaObject.Weighting__c = 20;
		assCriteriaList.add(assCriteriaObject);

		Assessment_Criteria__c assCriteriaObject1 = new Assessment_Criteria__c();
		assCriteriaObject1.Name = 'Criteria 2';
		assCriteriaObject1.Application_Round__c = appRound1.id;
		assCriteriaObject1.Description__c = 'test';
		assCriteriaObject1.Weighting__c = 20;
		assCriteriaList.add(assCriteriaObject1);
		insert assCriteriaList;
		
		//update application round
		appRound1.Create_Assessments__c = true;
		update appRound1;
		
		//assert number of records [Assessor * Applications]
        Integer assessmentCount  = [Select Count() From Assessment__c where Application__r.Application_Round__c=:appRound1.id];
        system.assertEquals(assessmentCount, 4);
        
        //assert number of assessment score [Assessment count * assessment Criteria]
        Integer assessmentScoreCount  = [Select Count() From Assessment_Score__c where Assessment_Criteria__r.Application_Round__c=:appRound1.id];
        system.assertEquals(assessmentScoreCount, 8);
        
        //Test the Scoring VF Pages
        //Test 1 Enter My Assessments
        ApexPages.currentPage().getParameters().put('appId', applicationObject.id);
		ApexPages.currentPage().getParameters().put('appRoundId', appRound1.id);
		ApexPages.currentPage().getParameters().put('retURL', appRound1.id);
		AssessorScoringController assScoring = new AssessorScoringController();
		assScoring.saveBtn();
		assScoring.cancelBtn();
		
		//Test 1 Enter Final Assesment Decisions
        ApexPages.currentPage().getParameters().put('FinalDecision', 'true');
		ApexPages.currentPage().getParameters().put('appRoundId', appRound1.id);
		FinalAssessorScoringController finalScoring = new FinalAssessorScoringController();
		finalScoring.saveBtn();
		finalScoring.cancelBtn();
		
	}
	

}