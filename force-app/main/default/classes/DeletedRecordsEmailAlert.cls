global class DeletedRecordsEmailAlert implements Schedulable {
   global void execute(SchedulableContext SC) {
     Datetime d = datetime.now().addhours(-24);
	 List<Subscriber__c> deletedrecords = [SELECT Id FROM Subscriber__c WHERE LastModifiedDate > :d AND IsDeleted =true ALL ROWS];
     System.debug('Subscribers ' + deletedrecords);
     System.debug('List count'+ deletedrecords.size());
       if(deletedrecords.size()>=20){
        Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
        semail.setTargetObjectId(UserInfo.getUserId()); 
        semail.setSubject('Alert: Deleted records issue');
        String[] sendingTo = new String[]{'aruna.mulik@infobeans.com', 'prajwal.ganeshe@infobeans.com','publications@sportnz.org.nz'};
        semail.setToAddresses(sendingTo);
        EmailTemplate templateId = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'DeleteRecordAlert'];
        String txtBody = templateId.Body;
        semail.setPlainTextBody(txtBody);
        semail.setSaveAsActivity(false);
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {semail};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
       }
       
 }
}