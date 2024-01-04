public class RUL_ContactTriggerHandler {
    
    public static void afterUpdateOfContact(list<Contact> updatedContactList, map<Id,Contact> oldContactMap) {
        set<Id> contactIdSet = new set<Id>();
        for(Contact tempCont : updatedContactList) {
            if(tempCont.AccountId != oldContactMap.get(tempCont.Id).AccountId) {
                contactIdSet.add(tempCont.Id);
            }
        }
        
        if(contactIdSet.isEmpty() == false) {
            list<User> userList = [SELECT Id
                                        , ContactId
                                        , IsActive
                                     FROM User
                                    WHERE ContactId IN :contactIdSet];
            if(userList != null && userList.isEmpty() == false) {
                map<Id, User> contactIdUserMap = new map<Id, User>();
                for(User tempUser : userList) {
                    contactIdUserMap.put(tempUser.ContactId, tempUser);
                }
                
                if(contactIdUserMap.isEmpty() == false) {
                    set<Id> userSharingToBeDeleted = new set<Id>();
                    list<User> sharingToBeGiven = new list<User>();
                    for(Contact tempCont : updatedContactList) {
                        if(tempCont.AccountId != oldContactMap.get(tempCont.Id).AccountId && contactIdUserMap.containsKey(tempCont.Id)) {
                            if(tempCont.AccountId != null) {
                                userSharingToBeDeleted.add(contactIdUserMap.get(tempCont.Id).Id);
                                sharingToBeGiven.add(contactIdUserMap.get(tempCont.Id));
                            }
                            else {
                                userSharingToBeDeleted.add(contactIdUserMap.get(tempCont.Id).Id);
                            }
                        }
                    }
                    
                    if(userSharingToBeDeleted.isEmpty() == false) {
                        list<AccountShare> toBeDeletedList = [SELECT Id
                                                                   , UserOrGroupId
                                                                FROM AccountShare
                                                               WHERE UserOrGroupId IN :userSharingToBeDeleted];
                                                               
                        if(toBeDeletedList != null && toBeDeletedList.isEMpty() == false) {
                            delete toBeDeletedList;
                        }
                    }
                    
                    if(sharingToBeGiven.isEmpty() == false) {
                        RUL_UserTriggerHandler objClass = new RUL_UserTriggerHandler();
                        objClass.afterInsertOfUser(sharingToBeGiven);
                    }
                }
            }
        }
    }
}