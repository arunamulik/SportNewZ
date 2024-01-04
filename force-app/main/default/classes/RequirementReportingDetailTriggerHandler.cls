public class RequirementReportingDetailTriggerHandler {

    public static void updateRRDStatus(List<Requirement_Reporting_Detail__c> rrdList)
    {
        
        Set<id> reqId =new Set<Id>();
        Map<Id,Requirement__c> reqlist = new Map<Id,Requirement__c>();
        List<Requirement__c> newreq=new List<Requirement__c>(); 
        for(Requirement_Reporting_Detail__c rrd : rrdList)
        {
            if(rrd.Requirement__c != null)
            {
                reqId.add(rrd.Requirement__c);
            }
        }
        
		reqlist = new Map<Id,Requirement__c>([select Id,RRD_Status__c from Requirement__c where Id IN: reqId]);
        Map<Id,Requirement__c> reqMapToUpdate = new Map<Id,Requirement__c>();
        for(Requirement_Reporting_Detail__c rrd :rrdList)
        {
            Requirement__c myReq = reqlist.get(rrd.Requirement__c);
            myReq.RRD_Status__c = rrd.Status__c;
            reqMapToUpdate.put(rrd.Requirement__c,myReq);
                
        }
        try{
            if(!reqMapToUpdate.isEmpty()){
       			update reqMapToUpdate.values();
            }  
        }
        catch(Exception e){
            cwbtool__ErrorLog__c errlog=new cwbtool__ErrorLog__c();     errlog.cwbtool__LineNumber__c=e.getLineNumber();       errlog.cwbtool__ErrorType__c=e.getTypeName();          errlog.cwbtool__StackTrace__c=e.getStackTraceString();          errlog.cwbtool__Message__c=e.getMessage()+'Method Name : updateRRDStatus';
            insert errlog;
        }
    }
}