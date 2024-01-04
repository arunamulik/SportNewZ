@isTest
public class Test_VfForSwiperCntroller {
    static testmethod void Test_VfForSwiperCntroller(){
        Profile p = [SELECT Id,Name FROM Profile WHERE Name='Disability Community (Partner)']; 
        User u = new User(FirstName='test',Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        communitySportNz_URL__c comm = new communitySportNz_URL__c();
        comm.communitySportNz_URLField__c='';
        insert comm;

        RULconfigurations__c rulConfiguration = new RULconfigurations__c();
        rulConfiguration.Name='Change Request approval setting';
        rulConfiguration.Default_Change_request_Approval__c= '';
        rulConfiguration.Due_Date_For_End_Year_Report__c=system.today()+10;
        rulConfiguration.Due_Date_For_Planned_Activities__c=system.today()+10;
        insert rulConfiguration;
 		RULconfigurations__c  customsetting =[select id,Name,Default_Change_request_Approval__c from RULconfigurations__c where Name=:rulConfiguration.Name];
      
       // RULconfigurations__c  customsettingemail =[select id,Name,Default_Change_request_Approval__c from RULconfigurations__c where Name='Change Request approval setting'];
        Activity__c act = new Activity__c();
        act.Name='test';
        /*act.Raraunga_Kaunga_Question1__c='hello welcome';
        act.Raraunga_Kaunga_Question2__c='hello welcome';
        act.Raraunga_Kaunga_Question3__c='hello welcome';
        act.Raraunga_Kaunga_Question4__c='hello welcome';
        act.Raraunga_Kaunga_Question5__c='hello welcome';*/
        act.Diamension_By_Score__c='3';
        act.Diamension_For_Score__c='4';
        act.Diamension_InOn_Score__c='2';
        act.Diamension_Thorugh_Score__c='1';
        act.Diamension_With_Score__c='5';
        act.Is_Read_Only__c=true;
        act.reason_for_dimension_by__c='test'; 
        act.reason_for_dimension_for__c='test';
        act.reason_for_dimension_inon__c='test';
        act.reason_for_dimension_through__c='test';
        act.reason_for_dimension_with__c='test';
        act.Due_Date__c=system.today();
        
        insert act;
        Activity_Report__c act1 = new Activity_Report__c();
        act1.Activity_Name__c=act.Id;
        act1.Partner_User__c=u.id;
        act1.Raraunga_Kaunga_Question1__c='hello welcome';
        act1.Raraunga_Kaunga_Question2__c='hello welcome';
        act1.Raraunga_Kaunga_Question3__c='hello welcome';
        act1.Raraunga_Kaunga_Question4__c='hello welcome';
        act1.Raraunga_Kaunga_Question5__c='hello welcome';
        insert act1;
        
        PageReference pageRef = Page.VfForSwiper;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id',act.id);
        
        test.startTest();        
        VfForSwiperCntroller testActivityPlan = new VfForSwiperCntroller();
        testActivityPlan.getScores();
        VfForSwiperCntroller.completeActivity();
        VfForSwiperCntroller.saveTextEditorData();
        VfForSwiperCntroller.setScore();
        VfForSwiperCntroller.setChangeRequest();
        VfForSwiperCntroller.sendChangeNotificationToPartner();
        test.stopTest();
          
    }
}