@isTest
public class Test_VfForApprovalController {
    static testmethod void Test_VfForApprovalController(){
        Profile p = [SELECT Id,Name FROM Profile WHERE Name='Disability Community (Partner)']; 
        User u = new User(FirstName='test',Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        communitySportNz_URL_ForPartnerUser__c communityurl = new communitySportNz_URL_ForPartnerUser__c();
        communityurl.URL_ForPartnerUser__c='test';
        insert communityurl;
		
        RULconfigurations__c rulConfiguration = new RULconfigurations__c();
        rulConfiguration.Name='Change Request approval setting';
        rulConfiguration.Default_Change_request_Approval__c= '';
        insert rulConfiguration;
        
       Activity__c act = new Activity__c();
        act.requestForChangeRequest__c= true;
        act.Is_Read_Only__c=true;
        act.Name='test';
        act.Change_Request_Reason__c='';
        insert act;
        
        PageReference pageRef = Page.VfForApproval;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id',act.id);
        
        test.startTest();        
        VfForApprovalController testActivityPlan = new VfForApprovalController();
        testActivityPlan.callApproved();
        testActivityPlan.callApprovedPlannedAct();
        test.stopTest();
    }
}