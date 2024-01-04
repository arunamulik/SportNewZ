@isTest
public class Test_ActivityOnboardingLandingPage {
    static testMethod void fetchUserTest() {
        /*Account acc = new Account();
        acc.name='testAccount';
        acc.Type='Supplier';
        acc.Landing_Hero_Image__c='';
        insert acc;

        Contact con= new Contact();
        con.LastName='testContact';
        con.AccountId=acc.Id;
        insert con;
        
        Profile p = [SELECT Id,Name FROM Profile WHERE Name='Disability Community (Partner)']; 
        User u = new User(FirstName='test',Alias = 'standt', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                         TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        u.id=userInfo.getUserId();
        u.ContactId=con.Id;
        // insert u;   */
      
    
            
        Account a = new Account();
			a.Name = 'Test';
		insert a;
		
		Contact cont = new Contact();
			cont.FirstName ='test';
			cont.LastName ='Demo';
        	cont.AccountId=a.id;

		insert cont;
		
			Profile p = [SELECT Id FROM Profile WHERE Name='Disability Community (Partner)']; 
			User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
						EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
						LocaleSidKey='en_US', ProfileId = p.Id, 
						TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        	usr.ContactId=cont.Id;
			insert usr ;
        
        System.runAs(usr) {
           User  contactIds = [select Id,ContactId from User where ContactId != null and  Id =: userInfo.getUserId()];
        }
		
          RULconfigurations__c config= new RULconfigurations__c();
        config.Due_Date_For_End_Year_Report__c=system.today()+10;
        config.Due_Date_For_Planned_Activities__c=system.today()+10;
        config.Name='Change Request approval setting';
        insert config;
        
        Activity__c act = new Activity__c();
        act.Name = 'Test 2';
        act.HOP_Outcome__c ='1.1 Kaiwhakahaere participating as Leaders in their community';
        act.Description__c ='This has been achieved through increased financial investment';
        //act.Expectations_of_Impact__c='';
    	act.Due_Date__c = config.Due_Date_For_End_Year_Report__c;
       act.Due_Date_For_Planned_Activities__c=config.Due_Date_For_Planned_Activities__c;
        //act.Completed_Date__c=;
       act.By_OrgGoverned__c='Yes';
        act.Expectations_of_Impact__c='tst';
        act.By_ActivityGMDmanaged__c='Partially';
        act.By_ActivityGMDgoverned__c='Partially';
        act.Through_TypeActNgaTaonga__c='1';
        act.By_ActivityGMDdelivered__c='Partially';
        act.Through_TypeActNgaMahi__c='1';
        act.Through_TypeActNgaKemu__c='1';
        act.InOn_LocateActKohanga__c='1';
        act.InOn_LocateActAwa__c='1';
        act.InOn_LocateActKura__c='1';
        act.InOn_LocateActMarae__c='1';
        act.InOn_LocateActMaunga__c='1';
        act.InOn_LocateActSRC2__c='1';
        act.InOn_LocateActSRC__c='1';
        act.InOn_LocateActWahi__c='1';
        act.InOn_SignificanceLocation__c='Extremely Significant';
        act.With_PrposeTeReaoKnowledge__c='1';
        act.With_PrposeTeReoAwareness__c='1';
        act.With_PrposeTeReaoOther__c='5';
        act.With_PrposeTikangaOppApply__c='1';
        act.With_SigniOfTikanga__c='Extremely Significant';
        act.With_PrposeTeRaoIntegral__c='Fully';
        act.Particaipation_WhanauType_Marae__c=0;
        act.Participation_NoOfParticipants__c=500;
        act.Particaipation_WhanauType_lwi__c=200;
        act.Particaipation_WhanauType_Hapu__c=200;
        act.Particaipation_WhanauType_Wh_nau__c=100;
        act.Particaipation_WhanauType_Kura_Kaupapa__c=0;
        act.Particaipation_WhanauType_KohangaPunaReo__c=0;
        act.Particaipation_WhanauType_Whare_Wananga__c=0;
        act.Particaipation_WhanauType_Whare_Kura__c=0;
        act.Particaipation_WhanauType_Other__c=0;
        act.Particaipation_WhanauType_Kaupapa_H_kina__c=0;
        act.NoOfGroups_Hapu__c=2;
        act.NoOfGroups_Marae__c=2;
        act.NoOfGroups_Wh_nau__c=2;
        act.NoOfGroups_Iwi__c=2;
        act.NoOfGroups_KohangaPuna__c=2;
        act.NoOfGroups_Waka__c=2;
        act.NoOfGroups_Whare_Kura__c=2;
        act.NoOfGroups_Kura_Kaupapa__c=2;
        act.NoOfGroups_Kaupapa_H_kinakina__c=2;
        act.NoOfGroups_Whare_Wananga__c=2;
        //act.NoOfGroups_Other__c='';
        act.AgeOfParticipants_Mokopuna__c=100;
        act.AgeOfParticipants_Rangatahi13_15__c=200;
        act.AgeOfParticipants_Taiohi__c=100;
        act.AgeOfParticipants_Pakeke40_59__c=100;
        act.AgeOfParticipants_Rangatahi16_19__c=0;
        act.AgeOfParticipants_Kaum_tua__c=0;
        act.AgeOfParticipants_Pakeke_20_39__c=0;
        //act.NoOfGroups_Total__c=20;
        act.AgeOfParticipants_DidNotRespond__c=0;
        act.GenderOfParticipants_Tane__c=100;
        //act.AgeOfParticipants_Total__c=40;
        act.GenderOfParticipants_DidNotRespond__c=200;
        act.GenderOfParticipants_Wahine__c=200;
        //act.GenderOfParticipants_Total__c=7;
        act.EthnicityOfParticipants_M_ori__c=100;
        act.EthnicityOfParticipants_DidNotRespond__c=200;
        act.EthnicityOfParticipants_Non_M_ori__c=200;
        
        insert act;
        system.debug('act--->'+act);
       
        Landing_Page_Image_Video__c lpiv = new Landing_Page_Image_Video__c();
        lpiv.Background_Image__c='';
        lpiv.Embed_Video__c='';
        insert lpiv;
        
        Default_Hero_Image_url__c heroImage= new Default_Hero_Image_url__c();
        heroImage.Landing_Hero_Image__c='';
        insert heroImage;
        
        test.startTest();
        ActivityOnboardingLandingPageController.getCurrentContact(usr.id);
        ActivityOnboardingLandingPageController.userProfilePhoto();
        ActivityOnboardingLandingPageController.fetchUser();
        ActivityOnboardingLandingPageController.getVideoOrImage();
        ActivityOnboardingLandingPageController.saveActivity(act);
        ActivityOnboardingLandingPageController.SaveChangeReqandMail(act);
        ActivityOnboardingLandingPageController.getselectOptions('Activity__c', 'HOP_Outcome__c',2022); 
        ActivityOnboardingLandingPageController.getselectOption('Activity__c', 'HOP_Outcome__c');
        ActivityOnboardingLandingPageController.getbyOrgGovernedPicklist('Activity__c', 'HOP_Outcome__c');
        ActivityOnboardingLandingPageController.getHOPoutcomePicklist();
		ActivityOnboardingLandingPageController.isUserHasActivities();
        ActivityOnboardingLandingPageController.showSelectedActivity(act.id);
        ActivityOnboardingLandingPageController.getlistvalue(2022);
        ActivityOnboardingLandingPageController.getDueDate();
        //ActivityOnboardingLandingPageController.fetchBGImage();
      // ActivityOnboardingLandingPageController.deleteSelectedActivity(act.id);
        //ActivityOnboardingLandingPageController.fetchDefaultBGImage();
        test.stopTest();
    }
    
