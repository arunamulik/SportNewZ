/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of RUL_UserTrigger

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 18-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of RUL_UserTrigger
   ==========================================================================================================================
*/
@isTest
private class RUL_UserTriggerHandlerTest {
    /*
     @ Description : Method to insert and update users
    */
    public static testMethod void testInsertAndUpdateUsers() {
        list<user> lstUser = new list<user>();
        //Creating test data
        lstUser = RUL_Util.createCommunityUsers();
        Test.StartTest();
        insert lstUser;
        Test.StopTest();
        for(Integer i=0; i<lstUser.size(); i++) {
            lstUser[i].LastName = 'User'+i;
        }
        user usr= new user();
        usr = [SELECT Id,
                      Name
               FROM User
               WHERE Profile.name = 'System Administrator' and isActive = true limit 1];
        system.runAs(usr) {
            update lstUser;
        }
        System.assertEquals(true, lstUser.size()>0);
    }
}