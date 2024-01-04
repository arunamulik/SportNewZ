/*
* @ Author :- Navneet Rajput
* @ Date :- 13/6/2015
* @ Description :- 
* @ Change History :-  
*/
trigger updateInvestmentAreaTrigger on Payment__c (after insert, after update) {
    static Integer cnt = 0;
    if (!updateInvestmentAreaTriggerHandler.isExecuted){
        system.debug('inside updateInvestmentAreaTrigger >>>>>>> ');
        Map<Id,Investment_Area_Allocation__c> mapOfInvAllocation;
        Map<Id,List<Investment_Area_Allocation__c>> mapOfInvAreaAndInvAllocation = new Map<Id,List<Investment_Area_Allocation__c>>();
        List<Payment__c> paymentLst = new List<Payment__c>();
        Map<Id,Payment__c> mapOfInvestmetAreaAndPayment = new Map<Id,Payment__c>();
        
        Map<Id,Payment__c> mapOfPayment = new Map<Id,Payment__c>([SELECT Id, Initiative__r.Investment_Area__c,Initiative__c,
                                                                         Date__c,Investment_Area_Allocation__c,Financial_Year__c,
                                                                  		 Reporting_Year__c
                                                                   FROM Payment__c
                                                                   WHERE Id IN : Trigger.newMap.keySet()]);
        system.debug('mapOfPayment >>>>>>>>>>>>>>>>'+mapOfPayment);                                                        
        if (mapOfPayment<>NULL){    
            for (Payment__c payment : mapOfPayment.values()){
                system.debug('payment.Initiative__r.Investment_Area__c>>>>>>> '+payment.Initiative__r.Investment_Area__c);
                if (payment.Initiative__c<>NULL && payment.Initiative__r.Investment_Area__c<>NULL){
                    mapOfInvestmetAreaAndPayment.put(payment.Initiative__r.Investment_Area__c,payment);
                }
            }   
        }                                                      
        system.debug('mapOfInvestmetAreaAndPayment >>>>>>>>>>>>>>>>>>>>>>>> '+mapOfInvestmetAreaAndPayment);                                                           
      if (mapOfInvestmetAreaAndPayment<>NULL){  
            mapOfInvAllocation = new Map<Id,Investment_Area_Allocation__c>([SELECT Id,Funding_Allocation_End_Date__c,Investment_Area__c,
                                                                                   Funding_Allocation_Start_Date__c,Financial_Year__c                                                                            	   
                                                                            FROM   Investment_Area_Allocation__c
                                                                            WHERE  Funding_Allocation__r.Status__c != 'Closed' AND Investment_Area__c IN :mapOfInvestmetAreaAndPayment.keySet()]);
                                                                            
            system.debug('mapOfInvAllocation>>>>>>>>>>>>>>>values >>>>>>>>>  '+mapOfInvAllocation.values());
            system.debug('mapOfInvAllocation>>>>>>>>>>>>>>> Keys >>>>>>>>>>> '+mapOfInvAllocation.keySet());                                                                
                                                                            
            if (mapOfInvAllocation<>NULL){
                
                for (Investment_Area_Allocation__c Inv : mapOfInvAllocation.values()){
                    if (!mapOfInvAreaAndInvAllocation.containsKey(Inv.Investment_Area__c)){
                        mapOfInvAreaAndInvAllocation.put(Inv.Investment_Area__c,new List<Investment_Area_Allocation__c>());
                    }
                    mapOfInvAreaAndInvAllocation.get(Inv.Investment_Area__c).add(Inv);
                }
                system.debug('mapOfInvAreaAndInvAllocation check Inv Ares >>>>>>>>>>>>>>>> '+mapOfInvAreaAndInvAllocation);
            }                                                                       
                                                                                                                
      }
      system.debug('mapOfInvAreaAndInvAllocation>>>>>>>>>>>>>> '+mapOfInvAreaAndInvAllocation);
      if (mapOfInvAreaAndInvAllocation<>NULL){
         for (Payment__c payment : Trigger.new){
            
             if (Trigger.isInsert ||(Trigger.isUpdate && Trigger.newMap.get(payment.Id).Date__c <> Trigger.oldMap.get(payment.Id).Date__c)){
                cnt = 0;
                Payment__c p = mapOfPayment.get(payment.Id);
                system.debug('p.Initiative__r.Investment_Area__c>>>>>>>>>>>>> '+p.Initiative__r.Investment_Area__c);
                if (mapOfInvAreaAndInvAllocation.containsKey(mapOfPayment.get(p.Id).Initiative__r.Investment_Area__c)){
                    // 1 investment area can have multiple investment area allocation
                    for (Investment_Area_Allocation__c iAllocation : mapOfInvAreaAndInvAllocation.get(mapOfPayment.get(p.Id).Initiative__r.Investment_Area__c)){
                        boolean isTrue = false;
                        if (iAllocation.Funding_Allocation_Start_Date__c<>NULL && iAllocation.Funding_Allocation_End_Date__c<>NULL){
                         isTrue = updateInvestmentAreaTriggerHandler.isDateMatched(p.Date__c,
                                                                                  iAllocation.Funding_Allocation_Start_Date__c,
                                                                                  iAllocation.Funding_Allocation_End_Date__c);
                        }                                    
                        system.debug('isTrue in trigger >>>>>>>>'+isTrue);                  
                        if (isTrue){
                            cnt++;
                            if (cnt==1){
                                p.Investment_Area_Allocation__c = iAllocation.Id;
                                p.Financial_Year__c = iAllocation.Financial_Year__c;
                                p.Reporting_Year__c = iAllocation.Financial_Year__c;
                                paymentLst.add(p);
                            }
                        }   
                    }
                }
                if (cnt>1){
                    payment.addError('This Payment cannot be created, as there are more than one valid Investment Area Allocation available for this FY');
                }else if (cnt == 0){
                    payment.addError('This Payment cannot be created, as there is no funding allocated to this Investment Area for this FY');
                }
             }    
         }
      }
      system.debug('Before Update ######## '+paymentLst);
      if (paymentLst<>NULL){
        updateInvestmentAreaTriggerHandler.addPaymentToInvArea(paymentLst);
      } 
  } 

}