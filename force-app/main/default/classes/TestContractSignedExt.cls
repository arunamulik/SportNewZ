@isTest
private class TestContractSignedExt {
    static testMethod void myTestContractedSignedExt() {

	//Strategic Area
	Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
	    strategicAreaObject.Name = 'Community Sport';
	    strategicAreaObject.Start_Date__c = date.today();
	    strategicAreaObject.End_Date__c = date.today().addDays(5);
	    insert strategicAreaObject;
	
	//Investment Area    
	Investment_Area__c investmentAreaObject = new Investment_Area__c();
	    investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
	    investmentAreaObject.Name = 'Sports NSO';
	    investmentAreaObject.Start_Date__c = date.today();
	    investmentAreaObject.End_Date__c = date.today().addDays(5);
	    investmentAreaObject.Status__c = 'Active';
	    insert investmentAreaObject;
	
	// Investment Schedule
    Business_Case__c b = new Business_Case__c();
	b.Name = 'Test';
	b.Investment_Area__c = investmentAreaObject.Id;
	Insert b;
	
   Test.startTest();
    //Call the page
    ApexPages.currentPage().getParameters().put('id', b.id);
    ApexPages.StandardController stCon = new ApexPages.StandardController(b);
    ContractSignedExt c = new ContractSignedExt(stCon);
    
    c.saveBtn();
    }
}