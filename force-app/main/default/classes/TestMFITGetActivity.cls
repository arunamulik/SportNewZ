@isTest
public class TestMFITGetActivity {

   /* @testSetup
    static void dataSetup() {
        String dt4='12/7/2023';
        Date actendDate4 = Date.parse(dt4);
        String dt5='10/9/2023';
        Date actendDate5 = Date.parse(dt5);
        RULconfigurations__c  customsettingdate = new RULconfigurations__c();
        customsettingdate.Name='Test CS';
        customsettingdate.Due_Date_For_End_Year_Report__c=actendDate4;
        customsettingdate.Due_Date_For_Planned_Activities__c=actendDate5;
        insert customsettingdate;
        
        Activity__c act = new Activity__c();
        Activity__c act1 = new Activity__c();
        String dt1='12/7/2020';
        String dt2='12/7/2021';
        Date actendDate1 = Date.parse(dt1);
        Date actendDate2 = Date.parse(dt2);
        String dt6='12/7/2021';
        String dt7='12/7/2022';
        Date actendDate6 = Date.parse(dt6);
        Date actendDate7 = Date.parse(dt7);
        String dt3='12/7/2022';
        Date actendDate3 = Date.parse(dt3);
        act.Activity_End_Date_Time__c=actendDate2;
        act.Activity_Start_Date_Time__c= actendDate1;
        act.Name='Test Activity';
        act.Region__c='East Coast';
        act.Due_Date__c=actendDate3;
        
        insert act;
        
        String dt8='12/7/2022';
        Date actendDate8 = Date.parse(dt8);
        act1.Activity_End_Date_Time__c=actendDate7;
        act1.Activity_Start_Date_Time__c= actendDate6;
        act1.Name='Test Activity2';
        act1.Region__c='East Coast';
        act1.Due_Date__c=actendDate8;
        
        insert act1;
    }
    
    static testMethod void testGet1() {
        Activity__c acc = [ SELECT Id FROM Activity__c LIMIT 1 ];
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();             
        req.requestURI = '/services/apexrest/Activity__c/';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response= res;
        List<MFITGetActivity.ActivityList> acctResp = MFITGetActivity.getMFITActivityList();
        //system.assertEquals(acctResp.Name, 'Testing');
    }
    
    static testMethod void testGet2() {
        Activity__c acc = [ SELECT Id FROM Activity__c LIMIT 1 ];
        String df='/12/9/2022';
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();             
        req.requestURI = 'https://sportnzgroup--mfitdev.my.salesforce.com/services/apexrest/MFITGetActivity/?activityEndDate='+df+'/';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response= res;
        List<MFITGetActivity.ActivityList> acctResp = MFITGetActivity.getMFITActivityList();
        //system.assertEquals(acctResp.Name, 'Testing');
    }*/
    
    static testMethod void testDoPost(){
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
       
        req.requestURI = '/services/apexrest/Activity__c/'; 
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        MFITGetActivity.ActivityList  results = new MFITGetActivity.ActivityList();
        MFITGetActivity.getMFITActivityList();
        Test.stopTest();
    }
    
        static testMethod void testDoPost1(){
            
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        String df='/1/8/2022';
        req.requestURI = '/services/apexrest/Activity__c/'; 
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        MFITGetActivity.ActivityList  results = new MFITGetActivity.ActivityList();
        MFITGetActivity.getMFITActivityList();
        Test.stopTest();
    }
    
    @isTest
    
    public static void getResponseMethod(){
        String dt4='12/7/2023';
        Date actendDate4 = Date.parse(dt4);
        String dt5='10/9/2023';
        Date actendDate5 = Date.parse(dt5);
        RULconfigurations__c  customsettingdate = new RULconfigurations__c();
        customsettingdate.Name='Test CS';
        customsettingdate.Due_Date_For_End_Year_Report__c=actendDate4;
        customsettingdate.Due_Date_For_Planned_Activities__c=actendDate5;
        insert customsettingdate;
        Activity__c act = new Activity__c();
          //ActivityList objActivity = new ActivityList();
        
         String dt1='12/7/2020';
        String dt2='12/7/2021';
        Date actendDate1 = Date.parse(dt1);
        Date actendDate2 = Date.parse(dt2);
        String dt6='12/7/2021';
        String dt7='12/7/2022';
        Date actendDate6 = Date.parse(dt6);
        Date actendDate7 = Date.parse(dt7);
        String dt3='12/7/2022';
        Date actendDate3 = Date.parse(dt3);
        
        act.Activity_End_Date_Time__c=actendDate2;
        act.Activity_Start_Date_Time__c= actendDate1;
        act.Name='Test Activity';
        act.Region__c='Gisborne';
        act.Due_Date__c=actendDate3;
        
        insert act;
        MFITGetActivity.getResponse(act);
}
}