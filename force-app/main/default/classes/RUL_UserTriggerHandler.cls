public without sharing class RUL_UserTriggerHandler {
    public void beforeInsert(list<User> lstNew){
        set<Id> setProfileId = new set<Id>();
        for(User objU : lstNew){
            setProfileId.add(objU.ProfileId);
        }
        if(!setProfileId.isEmpty()){
            map<Id,Profile> mapId_Profile = returnProfile(setProfileId);
            if(!mapId_Profile.isEmpty()){
                setSuperUser(lstNew, mapId_Profile);
            }
        }
    }
    
    public void beforeUpdate(map<Id,User> mapNewMap, map<Id,User> mapOldMap){
        set<Id> setProfileId = new set<Id>();
        for(User objU : mapNewMap.values()){
            if(objU.ProfileId != mapOldMap.get(objU.Id).ProfileId){
                setProfileId.add(objU.ProfileId);
            }
        }
        if(!setProfileId.isEmpty()){
            map<Id,Profile> mapId_Profile = returnProfile(setProfileId);
            if(!mapId_Profile.isEmpty()){
                setSuperUser(mapNewMap.values(), mapId_Profile);
            }
        }
    }
    
    public map<Id,Profile> returnProfile (set<Id >setIds){
        map<Id,Profile> mapId_Profile = new map<Id,Profile>([
                                                            Select p.Name, p.Id , p.UserLicense.Name
                                                            From Profile p 
                                                            where p.Id IN : setIds]);
        return mapId_Profile;
    }
    
    public void setSuperUser(list<User> lstNew, map<Id,Profile> mapId_Profile){
        for(User objU : lstNew){
            if(mapId_Profile.get(objU.ProfileId) != null
            && mapId_Profile.get(objU.ProfileId).Name.contains('Partner') && mapId_Profile.get(objU.ProfileId).UserLicense.Name.contains('Partner Community')){
                objU.IsPrmSuperUser = true;
            }
        }
    }
    
    //Give Sharing of Account to the user inserted.
    public void afterInsertOfUser(list<User> newUsersList) {
        set<Id> contactIdSet = new set<Id>();
        map<Id,Id> userIdContactIdMap = new map<Id,Id>();
        //Getting Contact Id of Active Community User.
        for(User tempUser : newUsersList) {
            if(tempUser.ContactId != null && tempUser.IsActive == true) {
                contactIdSet.add(tempUser.ContactId);
                userIdContactIdMap.put(tempUser.Id, tempUser.ContactId);
            }
        }
        system.debug('contactIdSet==========='+contactIdSet);
        system.debug('userIdContactIdMap==========='+userIdContactIdMap);
        
        //Getting Account Id Of all Contacts.
        if(contactIdSet.isEmpty() == false) {
            system.debug('Calling Future method.............');
            insertAccountSharing(contactIdSet, userIdContactIdMap);
        }
    }
    
    //Manipulate Sharing Of Account based on user Status(Active/Inactive).
    public void afterUpdateOfUser(list<User> newUpdatedUserList, map<Id,User> oldUserMap) {
        list<User> activeUserList = new list<User>();
        set<Id> inactiveUserIdSet = new set<Id>();
        
        //Segregate Active and Inactive Users.
        for(User tempUser : newUpdatedUserList) {
            if(tempUser.isActive != oldUserMap.get(tempUser.Id).isActive) {
                if(tempUser.isActive == true) {
                    activeUserList.add(tempUser);
                }
                else if(tempUser.isActive == false) {
                    inactiveUserIdSet.add(tempUser.Id);
                }
            }
        }
        system.debug('activeUserList================'+activeUserList);
        //Give Sharing to Active User
        if(activeUserList.isEmpty() == false) {
            afterInsertOfUser(activeUserList);
        }
        
        //Remove Sharing Of Inactive user.
        if(inactiveUserIdSet.isEmpty() == false) {
            list<AccountShare> sharesToBeDeleted = [SELECT Id
                                                         , UserOrGroupId 
                                                      FROM AccountShare
                                                     WHERE UserOrGroupId IN :inactiveUserIdSet AND RowCause = 'Manual'];
                                                     
            if(sharesToBeDeleted != null && sharesToBeDeleted.isEmpty() == false ) {
                delete sharesToBeDeleted; 
            }
        }
    }
    
    @future
    public static void insertAccountSharing(set<Id> contactIdSet, map<Id, Id> userIdContactIdMap) {
        system.debug('Inside Future method.............');
        Map<Id,Contact> contactMap = new Map<Id,Contact>([SELECT Id
                                                               , Name
                                                               , AccountId
                                                            FROM Contact
                                                           WHERE Id IN :contactIdSet]);
        system.debug('contactMap=============='+contactMap);                                                   
        if(contactMap != null && contactMap.isEmpty() == false) {
            list<AccountShare> sharingsToBeGiven = new list<AccountShare>();
            
            //Making the Sharing Record.
            for(Id tempUserId : userIdContactIdMap.keySet()) {
                if(contactMap.containsKey(userIdContactIdMap.get(tempUserId))) {
                    AccountShare tempShare = new AccountShare();
                    tempShare.AccountId = contactMap.get(userIdContactIdMap.get(tempUserId)).AccountId;
                    tempShare.UserOrGroupId = tempUserId;
                    tempShare.AccountAccessLevel = 'Edit';
                    tempShare.CaseAccessLevel = 'Read';
                    tempShare.ContactAccessLevel = 'Read';
                    tempShare.OpportunityAccessLevel = 'Read';
                    //tempShare.RowCause = Schema.AccountShare.RowCause.Manual;
                    sharingsToBeGiven.add(tempShare);
                }
            }
            
             system.debug('sharingsToBeGiven=============='+sharingsToBeGiven);   
            //Inserting Sharing Record.
            if(sharingsToBeGiven.isEmpty() == false) {
                insert sharingsToBeGiven;
            }
        }
    }
}