public class HighPerformanceSubscriberFormCtrl {
    
    public Boolean firstNameEmpty {get;set;}
    public Boolean lastNameEmpty {get;set;}
    public Boolean emailEmpty {get;set;}
    public Boolean locationEmpty {get;set;}
    public Boolean roleEmpty {get;set;}
    public Boolean orgEmpty {get;set;}
    public Boolean fieldValidated {get;set;}
    public Boolean updateRec {get;set;}
    public Boolean disabled {get;set;}
    public Subscriber__c sub {get;set;}
    public boolean displayPopUp {get;set;}
    public boolean displayErrorPopUp {get;set;}
    
    public HighPerformanceSubscriberFormCtrl(ApexPages.StandardController controller) {
        displayPopUp = false;
        displayErrorPopUp = false;
        updateRec = false;
        fieldValidated = false;
        this.sub = (Subscriber__c)controller.getRecord();
        firstNameEmpty = false;
        system.debug('In Constructor');
    }
    
    public void createSubscriber() {
        List<Subscriber__c> matchingSubscriberList = new List<Subscriber__c>();
        Id devRecordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('High Performance Sport NZ').getRecordTypeId();
        matchingSubscriberList = [SELECT Email_Address__c
                                  FROM Subscriber__c
                                  WHERE Email_Address__c = :sub.Email_Address__c
                                  AND RecordType.Name = 'High Performance Sport NZ'
                                  LIMIT 1];
        boolean fieldvalidated = emptyFieldCheck();
        if(fieldvalidated) {
            if(matchingSubscriberList.isEmpty()) {
                sub.RecordTypeId = devRecordTypeId;
                sub.General_Db__c = true;
                sub.Subscribed__c = true;
                insert sub;
                disabled = true;
                displayPopUp = true;
            }
            else {
                displayErrorPopUp = true;
            }
        }
    }
    public void closePopup() {
        displayPopUp = false;
        displayErrorPopUp = false;
    }
    public void editSubscriber() {
        updateRec = true;
        Subscriber__c subscriberToUpdate = [SELECT 	First_Name__c, 
                                            Last_Name__c, 
                                            Email_Address__c,
                                            Organisation__c, 
                                            Partner_Type__c, 
                                            Location__c, 
                                            Role__c
                                            FROM 	Subscriber__c
                                            WHERE 	Email_Address__c = :sub.Email_Address__c
                                            AND RecordType.Name = 'High Performance Sport NZ'
                                            Limit 	1];
        
        displayErrorPopUp = false;
        sub.First_Name__c = subscriberToUpdate.First_Name__c;
        sub.Last_Name__c = subscriberToUpdate.Last_Name__c;
        sub.Email_Address__c = subscriberToUpdate.Email_Address__c;
        sub.Location__c = subscriberToUpdate.Location__c;
        sub.Role__c = subscriberToUpdate.Role__c;
        sub.Organisation__c = subscriberToUpdate.Organisation__c;
    }
    
    public void saveRecord() {
        if(updateRec) {
            updateSubscriber();
        }
        else {
            createSubscriber();
        }
    }
    
    public void updateSubscriber() {
        boolean fieldvalidated = emptyFieldCheck();
        if(fieldvalidated) {
            Subscriber__c subscriberToUpdate = [SELECT 	First_Name__c, 
                                                Last_Name__c, 
                                                Email_Address__c,
                                                Organisation__c, 
                                                Partner_Type__c, 
                                                Location__c, 
                                                Role__c
                                                FROM 	Subscriber__c
                                                WHERE 	Email_Address__c = :sub.Email_Address__c
                                                AND 	RecordType.Name = 'High Performance Sport NZ'
                                                Limit 	1];
            displayErrorPopUp = false;
            subscriberToUpdate.First_Name__c = sub.First_Name__c;
            subscriberToUpdate.Last_Name__c = sub.Last_Name__c;
            subscriberToUpdate.Email_Address__c = sub.Email_Address__c;
            subscriberToUpdate.Location__c = sub.Location__c;
            subscriberToUpdate.Role__c = sub.Role__c;
            subscriberToUpdate.Organisation__c = sub.Organisation__c;
            subscriberToUpdate.Subscribed__c=true;
            Update subscriberToUpdate;
            disabled = true;
            displayPopUp = true;
        }
    }
    
    public boolean emptyFieldCheck() {
        if(sub.First_Name__c=='' || sub.First_Name__c==NULL ||
           sub.Last_Name__c=='' || sub.Last_Name__c==NULL ||
           sub.Email_Address__c=='' || sub.Email_Address__c==NULL ||
           sub.Location__c=='' || sub.Location__c==NULL ||
           sub.Role__c=='' || sub.Role__c==NULL) {
               if(sub.First_Name__c=='' || sub.First_Name__c==NULL) {
                   firstNameEmpty = true;
               }
               else {
                   firstNameEmpty = false;
               }
               if(sub.Last_Name__c=='' || sub.Last_Name__c==NULL) {
                   lastNameEmpty = true;
               }
               else {
                   lastNameEmpty = false;
               }
               if(sub.Email_Address__c=='' || sub.Email_Address__c==NULL) {
                   emailEmpty = true;
               }
               else {
                   emailEmpty = false;
               }
               if(sub.Location__c=='' || sub.Location__c==NULL) {
                   locationEmpty = true; 
               } 
               else { 
                   locationEmpty = false; 
               }
               if(sub.Role__c=='' || sub.Role__c==NULL) {
                   roleEmpty = true; 
               }
               else {
                   roleEmpty = false;
               }
           }
        
        else {
            firstNameEmpty = false;
            lastNameEmpty = false;
            emailEmpty = false;
            locationEmpty = false;
            roleEmpty = false;
            orgEmpty = false;
            fieldValidated = true;
        }
        return fieldValidated;
    }
}