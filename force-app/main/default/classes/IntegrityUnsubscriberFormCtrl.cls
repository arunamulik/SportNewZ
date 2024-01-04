/* Class Name        : IntegrityUnsubscriberFormCtrl
* Description       : Save record in Subscriber__c object with record type Integrity
* Author            : Infobeans - Aruna Mulik
* Created On        : 09/11/2022
* Modification Log  :
* -----------------------------------------------------------------------------------------------------

* Developer             Date              Description

* -----------------------------------------------------------------------------------------------------

* Aruna Mulik          09/11/2022        Initial version
******************************************************************************************************/
public class IntegrityUnsubscriberFormCtrl {
    public Boolean firstNameEmpty {get;set;}
    public Boolean lastNameEmpty {get;set;}
    public Boolean emailEmpty {get;set;}
    public Boolean fieldValidated {get;set;}
    public Boolean updateRec {get;set;}
    public Boolean disabled {get;set;}
    public Subscriber__c sub {get;set;}
    public boolean displayPopUp {get;set;}
    public boolean displayErrorPopUp {get;set;}
    Public Id subid;
    
    /**
    * @description  :Constructor of the classIntegritySubscriberFormCtrl, which is used to
    * 				 initiatialize some boolean variables
    * @author       :Aruna Mulik | 11/09/2022
    **/
    
    public IntegrityUnsubscriberFormCtrl(ApexPages.StandardController controller) {
        displayPopUp = false;
        displayErrorPopUp = false;
        updateRec = false;
        fieldValidated = false;
        this.sub = (Subscriber__c)controller.getRecord();
        firstNameEmpty = false;
        system.debug('In Constructor');
         subid= System.currentPageReference().getParameters().get('subid');
		
        if(subid!= null)
        {
            System.debug('subid : '+subid);
            this.editSubscriber();
            //duprec = true;
        }
    }
    
    /**
    * @description  :This method is used to populate details of subscriber if email id alredy exist in the system
    * @author       :Aruna Mulik | 11/09/2022
    **/
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
                                            WHERE 	Id = :subid
                                            AND RecordType.Name = 'Integrity'
                                            Limit 	1];
        
        displayErrorPopUp = false;
        sub.First_Name__c = subscriberToUpdate.First_Name__c;
        sub.Last_Name__c = subscriberToUpdate.Last_Name__c;
        sub.Email_Address__c = subscriberToUpdate.Email_Address__c;
        sub.Location__c = subscriberToUpdate.Location__c;
        sub.Role__c = subscriberToUpdate.Role__c;
        sub.Organisation__c = subscriberToUpdate.Organisation__c;
    }

    /**
    * @description  :This method decide the flow of action for create or edit record 
    * @author       :Aruna Mulik | 11/09/2022
    **/
    
     public void saveRecord() {
           updateSubscriber();
      }
        
    
    
      
   
    /**
    * @description  :This method is used to close the pop up box which displays thank you message 
    * 				 after submission of form
    * @author       :Aruna Mulik | 11/09/2022
    **/  
    public void closePopup() {
        displayPopUp = false;
        displayErrorPopUp = false;
    }
 	/**
    * @description  :This method is used to confirm validation of required fields
    * @author       :Aruna Mulik | 11/09/2022
    * @return       :Bollean TRUE, if validation is successful otherwise returns FALSE
    **/  
    public boolean emptyFieldCheck() {
        if(sub.First_Name__c=='' || sub.First_Name__c==NULL ||
           sub.Last_Name__c=='' || sub.Last_Name__c==NULL ||
           sub.Email_Address__c=='' || sub.Email_Address__c==NULL)
        {
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
               
           }
        
        else {
            firstNameEmpty = false;
            lastNameEmpty = false;
            emailEmpty = false;
            fieldValidated = true;
        }
        return fieldValidated;
    }

        /**
    * @description  :This method is used to update details of subscriber, if subscriber fills form with 
    * 				 email id that is already exist in the system
    * @author       :Aruna Mulik | 11/09/2022
    **/
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
                                                WHERE 	Id = :subid
                                                AND 	RecordType.Name = 'Integrity'
                                                Limit 	1];
            displayErrorPopUp = false;
            subscriberToUpdate.First_Name__c = sub.First_Name__c;
            subscriberToUpdate.Last_Name__c = sub.Last_Name__c;
            subscriberToUpdate.Email_Address__c = sub.Email_Address__c;
            subscriberToUpdate.Location__c = sub.Location__c;
            subscriberToUpdate.Role__c = sub.Role__c;
            subscriberToUpdate.Organisation__c = sub.Organisation__c;
            subscriberToUpdate.Integrity__c=false;
            Update subscriberToUpdate;
            disabled = true;
            displayPopUp = true;
        }
    }
   
}