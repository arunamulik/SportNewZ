trigger TrgRequirementReportingDetail on Requirement_Reporting_Detail__c (before insert,before update) {
    
    if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
        
        Boolean isVariationInitiatied = RecursionHandler.TrgVariationBypass;
        
        if(RecursionHandler.getRunTimes() < 16 && !isVariationInitiatied){
            
            if(Trigger.isBefore) {
                if(Trigger.isInsert || Trigger.isUpdate)
                {
                    RequirementReportingDetailTriggerHandler.updateRRDStatus(Trigger.new);
                }
                
            }
        }
    }
}