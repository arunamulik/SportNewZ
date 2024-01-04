/**
Author: Davanti COnsulting
Created Date: 13-Aug-2015
Description : Associate an Organization for the Private Contacts for the visibility based on the Sharing rules
*/

trigger ContactTrigger on Contact (before insert,before update, after update) {
    List<Account> lstAcc;
    List<User> lstUser;
    //check if it is production or sandbox
    
    Boolean isSandbox = URL.getSalesforceBaseUrl().getHost().contains('cs');
    if(isSandbox){
        lstAcc = [Select id, Name FROM Account Where Name = 'Salesforce Contact Owner' LIMIT 1];
        lstUser = [Select id, FirstName , LastName FROM User Where FirstName = 'SFDC2' AND LastName = 'Admin2' LIMIT 1];
    }
    else{
        lstAcc = [Select id, Name FROM Account Where Name = 'Kahiwi Contacts' LIMIT 1];
        lstUser = [Select id, FirstName , LastName FROM User Where FirstName = 'System' AND LastName = 'Admin' LIMIT 1];
    }
    
    for(Contact contact : Trigger.new){
        if(contact.AccountId == NULL){
            contact.AccountId = (lstAcc != NULL) ? lstAcc[0].Id : '0019000001L47ww';
            contact.ownerId = (lstUser != NULL) ? lstUser[0].Id : '00590000004dqdp';
            
            //contact.AccountId = (isSandbox) ? '001O000000mEmEd' : '0019000001L47ww';
            //contact.ownerId = (isSandbox) ? '005O0000002fTUz' : '00590000004dqdp';
         }
    }
    
    if(trigger.isAfter) {
        if(trigger.isUpdate) {
            RUL_ContactTriggerHandler.afterUpdateOfContact(trigger.new, trigger.oldMap);
        }
    }
}