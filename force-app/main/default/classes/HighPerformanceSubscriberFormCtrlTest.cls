@isTest
public class HighPerformanceSubscriberFormCtrlTest {

    @isTest
    static void saveTest() {
        Subscriber__c subscriberObj = new Subscriber__c(First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        HighPerformanceSubscriberFormCtrl manageObj = new HighPerformanceSubscriberFormCtrl(sc);
        manageObj.createSubscriber();
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
        HighPerformanceSubscriberFormCtrl manageObj = new HighPerformanceSubscriberFormCtrl(sc);
        manageObj.createSubscriber();
        manageObj.editSubscriber();
        manageObj.updateSubscriber();
        System.Test.stopTest();
    }
}