   static testMethod void fetchElseActivityTest() {
       
       RULconfigurations__c config= new RULconfigurations__c();
        config.Due_Date_For_End_Year_Report__c=system.today()-365;
        config.Due_Date_For_Planned_Activities__c=system.today()-365;
        config.Name='Change Request approval setting';
        insert config;
        Integer currentYear = System.today().year();
		Integer previousYear = currentYear - 1;
        Activity__c act = new Activity__c();
        act.Name = 'Test 2';
        act.HOP_Outcome__c ='1.1 Kaiwhakahaere participating as Leaders in their community';
        act.Description__c ='This has been achieved through increased financial investment';
        //act.Expectations_of_Impact__c='';
 		 act.Due_Date__c = config.Due_Date_For_End_Year_Report__c;
     act.Due_Date_For_Planned_Activities__c=config.Due_Date_For_Planned_Activities__c;
      // act.Completed_Date__c=;
       act.By_OrgGoverned__c='Yes';
        act.Expectations_of_Impact__c='tst';
        act.By_ActivityGMDmanaged__c='Partially';
        act.By_ActivityGMDgoverned__c='Partially';
        act.Through_TypeActNgaTaonga__c='1';
        act.By_ActivityGMDdelivered__c='Partially';
        act.Through_TypeActNgaMahi__c='1';
        act.Through_TypeActNgaKemu__c='1';
        act.InOn_LocateActKohanga__c='1';
        act.InOn_LocateActAwa__c='1';
        act.InOn_LocateActKura__c='1';
        act.InOn_LocateActMarae__c='1';
        act.InOn_LocateActMaunga__c='1';
        act.InOn_LocateActSRC2__c='1';
        act.InOn_LocateActSRC__c='1';
        act.InOn_LocateActWahi__c='1';
        act.InOn_SignificanceLocation__c='Extremely Significant';
        act.With_PrposeTeReaoKnowledge__c='1';
        act.With_PrposeTeReoAwareness__c='1';
        act.With_PrposeTeReaoOther__c='5';
        act.With_PrposeTikangaOppApply__c='1';
        act.With_SigniOfTikanga__c='Extremely Significant';
        act.With_PrposeTeRaoIntegral__c='Fully';
        act.Particaipation_WhanauType_Marae__c=null;
        act.Participation_NoOfParticipants__c=null;
        act.Particaipation_WhanauType_lwi__c=null;
        act.Particaipation_WhanauType_Hapu__c=null;
        act.Particaipation_WhanauType_Wh_nau__c=null;
        act.Particaipation_WhanauType_Kura_Kaupapa__c=null;
        act.Particaipation_WhanauType_KohangaPunaReo__c=null;
        act.Particaipation_WhanauType_Whare_Wananga__c=null;
        act.Particaipation_WhanauType_Whare_Kura__c=null;
        act.Particaipation_WhanauType_Other__c=null;
        act.Particaipation_WhanauType_Kaupapa_H_kina__c=null;
        act.NoOfGroups_Hapu__c=null;
        act.NoOfGroups_Marae__c=null;
        act.NoOfGroups_Wh_nau__c=null;
        act.NoOfGroups_Iwi__c=null;
        act.NoOfGroups_KohangaPuna__c=null;
        act.NoOfGroups_Waka__c=null;
        act.NoOfGroups_Whare_Kura__c=null;
        act.NoOfGroups_Kura_Kaupapa__c=null;
        act.NoOfGroups_Kaupapa_H_kinakina__c=null;
        act.NoOfGroups_Whare_Wananga__c=null;
        //act.NoOfGroups_Other__c='';
        act.AgeOfParticipants_Mokopuna__c=null;
        act.AgeOfParticipants_Rangatahi13_15__c=null;
        act.AgeOfParticipants_Taiohi__c=null;
        act.AgeOfParticipants_Pakeke40_59__c=null;
        act.AgeOfParticipants_Rangatahi16_19__c=null;
        act.AgeOfParticipants_Kaum_tua__c=null;
        act.AgeOfParticipants_Pakeke_20_39__c=null;
        //act.NoOfGroups_Total__c=20;
        act.AgeOfParticipants_DidNotRespond__c=null;
        act.GenderOfParticipants_Tane__c=null;
        //act.AgeOfParticipants_Total__c=40;
        act.GenderOfParticipants_DidNotRespond__c=null;
        act.GenderOfParticipants_Wahine__c=null;
        //act.GenderOfParticipants_Total__c=7;
        act.EthnicityOfParticipants_M_ori__c=null;
        act.EthnicityOfParticipants_DidNotRespond__c=null;
        act.EthnicityOfParticipants_Non_M_ori__c=null;
        
        insert act;
         test.startTest();
       ActivityOnboardingLandingPageController.getselectOptions('Activity__c', 'HOP_Outcome__c',previousYear); 
       test.stopTest();
    }
    
