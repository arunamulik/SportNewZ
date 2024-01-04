@isTest
public class BIBedmPreferenceCtrlTest {
    @isTest
    static void makeUnsubscribeTest() {
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        Weekly__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Monthly__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        BIBedmPreferenceCtrl manageObj = new BIBedmPreferenceCtrl(sc);    
        manageObj.unsubscribe= true;
        manageObj.makeUnsubscribe();
        System.Test.stopTest();
        
        List<Subscriber__c> subscriberRecord = [SELECT Name,Weekly__c, Monthly__c FROM Subscriber__c];
    }
    
    
    @isTest
    static void balanceisbetterCheckedTest() {
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = false,
                                                        Weekly__c = false,
                                                        Healthy_Active_Learning__c = true,
                                                        Monthly__c = false,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        BIBedmPreferenceCtrl manageObj = new BIBedmPreferenceCtrl(sc);
        
        manageObj.unsubscribe= false;
        manageObj.makeUnsubscribe();
        manageObj.balanceisbetterChecked();
        
        System.Test.stopTest();
        
        List<Subscriber__c> subscriberRecord = [SELECT Name,Weekly__c, Monthly__c FROM Subscriber__c];
    }
    
    @isTest
    static void populateDataTest() {
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        Weekly__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Monthly__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        BIBedmPreferenceCtrl manageObj = new BIBedmPreferenceCtrl(sc);
        
        
        manageObj.makeUnsubscribe();
        manageObj.balanceisbetterChecked();
        manageObj.populateData();
        manageObj.closePopup();
        
        System.Test.stopTest();
        
        List<Subscriber__c> subscriberRecord = [SELECT Name,Weekly__c, Monthly__c FROM Subscriber__c];
    }
    @isTest
    static void updateSubscriberTest() {
        Id RecordTypeIdSu = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Public').getRecordTypeId();
        
        Subscriber__c subscriberObj = new Subscriber__c(Balance_is_Better__c = true,
                                                        NZ_Coach__c = true,
                                                        Weekly__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Monthly__c = true,
                                                        RecordTypeId= RecordTypeIdSu,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');
        
        insert subscriberObj;
        
        Subscriber__c subscriberObj1 = new Subscriber__c(Balance_is_Better__c = false,
                                                         Weekly__c = false,
                                                         Healthy_Active_Learning__c = true,
                                                         Monthly__c = false,
                                                         Sector_Update__c = true,
                                                         First_Name__c = 'Test FN Dup',
                                                         Last_Name__c = 'Test LN Dup',
                                                         Email_Address__c = 'test@test.test',
                                                         Location__c = 'Tasman',
                                                         RecordTypeId= RecordTypeIdSu,
                                                         Role__c = 'Coach');
        
        insert subscriberObj1;
        
        Subscriber__c sublst=[Select Id from Subscriber__c where Email_Address__c='test@test.test' limit 1];
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        BIBedmPreferenceCtrl manageObj = new BIBedmPreferenceCtrl(sc);
        
        manageObj.unsubscribe= true;
        manageObj.subid=sublst.Id;       
        manageObj.querySubscriberRecord();
        manageObj.saveRecord();
        manageObj.onLoad();
        manageObj.updateSubscriber();
        manageObj.onLoad();
        manageObj.populateData();
        System.Test.stopTest();
        
    }
}