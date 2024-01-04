/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Programme_Event_Participation Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 30-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of Programme_Event_Participation Page
   ==========================================================================================================================
*/
@isTest
private class ProgEventParticipationControllerTest {
    /*
     @ Description : Method to insert Programme and Event Participation
    */
    public static testMethod void testSaveProgrammes() {
        List<Programme_and_Event_Data__c> progList = new List<Programme_and_Event_Data__c>();
        //Creating test data
        progList = RUL_Util.createProgrammeEventData();
        insert progList;
        list<Account> accList = new list<Account>();
        Set<Id> accIds = new Set<Id>();
        for(Programme_and_Event_Data__c progObj: progList) {
            accIds.add(progObj.Organisation__c);
        }
        accList = [SELECT Id
                   FROM Account
                   WHERE Id in: accIds];
        Test.setCurrentPageReference(new PageReference('Page.Programme_Event_Participation')); 
        apexpages.currentpage().getparameters().put('id', progList[0].id);
                            
        Programme_Event_ParticipationController controller = new Programme_Event_ParticipationController();
        controller.newProg.Organization_Delivered_To__c= accList[0].id;
        PageReference pageRef = controller.save();
        System.assertEquals(pageRef.getUrl(),'/' + controller.newProg.Id);       
    }
    
    /*
     @ Description : Method to cancel Programme and Event Participation
    */
    public static testMethod void testCancelProgrammes() {
        List<Programme_and_Event_Data__c> progList = new List<Programme_and_Event_Data__c>();
        //Creating test data
        progList = RUL_Util.createProgrammeEventData();
        insert progList;
        list<Account> accList = new list<Account>();
        Set<Id> accIds = new Set<Id>();
        for(Programme_and_Event_Data__c progObj: progList) {
            accIds.add(progObj.Organisation__c);
        }
        accList = [SELECT Id
                   FROM Account
                   WHERE Id in: accIds];
        Test.setCurrentPageReference(new PageReference('Page.Programme_Event_Participation')); 
        apexpages.currentpage().getparameters().put('id', progList[0].id);
                            
        Programme_Event_ParticipationController controller = new Programme_Event_ParticipationController();
        controller.newProg.Organization_Delivered_To__c= accList[0].id;
        PageReference pageRef = controller.Cancel();
        System.assertEquals(pageRef.getUrl(),'/' + controller.newProg.Programme_or_Event_Name__c);       
    }
}