     @isTest
    public static void getPlaceDetailsTest() {
        Test.setMock(HttpCalloutMock.class, new googleAddressAutoFillMock());
        ActivityOnboardingLandingPageController.getPlaceDetailsCommunity('001');
    }
    
    @istest
    public static void getSuggestionsTest() {
        Test.setMock(HttpCalloutMock.class, new googleAddressAutoFillMock());
        ActivityOnboardingLandingPageController.getSuggestionsCommunity('abc');
    }
    
    @istest
    public static void getAddressTest() {
        RULconfigurations__c rulObj = new RULconfigurations__c();
        rulObj.Name = 'Test';
        rulObj.Due_Date_For_End_Year_Report__c = Date.today()+8;
        rulObj.Due_Date_For_Planned_Activities__c = Date.today()+10;
        System.debug('rulObj###'+rulObj);
        insert rulObj;
        Activity__c activityObj = new Activity__c();
        activityObj.Name = 'TEST';
        insert activityObj;
        ActivityOnboardingLandingPageController.getAddressCommunity(activityObj.Id, 'street', 'city', 'state', 'country', '662', '', '');
    }
    @istest
    public static void deleteSelectedActivityTest(){
        test.startTest();
            RULconfigurations__c rulObj = new RULconfigurations__c();
        rulObj.Name = 'Test';
        rulObj.Due_Date_For_End_Year_Report__c = Date.today()+8;
        rulObj.Due_Date_For_Planned_Activities__c = Date.today()+10;
        System.debug('rulObj###'+rulObj);
        insert rulObj;
        Activity__c activityObj = new Activity__c();
        activityObj.Name = 'TEST';
        activityObj.HOP_Outcome__c='1.1 Kaiwhakahaere participating as Leaders in their community';
        activityObj.Is_Activity_Deleted__c=false;
        activityObj.Activity_Start_Date_Time__c = system.Now();
        //activityObj.Participation_NoOfParticipants__c='' ;
        insert activityObj;
        
            activity__c acti = new activity__c();
        acti=[Select id, name, HOP_Outcome__c,Is_Activity_Deleted__c,Activity_Start_Date_Time__c From activity__c where Id =: activityObj.id ];
       
       List<activity__c> actList = [select id,Name,HOP_Outcome__c, Due_Date__c, Description__c, Expectations_of_Impact__c,Change_Request_Reason__c,
                                 By_OrgGoverned__c,
                                 Is_Read_Only__c,
                                 Region__c,
                              
                                 COVID_19_ALERT_LEVEL__c,
                                 HOP_Outcome_Domain__c,
                                 By_ActivityGMDgoverned__c, 
                                 By_ActivityGMDmanaged__c,
                                 By_ActivityGMDdelivered__c, 
                                 Participation_NoOfParticipants__c,
                                 Particaipation_WhanauType_Marae__c,
                                 Particaipation_WhanauType_Hapu__c,
                                 Particaipation_WhanauType_lwi__c,
                                 Particaipation_WhanauType_Wh_nau__c,
                                 Particaipation_WhanauType_Waka__c,
                                 Particaipation_WhanauType_KohangaPunaReo__c,
                                 Particaipation_WhanauType_Kura_Kaupapa__c,
                                 Particaipation_WhanauType_Whare_Kura__c,
                                 Particaipation_WhanauType_Whare_Wananga__c,
                                 Particaipation_WhanauType_Kaupapa_H_kina__c	,
                                 Particaipation_WhanauType_Other__c,
                                 NoOfGroups_Marae__c,
                                 NoOfGroups_Hapu__c,
                                 NoOfGroups_Iwi__c,
                                 NoOfGroups_Wh_nau__c,
                                 NoOfGroups_Waka__c,
                                 NoOfGroups_KohangaPuna__c,
                                 NoOfGroups_Kura_Kaupapa__c,
                                 NoOfGroups_Whare_Kura__c,
                                 NoOfGroups_Whare_Wananga__c,
                                 NoOfGroups_Kaupapa_H_kinakina__c,
                                 NoOfGroups_Other__c,
                                 Through_typeActNgaTaonga__c,
                                 Through_TypeActNgaKemu__c,
                                 Through_TypeActNgaMahi__c,
                                 Through_typeActHakinakina__c,
                                 Through_typeActLandO__c,
                                 InOn_LocateActMaunga__c,
                                 InOn_LocateActAwa__c,
                                 InOn_LocateActMarae__c,
                                 InOn_LocateActKohanga__c,
                                 InOn_LocateActKura__c,
                                 InOn_LocateActWahi__c,
                                 InOn_LocateActSRC__c,
                                 InOn_LocateActSRC2__c,
                                 InOn_SignificanceLocation__c,
                                 With_UseOfTeReo__c,
                                 With_PrposeTeReoAwareness__c,
                                 With_PrposeTeReaoKnowledge__c,
                                 With_PrposeTeReaoExtendAct__c,
                                 With_PrposeTeReaoOther__c,
                                 With_PrposeTeRaoIntegral__c,
                                 With_SignificanceTeRao__c,
                                 With_PrposeTikangaRaiseAwareness__c,
                                 With_PrposeTikangaBuildKnowledge__c,
                                 With_PrposeTikangaOppApply__c,
                                 With_PrposeTikangaOther__c,
                                 With_PrposeTikangaIntegral__c,
                                 With_SigniOfTikanga__c,
                                 Particaipation_WhanauType_Total__c,
                                 NoOfGroups_Total__c,
                                 AgeOfParticipants_Mokopuna__c,
                                 AgeOfParticipants_Taiohi__c,
                                 AgeOfParticipants_Rangatahi13_15__c,
                                 AgeOfParticipants_Rangatahi16_19__c,
                                 AgeOfParticipants_Pakeke_20_39__c,
                                 AgeOfParticipants_Pakeke40_59__c,
                                 AgeOfParticipants_Kaum_tua__c,
                                 AgeOfParticipants_DidNotRespond__c,
                                 AgeOfParticipants_Total__c,
                                 GenderOfParticipants_Tane__c,
                                 GenderOfParticipants_Wahine__c,
                                 GenderOfParticipants_DidNotRespond__c,
                                 GenderOfParticipants_Total__c,
                                 EthnicityOfParticipants_M_ori__c,
                                 EthnicityOfParticipants_Non_M_ori__c,
                                 EthnicityOfParticipants_DidNotRespond__c,
                                 EthnicityOfParticipants_Total__c,
                                 DiamensionBy_DescRichText__c,
                                 DiamensionThrough_DescRichText__c,
                                 DiamensionInOn_DescRichText__c,
                                 DiamensionWith_DescRichText__c,
                                 DiamensionFor_DescRichText__c,
                                 Diamension_By_Score__c,
                                 Diamension_Thorugh_Score__c,
                                 Diamension_InOn_Score__c,
                                 Diamension_With_Score__c,
                                 Diamension_For_Score__c,
                             
                                 Is_Activity_Deleted__c
                                 from Activity__c 
                                 where HOP_Outcome__c !=null 
                                 AND Is_Activity_Deleted__c=false 
                                 AND CALENDAR_YEAR(Due_Date__c )=2022];
                     system.debug('actList' +actList);                 
                                     
        system.debug('newa_____ctivity' +activityObj);
       // ActivityOnboardingLandingPageController.deleteSelectedActivity(true,string.valueof(activityObj.id));
 
        ActivityOnboardingLandingPageController.getselectOptions('Activity__c', 'HOP_Outcome__c',2022);
         ActivityOnboardingLandingPageController.deleteSelectedActivity(true,string.valueof(activityObj.id));
       
       // ActivityOnboardingLandingPageController.SaveChangeReqandMail(activityObj);
        test.stopTest();
    }
    @istest
    public static void fetchstatic_resourceTest() {
        list<StaticResource> static_resource  = new list<StaticResource>();
        ActivityOnboardingLandingPageController.fetchstatic_resource();
    }
   @istest
    public static void fetchBGImage() {
          Account a = new Account();
			a.Name = 'Test';
		insert a;
		
       Contact cont = new Contact();
			cont.FirstName ='test';
			cont.LastName ='Demo';
        	cont.AccountId=a.id;

		insert cont;
		
			Profile p = [SELECT Id FROM Profile WHERE Name='Disability Community (Partner)']; 
			User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
						EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
						LocaleSidKey='en_US', ProfileId = p.Id, 
						TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        	usr.ContactId=cont.Id;
			insert usr ;
          System.runAs(usr) {
           User  contactIds = [select Id,ContactId from User where ContactId != null and  Id =: userInfo.getUserId()];
              ActivityOnboardingLandingPageController.fetchBGImage();
        }
        
          
    }
   
