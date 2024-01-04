@isTest
private class TestPlanEditExtension {
    static testMethod void mySinglePageTest() {
        Account accountObject = new Account();
		accountObject.Name = 'Athletics NZ';
		accountObject.Type = 'National Sporting Organization';
		insert accountObject;
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test';
        workObj.Stage__c = 'Active';
        insert workObj;
        
		Plan__c planObject = new Plan__c();
		planObject.Partner__c = accountObject.id;
		planObject.Start_Date__c = date.today();
		planObject.End_Date__c = date.today().addDays(5);
		planObject.Status__c = 'Draft';
		insert planObject;
		Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
		strategicAreaObject.Name = 'Community Sport';
		strategicAreaObject.Start_Date__c = date.today();
		strategicAreaObject.End_Date__c = date.today().addDays(5);
		insert strategicAreaObject;
		Investment_Area__c investmentAreaObject = new Investment_Area__c();
		investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
		investmentAreaObject.Name = 'Sports NSO';
		investmentAreaObject.Start_Date__c = date.today();
		investmentAreaObject.End_Date__c = date.today().addDays(5);
		investmentAreaObject.Status__c = 'Active';
		insert investmentAreaObject;
		Initiative__c initiativeObject = new Initiative__c();
		initiativeObject.Plan__c = planObject.id;
		initiativeObject.Name = 'Init';
        initiativeObject.Work_Brief__c = workObj.Id;
		initiativeObject.Investment_Area__c = investmentAreaObject.id;
		insert initiativeObject;
		Challenge__c challengeObject = new Challenge__c();
		challengeObject.Partner_Plan__c = planObject.id;
		challengeObject.Name = 'Challenge';
		challengeObject.Description__c = 'Challenge Desc';
		challengeObject.Sport_NZ_Support__c = 'Challenge NZ';
		insert challengeObject;
		Opportunity__c opportunityObject = new Opportunity__c();
		opportunityObject.Partner_Plan__c = planObject.id;
		opportunityObject.Name = 'Challenge';
		opportunityObject.Description__c = 'Challenge Desc';
		opportunityObject.Sport_NZ_Support__c = 'Challenge NZ';
		insert opportunityObject;
		Test.startTest();
		//Call single page
		ApexPages.currentPage().getParameters().put('id', planObject.id);
		ApexPages.StandardController stCon = new ApexPages.StandardController(planObject);
		PlanEditExtension planExtension = new PlanEditExtension(stCon);
		//Call the methods
		//planExtension.pageSectionFields = 'Information:#2::#Partner__c##Status__c##Start_Date__c##End_Date__c##:::#Success:#1::#Partner_Mission_Statement__c##:::#Engagement:#1::#Engagement_Rating__c##Engagement_Plan__c##:::#Value Propositions:#1::#High_Performance_Proposition__c##Community_Sport_Proposition__c##Business_Improvement_Proposition__c##Facilities_Proposition__c##Events_Proposition__c##:::#';
		planExtension.loadEditSectionCall();
		planExtension.refreshPage();
		planExtension.cancelDetails();
		//plain save
		planExtension.saveDetails();
		//validation for blank fields
		planExtension.initWrapList.get(0).initiative.Name = null;
		planExtension.oppWrapList.get(0).opportunity.Name = null;
		planExtension.challengeWrapList.get(0).challenge.Name = null;
		planExtension.saveDetails();
		//delete existing list
		planExtension.addInitiativeRow();
		planExtension.addOpportunityRow();
		planExtension.addChallengeRow();
		planExtension.rowInitDelete = 0;
		planExtension.deleteInitiativeRow();
		planExtension.rowOppDelete = 0;
		planExtension.deleteOpportunityRow();
		planExtension.rowChallDelete = 0;
		planExtension.deleteChallengeRow();
		planExtension.saveDetails();
		Test.stopTest();
		//Call single page with no id
		ApexPages.StandardController stConNo = new ApexPages.StandardController(planObject);
		PlanEditExtension planExtensionNone = new PlanEditExtension(stConNo);
		//Call the methods
		//planExtensionNone.pageSectionFields = 'Information:#2::#Partner__c##Status__c##Start_Date__c##End_Date__c##:::#Success:#1::#Partner_Mission_Statement__c##:::#Engagement:#1::#Engagement_Rating__c##Engagement_Plan__c##:::#Value Propositions:#1::#High_Performance_Proposition__c##Community_Sport_Proposition__c##Business_Improvement_Proposition__c##Facilities_Proposition__c##Events_Proposition__c##:::#';
		planExtensionNone.loadEditSectionCall();
		planExtensionNone.saveDetails();
    }
}