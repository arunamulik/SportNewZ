@isTest
public class Test_communityaccess {
    static testmethod void Test_Communityaccess(){
        Profile p = [SELECT Id,Name FROM Profile WHERE Name='Disability Community (Partner)'];
        test.startTest();   
        communityaccess ca=new communityaccess();
        communityaccess.checkUserHasTWRAccess();
        communityaccess.checkUserHasKahiwiAccess();
        communityaccess.checkUserHasAccessToTWR();
        test.stopTest();
    }
}