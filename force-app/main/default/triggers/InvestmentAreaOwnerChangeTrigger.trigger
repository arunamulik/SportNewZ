/*
* @ Author :- Navneet Rajput
* @ Company :- Davanty 
* @ Date :- 23/06/2015
* @ Description :- 
**/
trigger InvestmentAreaOwnerChangeTrigger on Investment_Area__c (after update) {

	//Set<Id> sAreaIds = new Set<Id>();
    List<Business_Case__c> lstOfbCase = new List<Business_Case__c>();
    Map<Id,List<Business_Case__c>> investmentToBcaseMap = new Map<Id,List<Business_Case__c>>();
    Set<Id> investmentAreaIdSet = new Set<Id>();
    for(Investment_Area__c investmentAreaRecord : Trigger.new){
        if(investmentAreaRecord.Investment_Area_Owner__c != null && investmentAreaRecord.Investment_Area_Owner__c != Trigger.oldMap.get(investmentAreaRecord.Id).Investment_Area_Owner__c){
            investmentAreaIdSet.add(investmentAreaRecord.Id);
        }
    }
    
    Map<Id,Business_Case__c> mapOfBusinessCase = new Map<Id,Business_Case__c>([SELECT Id,Investment_Area_Owner__c,Investment_Area__c
        												   					   FROM Business_Case__c 
        												  					   WHERE Investment_Area__c IN : investmentAreaIdSet]);
    
    system.debug('mapOfBusinessCase>>>>>>>>>> '+mapOfBusinessCase);
    system.debug('Trigger.newMap.keySet() >>>>>>>>>>>>>>> '+Trigger.newMap.keySet());    												  					   
    if (mapOfBusinessCase<>NULL && !mapOfBusinessCase.isEmpty()){
    	for (Business_Case__c bCaseVal : mapOfBusinessCase.values()){
    		if (investmentToBcaseMap<>NULL && !investmentToBcaseMap.containsKey(bCaseVal.Investment_Area__c)){
    			investmentToBcaseMap.put(bCaseVal.Investment_Area__c,new List<Business_Case__c>());
    		}
    		investmentToBcaseMap.get(bCaseVal.Investment_Area__c).add(bCaseVal);
    	}
    }
    system.debug('investmentToBcaseMap>>>>>>>>>>>>>> '+investmentToBcaseMap);
        												  					   
    if (Trigger.isUpdate){
        for (Investment_Area__c iArea : Trigger.New){
	         if (investmentToBcaseMap.containsKey(iArea.Id)){
	         	system.debug('Key found >>>>>>>>>>>>');
	          	for (Business_Case__c bCase : investmentToBcaseMap.get(iArea.Id)){
	          		if (bCase.Investment_Area__c<>NULL){
	          			bCase.Investment_Area_Owner__c = iArea.Investment_Area_Owner__c;
	          			lstOfbCase.add(bCase);
	          		}
	          	}
	         }
        }
        system.debug('lstOfbCase >>>>>>>>>>> '+lstOfbCase);
        
        if (lstOfbCase<>NULL && !lstOfbCase.isEmpty()){
            update lstOfbCase;
        }
    }

}