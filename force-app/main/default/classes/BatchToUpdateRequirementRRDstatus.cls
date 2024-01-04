global class BatchToUpdateRequirementRRDstatus implements Database.Batchable<sObject> {
    String query='select Id,Status__c,RRD_Status__c from Requirement__c';
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<Requirement__c> records){
        // process each batch of records
        List<Requirement_Reporting_Detail__c> rrdlist =[select Id,Requirement__c,Status__c from Requirement_Reporting_Detail__c where Requirement__c IN : records];
            Map<Id,String> reqvsrrdMap= New Map<Id,String>();
            for(Requirement_Reporting_Detail__c rrd:rrdlist)
            {
                reqvsrrdMap.put(rrd.Requirement__c,rrd.Status__c);
            }
            for(Requirement__c req : records){
            	if(!reqvsrrdMap.containsKey(req.Id))
                {
                    req.RRD_Status__c=req.Status__c;
                }
                else
                {
                    req.RRD_Status__c=reqvsrrdMap.get(req.Id);
                }
            }
        update records;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}