@isTest
public class Test_Activity_dashboardPageController {
	static testMethod void Test_Activity_dashboardPageController() {
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
        
        Activity__c act = new Activity__c();
        act.Name = 'Test 2';
        act.HOP_Outcome__c ='1.1 Kaiwhakahaere participating as Leaders in their community';
        act.Description__c ='This has been achieved through increased financial investment';
        //act.Expectations_of_Impact__c='';
        act.Due_Date__c = config.Due_Date_For_End_Year_Report__c;//'12/12/2019';
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
        act.Is_Activity_Deleted__c=false;
        act.Activity_Start_Date_Time__c=system.today(); 
   
           
        insert act;
       
          Activity__c act1 = new Activity__c();
        act1.Name = 'Test 2';
  
        act1.HOP_Outcome__c ='1.1 Kaiwhakahaere participating as Leaders in their community';
        act1.Description__c ='This has been achieved through increased financial investment';
        //act.Expectations_of_Impact__c='';
        act1.Due_Date__c = config.Due_Date_For_End_Year_Report__c;//'12/12/2019';
        act1.Due_Date_For_Planned_Activities__c=config.Due_Date_For_Planned_Activities__c;
        //act.Completed_Date__c=;
        act1.Expectations_of_Impact__c='tst';
        act1.By_ActivityGMDmanaged__c='Partially';
        act1.By_ActivityGMDgoverned__c='Partially';
        act1.Through_TypeActNgaTaonga__c='1';
        act1.By_ActivityGMDdelivered__c='Partially';
        act1.Through_TypeActNgaMahi__c='1';
        act1.Through_TypeActNgaKemu__c='1';
        act1.InOn_LocateActKohanga__c='1';
        act1.InOn_LocateActAwa__c='1';
        act1.InOn_LocateActKura__c='1';
        act1.InOn_LocateActMarae__c='1';
        act1.InOn_LocateActMaunga__c='1';
        act1.InOn_LocateActSRC2__c='1';
        act1.InOn_LocateActSRC__c='1';
        act1.InOn_LocateActWahi__c='1';
        act1.InOn_SignificanceLocation__c='Extremely Significant';
        act1.With_PrposeTeReaoKnowledge__c='1';
        act1.With_PrposeTeReoAwareness__c='1';
        act1.With_PrposeTeReaoOther__c='5';
        act1.With_PrposeTikangaOppApply__c='1';
        act1.With_SigniOfTikanga__c='Extremely Significant';
        act1.With_PrposeTeRaoIntegral__c='Fully';
        act1.Particaipation_WhanauType_Marae__c=0;
        act1.Participation_NoOfParticipants__c=500;
        act1.Particaipation_WhanauType_lwi__c=200;
        act1.Particaipation_WhanauType_Hapu__c=200;
        act1.Particaipation_WhanauType_Wh_nau__c=100;
        act1.Particaipation_WhanauType_Kura_Kaupapa__c=0;
        act1.Particaipation_WhanauType_KohangaPunaReo__c=0;
        act1.Particaipation_WhanauType_Whare_Wananga__c=0;
        act1.Particaipation_WhanauType_Whare_Kura__c=0;
        act1.Particaipation_WhanauType_Other__c=0;
        act1.Particaipation_WhanauType_Kaupapa_H_kina__c=0;
        act1.NoOfGroups_Hapu__c=2;
        act1.NoOfGroups_Marae__c=2;
        act1.NoOfGroups_Wh_nau__c=2;
        act1.NoOfGroups_Iwi__c=2;
        act1.NoOfGroups_KohangaPuna__c=2;
        act1.NoOfGroups_Waka__c=2;
        act1.NoOfGroups_Whare_Kura__c=2;
        act1.NoOfGroups_Kura_Kaupapa__c=2;
        act1.NoOfGroups_Kaupapa_H_kinakina__c=2;
        act1.NoOfGroups_Whare_Wananga__c=2;
        //act.NoOfGroups_Other__c='';
        act1.AgeOfParticipants_Mokopuna__c=100;
        act1.AgeOfParticipants_Rangatahi13_15__c=200;
        act1.AgeOfParticipants_Taiohi__c=100;
        act1.AgeOfParticipants_Pakeke40_59__c=100;
        act1.AgeOfParticipants_Rangatahi16_19__c=0;
        act1.AgeOfParticipants_Kaum_tua__c=0;
        act1.AgeOfParticipants_Pakeke_20_39__c=0;
        //act.NoOfGroups_Total__c=20;
        act1.AgeOfParticipants_DidNotRespond__c=0;
        act1.GenderOfParticipants_Tane__c=100;
        //act.AgeOfParticipants_Total__c=40;
        act1.GenderOfParticipants_DidNotRespond__c=200;
        act1.GenderOfParticipants_Wahine__c=200;
        //act.GenderOfParticipants_Total__c=7;
        act1.EthnicityOfParticipants_M_ori__c=100;
        act1.EthnicityOfParticipants_DidNotRespond__c=200;
        act1.EthnicityOfParticipants_Non_M_ori__c=200;
        act1.Is_Activity_Deleted__c=false;
          act1.Activity_Start_Date_Time__c=system.today();
         act1.By_OrgGoverned__c='Yes';       
        insert act1;
        
        Landing_Page_Image_Video__c lpiv = new Landing_Page_Image_Video__c();
        lpiv.Background_Image__c='';
        lpiv.Embed_Video__c='';
        insert lpiv;
        test.startTest();
        Activity_dashboardPageController.getBy_ActivityGMDgoverned(2023);
        Activity_dashboardPageController.getBy_ActivityGMDdelivered(2023);
        //Activity_dashboardPageController.getAgeOfParticipants(2022);
        Activity_dashboardPageController.getBy_ActivityGMDmanaged(2023);
        Activity_dashboardPageController.get_MaleAndFemaleValues(2023);
        Activity_dashboardPageController.getEthnicityOfParticipants(2023);
        Activity_dashboardPageController.fetchUser();
        Activity_dashboardPageController.getNoOfGroups(2023);
        Activity_dashboardPageController.getInOn_LocateAct(2023);
        Activity_dashboardPageController.getActivityDiamension(2023);       
        Activity_dashboardPageController.get_With_PrposeTikanga(2023);
        Activity_dashboardPageController.get_With_PrposeTeReo(2023);
        Activity_dashboardPageController.get_TotalParticipants(2023);
        Activity_dashboardPageController.getbyOrgGovernedPicklist('Activity__c', 'HOP_Outcome__c');
        Activity_dashboardPageController.getVideoOrImage();
        Activity_dashboardPageController.saveActivity(act);
        //Activity_dashboardPageController.SaveChangeReqandMail(act);
        Activity_dashboardPageController.getselectOptions('Activity__c', 'HOP_Outcome__c',2023);
        //Activity_dashboardPageController.showSelectedActivity(act.id);
        Activity_dashboardPageController.get_MaleAndFemalePercentValues(2023);
         Activity_dashboardPageController.getBy_ORGGOVERENED(2023);
       // Activity_dashboardPageController.LinkstoHOPoutcomes(2022);
        Activity_dashboardPageController.isApprovedActivities(act.id);
        Activity_dashboardPageController.deleteSelectedActivity(act.id);
     
        test.stopTest();
}
    
