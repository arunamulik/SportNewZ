/*--------------------------------------------------------------
Company:        Eternus Solutions
Description:    Test Class for CreateSubscriberCtrl controller class

History
04-10-2022      Aruna Mulik  Modified 
--------------------------------------------------------------*/
@isTest
public class CreateSubscriberCtrlTest {
    
    @isTest
    static void saveTest() {
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        High_Performance_Sport_New_Zealand__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        CreateSubscriberCtrl manageObj = new CreateSubscriberCtrl(sc);
        manageObj.sectorUpdateChecked();
       // manageObj.disabilityChecked();
        manageObj.kaupapaMaoriNewsChecked();
        manageObj.HighPerformanceSportNewZealandChecked();
        manageObj.saveRecord();
        manageObj.onLoad();
        manageObj.balanceisbetterChecked();
        manageObj.populateData();
        System.Test.stopTest();
        
        List<Subscriber__c> subscriberRecord = [SELECT Name FROM Subscriber__c];
    }
    
    @isTest
    static void DupTest() {
        
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        insert subscriberObj;
        
        Subscriber__c subscriberObj1 = new Subscriber__c(Balance_is_Better__c = false,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN Dup',
                                                        Last_Name__c = 'Test LN Dup',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        insert subscriberObj1;
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        CreateSubscriberCtrl manageObj = new CreateSubscriberCtrl(sc);
        manageObj.email='test@test.test';
        manageObj.saveRecord();
        manageObj.editSubscriber();
        manageObj.populateData();
        manageObj.updateSubscriber();
        System.Test.stopTest();
        
    }
    
    
    
    @isTest
    static void updateTest() {
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        insert subscriberObj;
        
        Subscriber__c subscriberObj1 = new Subscriber__c(Balance_is_Better__c = false,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN Dup',
                                                        Last_Name__c = 'Test LN Dup',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach' );
        
        insert subscriberObj1;
        
        Subscriber__c subscriberObj2 = new Subscriber__c(Balance_is_Better__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj2);
        CreateSubscriberCtrl manageObj = new CreateSubscriberCtrl(sc);
        manageObj.saveRecord();
        manageObj.editSubscriber();
        manageObj.populateData();
        manageObj.updateSubscriber();
        System.Test.stopTest();
    }
    
    @isTest
    static void saveTestNegative1() {
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        High_Performance_Sport_New_Zealand__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        CreateSubscriberCtrl manageObj = new CreateSubscriberCtrl(sc);
        manageObj.saveRecord();
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
        CreateSubscriberCtrl manageObj = new CreateSubscriberCtrl(sc);
        manageObj.saveRecord();
        manageObj.closePopup();
        System.Test.stopTest();
        
    }
    
    @isTest
    static void saveTestNegative3() {
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        High_Performance_Sport_New_Zealand__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach',
                                                        Organisation__c = 'TEST',
                                                        Partner_Type__c	= 'Other');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        CreateSubscriberCtrl manageObj = new CreateSubscriberCtrl(sc);
        manageObj.saveRecord();
        System.Test.stopTest();
        
        List<Subscriber__c> subscriberRecord = [SELECT Name FROM Subscriber__c];
        System.assertEquals(1, subscriberRecord.size());
    }
}