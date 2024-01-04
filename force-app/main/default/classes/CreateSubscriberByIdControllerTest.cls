/*--------------------------------------------------------------
Company:        Eternus Solutions
Description:    Test Class for CreateSubscriberByIdController controller class

History
04-10-2022      Aruna Mulik  Modified 
--------------------------------------------------------------*/
@isTest
public class CreateSubscriberByIdControllerTest {
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
        CreateSubscriberByIdController manageObj = new CreateSubscriberByIdController(sc);
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
        Subscriber__c sublst=[Select Id from Subscriber__c where Email_Address__c='test@test.test' limit 1];
        
        /*Subscriber__c subscriberObj1 = new Subscriber__c(Balance_is_Better__c = false,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN Dup',
                                                        Last_Name__c = 'Test LN Dup',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');*/
        
       // insert subscriberObj1;
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj);
        CreateSubscriberByIdController manageObj = new CreateSubscriberByIdController(sc);
        manageObj.subid=sublst.Id;
       
       // manageObj.editSubscriber();
        manageObj.populateData();
         manageObj.saveRecord();
        manageObj.querySubscriberRecord();
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
        
        Subscriber__c subscriberObj1 = new Subscriber__c(Balance_is_Better__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN Dup',
                                                        Last_Name__c = 'Test LN Dup',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach',
                                                         Youth_sport_options__c='I am a coach;Other',
                                                         Partner_Type__c='Other',
                                                         Organisation__c='test',
                                                        // Ko_wai_koe__c='test',
                                                         Do_you_identify_as_Maori__c=false
                                                         
                                                         
                                                        );
        
        insert subscriberObj1;
        Subscriber__c sublst=[Select Id from Subscriber__c where Email_Address__c='test@test.test' limit 1];
       
        /*Subscriber__c subscriberObj2 = new Subscriber__c(Balance_is_Better__c = true,
                                                        NZ_Coach__c = true,
                                                        Healthy_Active_Learning__c = true,
                                                        Sector_Update__c = true,
                                                        First_Name__c = 'Test FN',
                                                        Last_Name__c = 'Test LN',
                                                        Email_Address__c = 'test@test.test',
                                                        Location__c = 'Tasman',
                                                        Role__c = 'Coach');*/
        
        System.Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(subscriberObj1);
        CreateSubscriberByIdController manageObj = new CreateSubscriberByIdController(sc);
        manageObj.subid=sublst.Id;
        
       // manageObj.editSubscriber();
        manageObj.populateData();
        manageObj.saveRecord();
        manageObj.querySubscriberRecord();
       // manageObj.updateSubscriber();
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
        CreateSubscriberByIdController manageObj = new CreateSubscriberByIdController(sc);
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
        CreateSubscriberByIdController manageObj = new CreateSubscriberByIdController(sc);
        manageObj.saveRecord();
        manageObj.closePopup();
        System.Test.stopTest();
        
    }
}