    @isTest
    public static void getBy_ORGGOVERENEDMethod(){
        
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
        act.Due_Date__c = config.Due_Date_For_End_Year_Report__c;//'12/12/2019';
        act.Due_Date_For_Planned_Activities__c=config.Due_Date_For_Planned_Activities__c;
        //act.Completed_Date__c=;
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
        act.Is_Activity_Deleted__c=false;
        act.Activity_Start_Date_Time__c=system.today(); 
       
        
        insert act;
        
         Activity__c act1 = new Activity__c();
        act1.Name = 'Test 2';
       // act1.Activity__c=act.id;
   
        act1.HOP_Outcome__c ='1.1 Kaiwhakahaere participating as Leaders in their community';
        act1.Description__c ='This has been achieved through increased financial investment';
        //act.Expectations_of_Impact__c='';
        act1.Due_Date__c = config.Due_Date_For_End_Year_Report__c;//'12/12/2019';
        act1.Due_Date_For_Planned_Activities__c=config.Due_Date_For_Planned_Activities__c;
        //act.Completed_Date__c=;
        act1.Expectations_of_Impact__c='tst';
        act1.By_ActivityGMDmanaged__c='Partially';
        act1.By_ActivityGMDgoverned__c='Partially';
        act1.Through_TypeActNgaTaonga__c='1';
        act1.By_ActivityGMDdelivered__c='Partially';
        act1.Through_TypeActNgaMahi__c='1';
        act1.Through_TypeActNgaKemu__c='1';
        act1.InOn_LocateActKohanga__c='1';
        act1.InOn_LocateActAwa__c='1';
        act1.InOn_LocateActKura__c='1';
        act1.InOn_LocateActMarae__c='1';
        act1.InOn_LocateActMaunga__c='1';
        act1.InOn_LocateActSRC2__c='1';
        act1.InOn_LocateActSRC__c='1';
        act1.InOn_LocateActWahi__c='1';
        act1.InOn_SignificanceLocation__c='Extremely Significant';
        act1.With_PrposeTeReaoKnowledge__c='1';
        act1.With_PrposeTeReoAwareness__c='1';
        act1.With_PrposeTeReaoOther__c='5';
        act1.With_PrposeTikangaOppApply__c='1';
        act1.With_SigniOfTikanga__c='Extremely Significant';
        act1.With_PrposeTeRaoIntegral__c='Fully';
        act1.Particaipation_WhanauType_Marae__c=0;
        act1.Participation_NoOfParticipants__c=500;
        act1.Particaipation_WhanauType_lwi__c=200;
        act1.Particaipation_WhanauType_Hapu__c=200;
        act1.Particaipation_WhanauType_Wh_nau__c=100;
        act1.Particaipation_WhanauType_Kura_Kaupapa__c=0;
        act1.Particaipation_WhanauType_KohangaPunaReo__c=0;
        act1.Particaipation_WhanauType_Whare_Wananga__c=0;
        act1.Particaipation_WhanauType_Whare_Kura__c=0;
        act1.Particaipation_WhanauType_Other__c=0;
        act1.Particaipation_WhanauType_Kaupapa_H_kina__c=0;
        act1.NoOfGroups_Hapu__c=2;
        act1.NoOfGroups_Marae__c=2;
        act1.NoOfGroups_Wh_nau__c=2;
        act1.NoOfGroups_Iwi__c=2;
        act1.NoOfGroups_KohangaPuna__c=2;
        act1.NoOfGroups_Waka__c=2;
        act1.NoOfGroups_Whare_Kura__c=2;
        act1.NoOfGroups_Kura_Kaupapa__c=2;
        act1.NoOfGroups_Kaupapa_H_kinakina__c=2;
        act1.NoOfGroups_Whare_Wananga__c=2;
        //act.NoOfGroups_Other__c='';
        act1.AgeOfParticipants_Mokopuna__c=100;
        act1.AgeOfParticipants_Rangatahi13_15__c=200;
        act1.AgeOfParticipants_Taiohi__c=100;
        act1.AgeOfParticipants_Pakeke40_59__c=100;
        act1.AgeOfParticipants_Rangatahi16_19__c=0;
        act1.AgeOfParticipants_Kaum_tua__c=0;
        act1.AgeOfParticipants_Pakeke_20_39__c=0;
        //act.NoOfGroups_Total__c=20;
        act1.AgeOfParticipants_DidNotRespond__c=0;
        act1.GenderOfParticipants_Tane__c=100;
        //act.AgeOfParticipants_Total__c=40;
        act1.GenderOfParticipants_DidNotRespond__c=200;
        act1.GenderOfParticipants_Wahine__c=200;
        //act.GenderOfParticipants_Total__c=7;
        act1.EthnicityOfParticipants_M_ori__c=100;
        act1.EthnicityOfParticipants_DidNotRespond__c=200;
        act1.EthnicityOfParticipants_Non_M_ori__c=200;
        act1.Is_Activity_Deleted__c=false;
          act1.Activity_Start_Date_Time__c=system.today();
         act1.By_OrgGoverned__c='Yes';       
        insert act1;
              
        Activity_dashboardPageController.getBy_ORGGOVERENED(2022);
        Activity_dashboardPageController.getBy_ActivityGMDmanaged(2023);
        Activity_dashboardPageController.LinkstoHOPoutcomes(2023);
         Activity_dashboardPageController.get_With_PrposeTikanga(2023);
        Activity_dashboardPageController.get_With_PrposeTeReo(2023);
         Activity_dashboardPageController.get_TotalParticipants(2023);
         //Activity_dashboardPageController.showSelectedActivity('12345');
    }
     @isTest
    public static void get_MaleAndFemalePercentValuesMethod(){
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
        act.Is_Activity_Deleted__c=false;
        act.Is_Read_Only__c=true;
        act.Activity_Start_Date_Time__c=system.today();         
        insert act;
        
         test.startTest();
         Activity_dashboardPageController.get_MaleAndFemalePercentValues(2023);
         Activity_dashboardPageController.get_MaleAndFemaleValues(2023);
         Activity_dashboardPageController.deleteSelectedActivity('123456');
         Activity_dashboardPageController.isApprovedActivities('123456');
         Activity_dashboardPageController.getActivityDiamension(2023);
         Activity_dashboardPageController.getInOn_LocateAct(2023);
        
        
              test.stopTest();
    } 
    
