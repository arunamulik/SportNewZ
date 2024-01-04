public with sharing class ContractSignedExt {

    public boolean show{get;set;}
    public Business_Case__c iSched {get;set;}
    public ContractSignedExt(ApexPages.StandardController con) {
        
        iSched = [Select Id, Name,Status__c, External_Signatory__c, Date_Signed_By_External_Party__c, Document_Link_1__c, 
                    Document_Link_2__c from Business_Case__c where id=:con.getId() LIMIT 1];
        if(iSched.status__c !='Approved'){
            addPageMessage('The Contract Signed fields can only be recorded when the Investment Schedule status is Approved.');
            show = false;
        }
        else{
            show = true;
        }
    }
    public PageReference saveBtn() {
        PageReference pageRef = null;
        Database.SaveResult sr = database.update(isched,false);
        if(!sr.isSuccess()) {
            for(Database.Error err : sr.getErrors()) {
                addPageMessage(ApexPages.severity.Error, err.getMessage());
            }
        } else {
            pageRef = new PageReference('/' + isched.Id);
        }
        return pageRef;
    }
    // Add Page Messages
    public void addPageMessage(ApexPages.severity severity, Object objMessage) {
        ApexPages.Message pMessage = new ApexPages.Message(severity, String.valueOf(objMessage));
        ApexPages.addMessage(pMessage);
    }
    public void addPageMessage(Object objMessage) {
        addPageMessage(ApexPages.severity.INFO, objMessage);
    }   
}