public with sharing class FundingAllocationTriggerHandler {

/* No Longer Required

    public static void updateStrategicArea(List<Funding_Allocation__c> triggerFundingAllocationList) {
        
        Set<Id> strategicAreaIdSet = new Set<Id>();
        List<Strategic_Area__c> updateStrategicAreaList = new List<Strategic_Area__c>();
        Map<Id,Decimal> strategicAreaBudgetMap = new Map<Id,Decimal>();
        
        for(Funding_Allocation__c f :triggerFun* NdingAllocationList){         
            strategicAreaIdSet.add(f.Strategic_Area__c);            
        }
        
        if(!strategicAreaIdSet.isEmpty()){                      
            List<Funding_Allocation__c> allFundingAllocationList = [SELECT Funding_Amount__c, Strategic_Area__c FROM Funding_Allocation__c WHERE Strategic_Area__c IN: strategicAreaIdSet AND Status__c = 'Approved'];
            for(Funding_Allocation__c fa: allFundingAllocationList){
                Decimal budget = strategicAreaBudgetMap.get(fa.Strategic_Area__c);  
                if(budget != null){
                    budget += fa.Funding_Amount__c; 
                    strategicAreaBudgetMap.put(fa.Strategic_Area__c,budget);                    
                }
                else{
                    strategicAreaBudgetMap.put(fa.Strategic_Area__c,fa.Funding_Amount__c);              
                }
            }
        }
        
        for(Id sa :strategicAreaIdSet){         
            Strategic_Area__c s = new Strategic_Area__c(Id=sa);
            Decimal updatedBudget = strategicAreaBudgetMap.get(sa);
            if(updatedBudget == null || updatedBudget == 0)
                s.budget__c = 0;
            else
                s.budget__c = updatedBudget;
            updateStrategicAreaList.add(s);
        }
            
        if(!updateStrategicAreaList.isEmpty())
            update updateStrategicAreaList;     
    }
    
    */
}