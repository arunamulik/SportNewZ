@isTest
public class googleAddressAutoFillTest {

   @isTest
    public static void getPlaceDetailsTest() {
        Test.setMock(HttpCalloutMock.class, new googleAddressAutoFillMock());
        googleAddressAutofill.getPlaceDetails('001');
    }
    
    @istest
    public static void getSuggestionsTest() {
        Test.setMock(HttpCalloutMock.class, new googleAddressAutoFillMock());
        googleAddressAutofill.getSuggestions('abc');
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
        googleAddressAutofill.getAddress(activityObj.Id, 'street', 'city', 'state', 'country', '662', '', '');
    }
    
    @istest
    public static void opportunityTest() {
        Opportunity oppObj = new Opportunity();
        oppObj.Name = 'TEST';
        oppObj.StageName = 'Prospecting';
        oppObj.CloseDate = Date.today();
        insert oppObj;
        googleAddressAutofill.getOppStage(oppObj.Id);
    }
}