      @isTest
    public static void fetchUserdataMethod(){
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
              Activity_dashboardPageController.fetchUserdata();
        }
        
}
    @isTest
    public static void getbyOrgGovernedPicklistMethod(){
        
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
        act.Particaipation_WhanauType_Whanau_Whaikah__c=0;
        act.Particaipation_WhanauType_Mana_Tipua__c=0;
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

        Activity_dashboardPageController.getbyOrgGovernedPicklist('Activity__c', 'HOP_Outcome__c');
        Activity_dashboardPageController.getselectOptions('Activity__c', 'HOP_Outcome__c',2023); 
       // Activity_dashboardPageController.SaveChangeReqandMail(act);
      
        
          test.stopTest();
    }
  
      @isTest
    public static void getVideoOrImageMethod(){
                Landing_Page_Image_Video__c lpiv = new Landing_Page_Image_Video__c();
        lpiv.Background_Image__c='';
        lpiv.Embed_Video__c='';
        insert lpiv;
         Activity_dashboardPageController.getVideoOrImage();
    }
     @isTest
    public static void getAgeOfParticipantsMethod(){
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
        act.Due_Date__c = config.Due_Date_For_End_Year_Report__c;//'12/12/2019';
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
        act.Is_Activity_Deleted__c=false;
        act.Activity_Start_Date_Time__c=system.today(); 
        act.AgeOfParticipants_Rangatahi13_19__c=100;
        act.AgeOfParticipants_Matua_20_39__c=100;           
        insert act;
        Activity_dashboardPageController.getAgeOfParticipants(2023);
    }
    
      @isTest
    public static void showSelectedActivityMethod(){
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
        act.Due_Date__c = config.Due_Date_For_End_Year_Report__c;//'12/12/2019';
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
       // act.Participation_NoOfParticipants__c=500;
       // act.Particaipation_WhanauType_lwi__c=200;
       // act.Particaipation_WhanauType_Hapu__c=200;
       // act.Particaipation_WhanauType_Wh_nau__c=100;
        //act.Particaipation_WhanauType_Kura_Kaupapa__c=0;
        //act.Particaipation_WhanauType_KohangaPunaReo__c=0;
        //act.Particaipation_WhanauType_Whare_Wananga__c=0;
       // act.Particaipation_WhanauType_Whare_Kura__c=0;
        //act.Particaipation_WhanauType_Other__c=0;
      //  act.Particaipation_WhanauType_Kaupapa_H_kina__c=0;
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
        act.Particaipation_WhanauType_Marae__c=100;
        /*act.AgeOfParticipants_Rangatahi13_15__c=200;
        act.AgeOfParticipants_Taiohi__c=100;
        act.AgeOfParticipants_Pakeke40_59__c=100;
        act.AgeOfParticipants_Rangatahi16_19__c=0;
        act.AgeOfParticipants_Kaum_tua__c=0;
        act.AgeOfParticipants_Pakeke_20_39__c=0;
        //act.NoOfGroups_Total__c=20;
        act.AgeOfParticipants_DidNotRespond__c=0;
        act.GenderOfParticipants_Tane__c=100;
        act.AgeOfParticipants_Total__c=40;
        act.GenderOfParticipants_DidNotRespond__c=200;
        act.GenderOfParticipants_Wahine__c=200;
        //act.GenderOfParticipants_Total__c=7;
        act.EthnicityOfParticipants_M_ori__c=100;
        act.EthnicityOfParticipants_DidNotRespond__c=200;
        act.EthnicityOfParticipants_Non_M_ori__c=200;   
        act.Is_Activity_Deleted__c=false;
        act.Activity_Start_Date_Time__c=system.today(); 
        act.AgeOfParticipants_Rangatahi13_19__c=100;
        act.AgeOfParticipants_Matua_20_39__c=100; */
              
        insert act;
        
        Activity_dashboardPageController.showSelectedActivity(act.id);
        
    }
    @isTest
    public static void SaveChangeReqandMailMethod(){
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
        act.Due_Date__c = config.Due_Date_For_End_Year_Report__c;//'12/12/2019';
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
        act.Particaipation_WhanauType_Marae__c=100;
     
              
        insert act;
        //Activity_dashboardPageController.SaveChangeReqandMail(act);
    }
}