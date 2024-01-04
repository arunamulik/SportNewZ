public without sharing class RUL_SendEmail{
    public string strToAddress {get;set;}
    public string strSubject {get;set;}
    public string strBody {get;set;}
    public Blob attachment {get; set;}
    public string fname {get; set;}
    private Id accountId;
    public RUL_SendEmail() {
        accountId = ApexPages.currentPage().getParameters().get('Id');
        if(accountId != null) {
            list<Account> accountList = [ SELECT Id
                                               , Name
                                               , OwnerId
                                               , Owner.Email
                                            FROM Account
                                           WHERE Id = :accountId LIMIT 1];
                                           
            if(accountList != null && accountList.isEmpty() == false) {
                strToAddress = accountList[0].Owner.Email;
            }
        }
    }
    
    public PageReference sendEmail(){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        // Set recipients to two contact IDs.
        // Replace IDs with valid record IDs in your org.
        message.setPlainTextBody(strBody);
        message.setSubject(strSubject);
        list<String> lstToAddress = new list<String>();
        if(strToAddress.contains(',')) {
            lstToAddress.addAll(strToAddress.split(','));
        }
        else {
            lstToAddress.add(strToAddress);
        }
        message.setToAddresses(lstToAddress);
        if(attachment != null) {
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(fname);
            efa.setBody(attachment);
            message.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
        }
        list<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage> {message};
        try {
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if(accountId != null) {
                PageReference newPageRef = new PageReference('/'+accountId);
                return newPageRef;
            }
        }
        catch(Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return null;
    } // end of sendEmail
} // end of class