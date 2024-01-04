/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of RUL_ProgramTrigger

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 18-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of RUL_ProgramTrigger
   ==========================================================================================================================
*/
@isTest
private class RUL_ProgramTriggerHandlerTest {
    /*
     @ Description : Method to insert and update Programmes
    */
    public static testMethod void testInsertAndUpdateProgrammes() {     
        List<Programme__c> progList = new List<Programme__c>();
        //Creating test data
        progList = RUL_Util.createProgrammes();
        Test.StartTest();
        insert progList;
        Test.StopTest();
        Decimal sumPD=0;
        Decimal sumSD=0;
        Decimal sumAvgSess=0;
        Decimal TotalPd=0;
        Decimal TotalSd=0;
        Decimal TotalAvgSess=0;
        Set<Id> ids = new Set<Id>();
        for(Integer i=0; i<progList.size(); i++) { 
            progList[i].Number_of_Programmes_Delivered__c  = i+2;
            progList[i].Number_of_Sessions_Delivered__c = i+10;
            progList[i].Avg_No_of_Participants_at_Each_Session__c = i+10;
            sumPD = sumPD + progList[i].Number_of_Programmes_Delivered__c;
            sumSD = sumSD + progList[i].Number_of_Sessions_Delivered__c;
            sumAvgSess = sumAvgSess + progList[i].Avg_No_of_Participants_at_Each_Session__c;
            ids.add(progList[i].Organization_Delivered_To__c);
        }
        update progList;
        list<Account> parentAcc = new list<Account>();
        parentAcc = [SELECT id,
                            Avg_No_of_Participants_at_Each_Session__c,
                            No_of_Programs_Delivered__c,
                            No_of_Sessions_Delivered__c
                            FROM Account
                            WHERE id in: ids];
        for(Account accObj: parentAcc) {
            if(accObj.No_of_Programs_Delivered__c != NULL) {
                TotalPd = TotalPd + accObj.No_of_Programs_Delivered__c;
            }
            if(accObj.No_of_Sessions_Delivered__c != NULL) {
                TotalSd = TotalSd + accObj.No_of_Sessions_Delivered__c;
            }
            if(accObj.Avg_No_of_Participants_at_Each_Session__c != NULL) {
                TotalAvgSess = TotalAvgSess + accObj.Avg_No_of_Participants_at_Each_Session__c;
            }
        }                          
        //System.assertEquals(sumPD,TotalPd);
        //System.assertEquals(sumSD,TotalSd);
        //System.assertEquals(sumAvgSess,TotalAvgSess);
    }
    
    /*
     @ Description : Method to delete Programmes
    */
    public static testMethod void testDeleteProgrammes() {     
        List<Programme__c> progList = new List<Programme__c>();
        //Creating test data
        progList = RUL_Util.createProgrammes();
        Test.StartTest();
        insert progList;
        delete progList;
        Test.StopTest();        
        List<Programme__c> updatedProgList = new List<Programme__c>([SELECT id
                                                                     FROM Programme__c
                                                                     WHERE id In: progList]);
        System.assertEquals(0,updatedProgList.size());
    }
}