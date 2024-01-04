/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of RUL_ContactTrigger

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 25-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of
                                                           RUL_ContactTrigger
   ==========================================================================================================================
*/
@IsTest
private class RUL_ContactTriggerHandlerTest {
    /*
     @ Description : Method to insert and update Account Of Partner User
    */
    private static testmethod void testUpdateAccountOfPartnerUser() { 
                          
        Set<Id> contactIds = new Set<Id>();
        Set<Id> accountIds = new Set<Id>();
        //create test data
        list<User> createCommunityUsers = RUL_Util.createCommunityUsers();
        insert createCommunityUsers;
               
        for(User usr: createCommunityUsers) {
            contactIds.add(usr.contactId);
        }
        list<Contact> lstContacts = new list<Contact>([SELECT Id, AccountId
                                                          FROM Contact
                                                          WHERE Id In: contactIds]);
        for(Contact con: lstContacts) {
            accountIds.add(con.AccountId);
        }
        list<Account> accountList = new list<Account>([SELECT Id
                                                       FROM Account
                                                       WHERE Id In: accountIds]);                                                 
        User objeUser = [SELECT Id, 
                                ProfileId 
                         FROM User 
                         WHERE Id=: UserInfo.getUserId()];
        system.runAs(objeUser) {
            lstContacts[0].AccountId = accountList[1].Id;
            test.startTest();
                update lstContacts[0];
            test.stopTest();
                      
            Integer theNewAccountShareCount = [SELECT count() 
                                               FROM Accountshare
                                               WHERE accountid = :lstContacts[0].accountid];
            System.Assert(theNewAccountShareCount > 0);
        }                                        
    }
    
    /*
     @ Description : Method to insert and update Partner User with No Account
    */
    private static testmethod void testPartnerUserWithNoAccount() { 
                          
        Set<Id> contactIds = new Set<Id>();
        Set<Id> accountIds = new Set<Id>();
        //create test data
        Account accObjNew = new Account(Name = 'NZ Account');
        insert accObjNew;
        accObjNew.IsPartner = true;
        update accObjNew;
        
        Account accObj = new Account(Name = 'Kahiwi Contacts');
        insert accObj;
            
        Account accObjSb = new Account(Name = 'Salesforce Contact Owner');
        insert accObjSb;
        
        Contact conObj = new Contact(Lastname = 'Con', AccountId = accObj.Id);
        insert conObj;
        Contact conObjSb = new Contact(Lastname = 'ConSb', AccountId = accObjSb.Id);
        insert conObjSb;
        
        Profile proSA = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        Profile proSA2 = [SELECT Id FROM Profile WHERE Name like '%Partner%' limit 1];
        
        User adminUser = new User(FirstName = 'System',
                                           LastName = 'Admin',
                                           Alias = 'SA',
                                           Email = 'SATest@test.com',
                                           Username = Math.random() + '@test.com',
                                           EmailEncodingKey = 'UTF-8',
                                           TimeZoneSidKey = 'America/Los_Angeles',
                                           LocaleSidKey = 'en_US',
                                           LanguageLocaleKey = 'en_US',
                                           ProfileId = proSA.Id,
                                           IsActive = true);
        insert adminUser;
        User adminUserSb = new User(FirstName = 'SFDC2',
                                           LastName = 'Admin2',
                                           Alias = 'SA2',
                                           Email = 'SA2Test@test.com',
                                           ContactId = conObjSb.Id,
                                           Username = Math.random() + '@test.com',
                                           CommunityNickname = 'custSA2',
                                           EmailEncodingKey = 'UTF-8',
                                           TimeZoneSidKey = 'America/Los_Angeles',
                                           LocaleSidKey = 'en_US',
                                           LanguageLocaleKey = 'en_US',
                                           ProfileId = proSA2.Id,
                                           IsActive = true);
        insert adminUserSb;
              
        contactIds.add(adminUser.contactId);
        contactIds.add(adminUserSb.contactId);
        
        list<Contact> lstContacts = new list<Contact>([SELECT Id, AccountId
                                                          FROM Contact
                                                          WHERE Id In: contactIds]);
        for(Contact con: lstContacts) {
            accountIds.add(con.AccountId);
        }
        list<Account> accountList = new list<Account>([SELECT Id
                                                       FROM Account
                                                       WHERE Id In: accountIds]);                                                 
        User objeUser = [SELECT Id, 
                                ProfileId 
                         FROM User 
                         WHERE Id=: UserInfo.getUserId()];
                                        
        system.runAs(objeUser) {
        list<Contact> updatedContacts = new list<Contact>();
            for(Contact conObjLst: lstContacts) {
                conObjLst.AccountId = accObjNew.id;
                updatedContacts.add(conObjLst);
            }
        test.startTest();
                update updatedContacts;
        test.stopTest();
        Set<Id> contactUpdtIds = new Set<Id>();
        for(Contact con: updatedContacts) {
            contactUpdtIds.add(con.accountid);
        }
        Integer theNewAccountShareCount = [SELECT count() 
                                           FROM Accountshare
                                           WHERE accountid In:contactUpdtIds];                                 
        //System.assertEquals(theNewAccountShareCount,0);    
        }                                      
    }
}