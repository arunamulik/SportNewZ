@IsTest
public class TestDeletedRecordsEmailAlert {
    @IsTest
    static void testBatchApexSendingEmail() {
       String CRON_EXP = '0 0 0 15 3 ? *';
		List<Subscriber__c> sublist=new List<Subscriber__c>();
        for(Integer i=0;i<10;i++){
            Subscriber__C sub=new Subscriber__C();
            sub.First_Name__c='test'+i;
            sublist.add(sub);
        }
        insert sublist;
        
       Test.startTest();
        List<Subscriber__c> slist=[Select id,First_Name__c from Subscriber__c where id IN :sublist limit 10];
        delete slist;
        
        String jobId = System.schedule('ScheduleApexClassTest',  CRON_EXP, new DeletedRecordsEmailAlert());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);

       //Datetime d = datetime.now().addhours(-24);
	   //List<Subscriber__c> deletedrecords = [SELECT Id FROM Subscriber__c WHERE LastModifiedDate > :d AND IsDeleted =true ALL ROWS];
     	
        // Instantiate the batch class
       //DeletedRecordsEmailAlert drec=new DeletedRecordsEmailAlert();
	   //drec.execute(null);
        // Wait for batch job to complete
        Test.stopTest();
	}
	@IsTest
    static void testBatchApexSendingEmail1() {
       String CRON_EXP = '0 0 0 15 3 ? *';
		List<Subscriber__c> sublist=new List<Subscriber__c>();
        for(Integer i=0;i<30;i++){
            Subscriber__C sub=new Subscriber__C();
            sub.First_Name__c='test'+i;
            sublist.add(sub);
        }
        insert sublist;
        
       Test.startTest();
        List<Subscriber__c> slist=[Select id,First_Name__c from Subscriber__c where id IN :sublist limit 30];
        delete slist;
        
        String jobId = System.schedule('ScheduleApexClassTest',  CRON_EXP, new DeletedRecordsEmailAlert());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);

       //Datetime d = datetime.now().addhours(-24);
	   //List<Subscriber__c> deletedrecords = [SELECT Id FROM Subscriber__c WHERE LastModifiedDate > :d AND IsDeleted =true ALL ROWS];
     	
        // Instantiate the batch class
       //DeletedRecordsEmailAlert drec=new DeletedRecordsEmailAlert();
	   //drec.execute(null);
        // Wait for batch job to complete
        Test.stopTest();
	}
}