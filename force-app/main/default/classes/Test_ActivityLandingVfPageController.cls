@isTest
public class Test_ActivityLandingVfPageController {
    static testMethod void Test_ActivityLandingVfPageController(){
        Profile p = [SELECT Id,Name FROM Profile WHERE Name='Disability Community (Partner)']; 
        User u = new User(FirstName='test',Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        
       RULconfigurations__c config= new RULconfigurations__c();
        config.Due_Date_For_End_Year_Report__c=system.today()+10;
        config.Due_Date_For_Planned_Activities__c=system.today()+10;
        config.Name='Change Request approval setting';
        insert config;
        
        communitySportNz_URL__c communityurl = new communitySportNz_URL__c();
        communityurl.Name='';
        communityurl.communitySportNz_URLField__c = '';
        insert communityurl;
        
        Activity__c act = new Activity__c();
        act.Name='test';
        act.Due_Date__c = config.Due_Date_For_End_Year_Report__c;
       act.Due_Date_For_Planned_Activities__c=config.Due_Date_For_Planned_Activities__c;
        act.DiamensionBy_DescRichText__c='testing Editor2';
        act.DiamensionFor_DescRichText__c='testing Editor2';
        act.DiamensionInOn_DescRichText__c='testing Editor2';
        act.DiamensionThrough_DescRichText__c='testing Editor2';
        act.DiamensionWith_DescRichText__c='testing Editor2';
        act.Diamension_By_Score__c='2';
        act.Diamension_For_Score__c='2';
        act.Diamension_InOn_Score__c='2';
        act.Diamension_Thorugh_Score__c='2';
        act.Diamension_With_Score__c='2';
        act.Is_Read_Only__c=true;
        insert act;
        
        PageReference pageRef = Page.QuillRichTextEditor;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id',act.id);
        
        test.startTest();
        ActivityLandingVfPageController testActivityPlan = new ActivityLandingVfPageController();
        testActivityPlan.getScores();
        testActivityPlan.saveTextEditorData();
        ActivityLandingVfPageController.sendChangeNotificationToPartner();
       //testActivityPlan.insertImageAsFile();
        ActivityLandingVfPageController.Dimension();
        ActivityLandingVfPageController.gotoReadonlyMode();
       ActivityLandingVfPageController.setChangeRequest();
        ActivityLandingVfPageController alpc = new ActivityLandingVfPageController();
        alpc.refreshPage();
        test.stopTest();
        
    }
}