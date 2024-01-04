/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of RUL_ParticipationDataTrigger

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 18-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of
                                                           RUL_ParticipationDataTrigger
   ==========================================================================================================================
*/
@isTest
private class RUL_ParticipationDataTriggerHandlerTest {
    /*
     @ Description : Method to insert and update Participation Activity Profile Data
    */
    public static testMethod void testInsertAndUpdatePartActProfile() {
        //List<Participation_Data__c> partList = new List<Participation_Data__c>();
        //Creating test data
        List<Participation_Data__c> partList = RUL_Util.createParticipations();
         
       Test.StartTest();
        insert partList;
        Test.StopTest();
      
        Decimal sum=0;
        Decimal Total=0;
        Set<Id> ids = new Set<Id>();
        for(Integer i=0; i<partList.size(); i++) {          
            partList[i].Total_Participants__c = i+1;
            sum = sum + partList[i].Total_Participants__c;
            ids.add(partList[i].Programme_Name__c);
        }
        update partList;
        list<Participation_Activity_Profile_Data__c> parentPartActPro = new list<Participation_Activity_Profile_Data__c>();
        parentPartActPro = [SELECT id,
                                   Total_Participants_This_Year__c
                            FROM Participation_Activity_Profile_Data__c
                            WHERE id in: ids ];
        for(Participation_Activity_Profile_Data__c partActObj: parentPartActPro) {
        if(partActObj.Total_Participants_This_Year__c != NULL) {
                Total=Total+partActObj.Total_Participants_This_Year__c;
            }
        }
        //System.assertEquals(sum,Total);
    }
    
    /*
     @ Description : Method to delete Participation Activity Profile Data
    */
    public static testMethod void testDeletePartActProfile() {     
        List<Participation_Data__c> partList = new List<Participation_Data__c>();
        //Creating test data
        partList = RUL_Util.createParticipations();
        
        Test.StartTest();
        insert partList;
        delete partList;
        Test.StopTest();
        List<Participation_Data__c> updatedPartList = new List<Participation_Data__c>([SELECT id
                                                                                       FROM Participation_Data__c
                                                                                       WHERE id In: partList]);
        System.assertEquals(0,updatedPartList.size());
    }
}