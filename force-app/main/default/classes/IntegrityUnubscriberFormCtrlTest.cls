/* Class Name        : IntegrityUnubscriberFormCtrlTest
* Description       : Test class for IntegrityUnubscriberFormCtrl
* Author            : Infobeans - Aruna Mulik
* Created On        : 11/11/2022
* Modification Log  :
* -----------------------------------------------------------------------------------------------------

* Developer             Date              Description

* -----------------------------------------------------------------------------------------------------

* Aruna Mulik          11/11/2022        Initial version
******************************************************************************************************/
@isTest
public class IntegrityUnubscriberFormCtrlTest {

 @isTest
    static void saveTest() {
        Id recordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByDeveloperName()
                      .get('Integrity').getRecordTypeId();
        Subscriber__c subscriberObj = new Subscriber__c(First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach',
                                                       Organisation__c='test',
                                                       Integrity__c=true,
                                                       RecordtypeId= recordTypeId);
        insert subscriberObj;
        Subscriber__c sublst=[Select Id from Subscriber__c where Email_Address__c='test@test.test' limit 1];
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        IntegrityUnsubscriberFormCtrl manageObj = new IntegrityUnsubscriberFormCtrl(sc);
       
         manageObj.subid=sublst.Id;
        manageObj.editSubscriber();
        manageObj.updateSubscriber();
        System.Test.stopTest();
  }
    
     @isTest
    static void saveTestNegative2() {
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        High_Performance_Sport_New_Zealand__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true);
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        IntegrityUnsubscriberFormCtrl manageObj = new IntegrityUnsubscriberFormCtrl(sc);
        manageObj.saveRecord();
        manageObj.closePopup();
        System.Test.stopTest();
        
    
}
}