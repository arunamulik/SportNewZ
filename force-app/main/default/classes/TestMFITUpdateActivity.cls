@isTest
public class TestMFITUpdateActivity {
    static testMethod void testDoPost(){

        RULconfigurations__c  customsettingdate = new RULconfigurations__c();
        customsettingdate.Name='Test CS';     
        insert customsettingdate;
        
        Activity__c act = new Activity__c();      
        act.Name='Test Activity';
        act.Region__c='Gisborne';
        insert act;
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Activity__c/'; 
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        List<MFITUpdateActivity.twrActivityToUpdate> twrActivityToUpdateList  = new List<MFITUpdateActivity.twrActivityToUpdate>();
        MFITUpdateActivity.twrActivityToUpdate twractToUpdate = new MFITUpdateActivity.twrActivityToUpdate();
        twractToUpdate.activityID = act.id;
        twrActivityToUpdateList.add(twractToUpdate);
        //twractToUpdate.activityID = act.id;
        
        Test.startTest();     
        //MFITUpdateActivity.twrActivityToUpdate  results = new MFITUpdateActivity.twrActivityToUpdate();
        //results.activityID = act.id;
        MFITUpdateActivity.updateActivity(twrActivityToUpdateList);
        Test.stopTest();
    }
    @isTest
    public static void getResponseMethod(){
         Test.startTest();     
       
        MFITUpdateActivity.getResponse('Hi','act.id',123456,'Complete');
        Test.stopTest(); 
    }
}