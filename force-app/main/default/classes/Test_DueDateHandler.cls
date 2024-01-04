@isTest
public class Test_DueDateHandler {
    static testmethod void Test_DueDateHandlerMethod(){
        
        RULconfigurations__c rulConfiguration = new RULconfigurations__c();
        rulConfiguration.Name='Change Request approval setting';
        rulConfiguration.Default_Change_request_Approval__c= '';
        rulConfiguration.Due_Date_For_End_Year_Report__c=system.today()+10;
        rulConfiguration.Due_Date_For_Planned_Activities__c=system.today()+10;
        insert rulConfiguration;
        
        Account acc = new Account(name='TestAcc');
        insert acc;
        
        Contact con= new Contact(LastName = 'TestCon',AccountId = acc.id);
        insert con; 
        
        Profile profiles = [SELECT Id,
                            Name
                            FROM Profile
                            WHERE Name = 'Disability Community (Partner)' limit 1];
        
        User communityUser = new User(FirstName = 'Community',
                                      LastName = 'User'+1,
                                      Alias = 'CU',
                                      Email = 'commTest@test.com',
                                      Username = Math.random() + '@test.com',
                                      CommunityNickname = 'cust6',
                                      ContactId = con.Id,
                                      EmailEncodingKey = 'UTF-8',
                                      TimeZoneSidKey = 'America/Los_Angeles',
                                      LocaleSidKey = 'en_US',
                                      LanguageLocaleKey = 'en_US',
                                      PortalRole = 'Manager',
                                      ProfileId = profiles.Id,
                                      IsActive = true);      
        insert communityUser;
        system.runAs(communityUser) {
            
            RULconfigurations__c  customsetting =[select id,Name,Default_Change_request_Approval__c from RULconfigurations__c where Name=:rulConfiguration.Name];
            List <Activity__c> actt1 = new List <Activity__c>();
            
            Activity__c actt = new Activity__c();
            actt.Name='Test Act';
            actt.Due_Date__c = rulConfiguration.Due_Date_For_End_Year_Report__c;
            actt.Due_Date_For_Planned_Activities__c=rulConfiguration.Due_Date_For_Planned_Activities__c;
            actt.Organisation__c=acc.Id;
            
            insert actt;
            actt1.add(actt);
            
            DueDateHandler.DueDateMethod(actt1);
        }
    }
    static testmethod void Test_DueDateHandlerCatch(){
        Profile p1 = [SELECT Id,Name FROM Profile WHERE Name='Disability Community (Partner)']; 
        User u1 = new User(FirstName='test',Alias = 'standt', Email='standarduser@testorg.com', 
                           EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                           LocaleSidKey='en_US', ProfileId = p1.Id, 
                           TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        communitySportNz_URL__c comm1 = new communitySportNz_URL__c();
        comm1.communitySportNz_URLField__c='';
        insert comm1;
        
        RULconfigurations__c rulConfiguration1 = new RULconfigurations__c();
        rulConfiguration1.Name='Change Request approval setting';
        rulConfiguration1.Default_Change_request_Approval__c= '';
        rulConfiguration1.Due_Date_For_End_Year_Report__c=system.today()+10;
        rulConfiguration1.Due_Date_For_Planned_Activities__c=system.today()+10;
        insert rulConfiguration1;
        RULconfigurations__c  customsetting1 =[select id,Name,Default_Change_request_Approval__c from RULconfigurations__c where Name=:rulConfiguration1.Name];

        Activity__c actt1 = new Activity__c();
        actt1.Name='Test Act';
        actt1.Due_Date__c = rulConfiguration1.Due_Date_For_End_Year_Report__c;
        actt1.Due_Date_For_Planned_Activities__c=rulConfiguration1.Due_Date_For_Planned_Activities__c;
        insert actt1;
    }   
}