    @istest
    public static void getContactTest() {
             Account a = new Account();
			a.Name = 'Test';
		insert a;
        	
       Contact cont = new Contact();
			cont.FirstName ='test';
			cont.LastName ='Demo';
        	cont.AccountId=a.id;

		insert cont;
        Profile p = [SELECT Id FROM Profile WHERE Name='Disability Community (Partner)']; 
			User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
						EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
						LocaleSidKey='en_US', ProfileId = p.Id, 
						TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com');
        	usr.ContactId=cont.Id;
			insert usr ;
          System.runAs(usr) {
              
           User  contactIds = [select Id,ContactId from User where ContactId != null and  Id =: userInfo.getUserId()];
              system.debug('user' +contactIds);
               ActivityOnboardingLandingPageController.getContact();
              
        }
        
         
    }
     @istest
    public static void isDueDatePassedTest() {
        RULconfigurations__c rulObj = new RULconfigurations__c();
        rulObj.Name = 'Test';
        rulObj.Due_Date_For_End_Year_Report__c = Date.today()+8;
        rulObj.Due_Date_For_Planned_Activities__c = Date.today()+10;
        System.debug('rulObj###'+rulObj);
        insert rulObj;
        ActivityOnboardingLandingPageController.isDueDatePassed();
    }
    @istest
    public static void fetchDefaultBGImageTest() {
        Default_Hero_Image_url__c defaultHero = new Default_Hero_Image_url__c();
        defaultHero.Landing_Hero_Image__c =' Demo Image';
        insert defaultHero;
         ActivityOnboardingLandingPageController.fetchDefaultBGImage();
    }
    /* @istest
    public static void SaveChangeReqandMailTest() {
        test.startTest();
            RULconfigurations__c rulObj = new RULconfigurations__c();
        rulObj.Name = 'Test';
        rulObj.Due_Date_For_End_Year_Report__c = Date.today()+8;
        rulObj.Due_Date_For_Planned_Activities__c = Date.today()+10;
        System.debug('rulObj###'+rulObj);
        insert rulObj;
        Activity__c activityObj = new Activity__c();
        activityObj.Name = 'TEST';
        activityObj.HOP_Outcome__c='1.1 Kaiwhakahaere participating as Leaders in their community';
        activityObj.Is_Activity_Deleted__c=false;
        activityObj.Activity_Start_Date_Time__c = system.Now();
        //activityObj.Participation_NoOfParticipants__c='' ;
        insert activityObj;
        ActivityOnboardingLandingPageController.SaveChangeReqandMail(activityObj);
    }*/
    
    
    @istest
    public static void opportunityTest() {
        Opportunity oppObj = new Opportunity();
        oppObj.Name = 'TEST';
        oppObj.StageName = 'Prospecting';
        oppObj.CloseDate = Date.today();
        insert oppObj;
        ActivityOnboardingLandingPageController.getOppStageCommunity(oppObj.Id);
    }
    @isTest
    static void testActivityClone() {
        DateTime enddate = DateTime.Now().AddDays(15);
        DateTime startdate = DateTime.Now();
       // RULconfigurations__c rulObj = new RULconfigurations__c();
        // Create a test Activity record
         RULconfigurations__c config= new RULconfigurations__c();
        config.Due_Date_For_End_Year_Report__c=system.today()+10;
        config.Due_Date_For_Planned_Activities__c=system.today()+10;
        config.Name='Change Request approval setting';
        insert config;
        
        Activity__c testActivity = new Activity__c(
            Name = 'Test Activity',
            HOP_Outcome__c = '3.1 Revitalisation and further development of sport and traditional physical recreation',
            Description__c='Test description',
            Expectations_of_Impact__c='Test impact',
            Event_Organiser_First_Name__c='test First Name',
            Event_Organiser_Last_Name__c='test Last Name',
            Event_Organiser_Email__c='test@gmail.com',
            Event_Description__c='test event description',
            Activity_Start_Date_Time__c=startdate,
            Activity_End_Date_Time__c=enddate,
            Street__c='Test street',
            City__c='Test City',
            State__c='Test State',
            Country__c='Test country',
            Region__c='Bay of Plenty',
            Due_Date__c = config.Due_Date_For_End_Year_Report__c,
     		Due_Date_For_Planned_Activities__c=config.Due_Date_For_Planned_Activities__c
            
        );
        
        insert testActivity;

        // Call the activityClone method with the test Activity Id
        Test.startTest();
        ActivityOnboardingLandingPageController.activityClone(testActivity.Id);
        Test.stopTest();

        // Verify that the cloned record was inserted
        List<Activity__c> clonedRecords = [SELECT Id, Name FROM Activity__c WHERE Name = 'COPY Test Activity'];
        System.assertEquals(1, clonedRecords.size(), 'Cloned record should be inserted');
    }
    @isTest
    static void testActivityYearCheck() {
         RULconfigurations__c config= new RULconfigurations__c();
        config.Due_Date_For_End_Year_Report__c=system.today()+10;
        config.Due_Date_For_Planned_Activities__c=system.today()+20;
        config.Name='Change Request approval setting';
        insert config;
          DateTime enddate = DateTime.Now().AddDays(15);
        DateTime startdate = DateTime.Now();
        // Create a test Activity record with a Due Date
       Activity__c testActivity = new Activity__c(
            Name = 'Test Activity',
            HOP_Outcome__c = '3.1 Revitalisation and further development of sport and traditional physical recreation',
            Description__c='Test description',
            Expectations_of_Impact__c='Test impact',
            Event_Organiser_First_Name__c='test First Name',
            Event_Organiser_Last_Name__c='test Last Name',
            Event_Organiser_Email__c='test@gmail.com',
            Event_Description__c='test event description',
            Activity_Start_Date_Time__c=startdate,
            Activity_End_Date_Time__c=enddate,
            Street__c='Test street',
            City__c='Test City',
            State__c='Test State',
            Country__c='Test country',
            Region__c='Bay of Plenty',
            Due_Date__c = config.Due_Date_For_End_Year_Report__c,
     		Due_Date_For_Planned_Activities__c=config.Due_Date_For_Planned_Activities__c
            
        );
        
        insert testActivity;
       
        // Call the activityYearCheck method with the test Activity Id
        Activity__c resultActivity = ActivityOnboardingLandingPageController.activityYearCheck(testActivity.Id, '2023', '2024');

        // Verify the behavior of the method
        System.assertNotEquals(null, resultActivity, 'Expected activity to be returned');
        
        // Call the activityYearCheck method with different year values
        resultActivity = ActivityOnboardingLandingPageController.activityYearCheck(testActivity.Id, '2021', '2022');

        // Verify the behavior of the method
        System.assertEquals(null, resultActivity, 'Expected null since years do not match');
    }
}