global class BatchApexForPaymentFromFlow implements Database.Batchable<sObject>, Database.Stateful {

    public Date payDate;
    public integer count = 0;
  
    public BatchApexForPaymentFromFlow(List<Date> datelist)

    {
		Date dT=datelist.get(0);
        Date dateFromDateTime = Date.newInstance(dT.year(), dT.month(), dT.day());
        system.debug('dateFromDateTime : '+dateFromDateTime);
        //this.payDate= datelist.get(0);
        this.payDate = dateFromDateTime;

    }

    public class FlowInputs {

        @InvocableVariable public List<Date> pDate;

    }

    @invocablemethod(label='Get Payment records to change status')

    public static void getPaymentRecords(List<FlowInputs> reqDate)

    {

        system.debug('Date List : '+reqDate);
        List<date> conlist = new List<date>();

        for(FlowInputs req : reqDate)   

        {

            conlist.addAll(req.pDate);

        }

        Id jobId = Database.executeBatch(new BatchApexForPaymentFromFlow(conlist));

    }

   
   global Database.QueryLocator start(Database.BatchableContext BC){

      String query = 'SELECT Id, Old_Status__c,Status__c,Initiative__r.Status__c,RUL_Old_RecordType_Id__c,Date__c,'  
          			 +'Initiative__r.Business_Case__r.Status__c,Initiative__r.Business_Case__r.Id,Initiative__r.Business_Case__r.Name'
                     +' from Payment__c'
                     +' where Date__c = :payDate'
				     +' and (Initiative__r.Business_Case__r.Status__c=\'Approved\' or Initiative__r.Business_Case__r.Status__c=\'Signed\' )'
                     +' and (Initiative__r.Status__c =\'Approved\' or Initiative__r.Status__c =\'Scheduled\')'
                     +' and Status__c =\'Variation\' and Overdue_Requirements__c = '+False+'  and Pending_Requirements__c = '+False;

      return Database.getQueryLocator(query);

   }

    global void execute(Database.BatchableContext BC , List<Payment__c> scope){
    	system.debug('Scope is : '+scope);
        system.debug('Size of list : '+scope.size());
       // integer count = 0;
        if(scope != null && !scope.isEmpty()) {
            for(Payment__c p : scope) {
                p.status__c = 'Scheduled';
            }
            try{

                Database.SaveResult[] ds =  Database.update(scope,false);
                
                for(Database.SaveResult d : ds){
                    system.debug('@@in for loop');
                    if(d.isSuccess()){
                        system.debug('@@in if in for');
                        count++;
                        
                    }
                    system.debug('count in for = '+count);
                    
                }
                system.debug('count : '+count);
                             
            }
            
            catch(exception e){
                
                system.debug('update failed');
           }
        }
    }

   global void finish(Database.BatchableContext BC){
        
       system.debug('Actual count in finish: '+count);
      // ReturnPaymentProcessedToFlow rpf=new ReturnPaymentProcessedToFlow();
       //List<String> result = ReturnPaymentProcessedToFlow.sendMsg(msg); // Correct
       //return result;
        CustomNotificationType statusChangeNotification = [SELECT Id, 
                                                        DeveloperName  
                                                        FROM CustomNotificationType  
                                                        WHERE DeveloperName='PaymentStatusChangeNotification' 
                                                        LIMIT 1]; 
       
                String body = 'Status of  ' +count +' payment records is changed from Variation to Scheduled.'; 
                Messaging.CustomNotification Notification = new Messaging.CustomNotification(); 
                Notification.setNotificationTypeId(statusChangeNotification.id); 
                Notification.setSenderId(Userinfo.getUserId()); 
                Notification.setBody(body); 
                Notification.setTitle('Payment status changed to scheduled'); 
                Notification.setTargetId('a0G6F00002ovTIJUA2'); 
                Notification.send(new Set<String> {Userinfo.getUserId()}); 
              
   }

}