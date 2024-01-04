global class SendPDFAgreementReport {
    
    public static Boolean flag = true;
    public string doSave{get;set;}
    
    public SendPDFAgreementReport(ApexPages.StandardController controller) {
        doSave = ApexPages.currentPage().getParameters().get('doSave');
        system.debug('constructor---------------');     
    }
    
    public pagereference emailLeadPdf(){ 
    system.debug('RunOnce.firstRun------'+RunOnce.firstRun);
        if(RunOnce.firstRun){
            system.debug('method--------'); 
            if(doSave == 'No'){
                return null;
            }         
            PageReference pdfPage= Page.InitiativeAgreementPage;
            pdfPage.getParameters().put('doSave', 'No');
            String doSave = pdfPage.getParameters().get('doSave');  
            Id cId = ApexPages.currentPage().getParameters().get('id');
            Business_Case__c objIS = new Business_Case__c();
            objIS = [select id,name from Business_Case__c where id =: cId]; 
            system.debug('objIS'+objIS);     
            pdfPage.getParameters().put('id',cId);           
            Blob pdf1;
            try {
                pdf1 = pdfPage.getContent();          
            } catch (VisualforceException e) {
                pdf1 = Blob.valueOf('Exception');
            }    
            
          List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

          List<String> sendTo = new List<String>();
          sendTo.add(UserInfo.getUserEmail());
          mail.setToAddresses(sendTo);        
          mail.setSenderDisplayName('Sport New Zealand');   
          mail.setSubject('Investment Schedule Agreement Report - '+objIS.name);
          mail.setHtmlBody('Here is the Investment Schedule Agreement Report you requested: '+objIS.name);
          Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();            
          efa.setFileName(objIS.name+'.pdf');           
          efa.setBody(pdf1);           
          mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa}); 
          Messaging.SingleEmailMessage[] messages =  new List<Messaging.SingleEmailMessage> {mail};
          Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            if (results[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: '
                      + results[0].errors[0].message);
            }
          RunOnce.firstRun=false;           
                    
        } 
        return null;        
    }
}