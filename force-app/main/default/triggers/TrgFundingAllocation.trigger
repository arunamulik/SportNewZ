trigger TrgFundingAllocation on Funding_Allocation__c (after delete, after insert, after undelete, 
after update) {
    
    /* No Longer Required
    
    if (Trigger.IsInsert || Trigger.IsUpdate || Trigger.IsUndelete){
        FundingAllocationTriggerhandler.updateStrategicArea(Trigger.new);
    }
    
    if(Trigger.isDelete) { 
        FundingAllocationTriggerhandler.updateStrategicArea(Trigger.old);
    } 
    
    */

}