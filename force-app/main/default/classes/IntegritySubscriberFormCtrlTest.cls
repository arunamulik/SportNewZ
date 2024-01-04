/* Class Name        : IntegritySubscriberFormCtrlTest

* Description       : Test class for IntegritySubscriberFormCtrl class

* Author            : Infobeans - Aruna Mulik

* Created On        : 10/11/2022

* Modification Log  :

* -----------------------------------------------------------------------------------------------------

* Developer             Date               Description

* -----------------------------------------------------------------------------------------------------

* Aruna Mulik          10/11/2022         Initial version
******************************************************************************************************/
@isTest
public class IntegritySubscriberFormCtrlTest {
    @isTest
    static void saveTest() {
        Subscriber__c subscriberObj = new Subscriber__c(First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        IntegritySubscriberFormCtrl manageObj = new IntegritySubscriberFormCtrl(sc);
        manageObj.createSubscriber();
        
        
        manageObj.saveRecord();
        manageObj.closePopup();
        
        System.Test.stopTest();
        List<Subscriber__c> subscriberRecord = [SELECT Name FROM Subscriber__c];
    }
    
    @isTest
    static void updateTest() {
        Subscriber__c subscriberObj = new Subscriber__c(First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        insert subscriberObj;
        
        Subscriber__c subscriberObj2 = new Subscriber__c(First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj2);
        IntegritySubscriberFormCtrl manageObj = new IntegritySubscriberFormCtrl(sc);
        manageObj.createSubscriber();
        manageObj.editSubscriber();
        manageObj.updateSubscriber();
        System.Test.stopTest();
    }

}