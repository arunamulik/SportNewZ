/*
* @ Author :- Navneet Rajput
* @ Company :- Davanty 
* @ Date :- 12/06/2015
* @ Description :- 
**/

trigger StrategicAreaOwnerChangeTrigger on Strategic_Area__c (after update) {
	
    //Checking if variation has been initiated 
     //IsVariationInititated__c IsVariation = IsVariationInititated__c.getInstance(UserInfo.getProfileId());
     Boolean isVariationInitiatied = RecursionHandler.TrgVariationBypass ;
    Set<Id> strategicAreaIdSet = new Set<Id>();
    for(Strategic_Area__c strategicAreaRecord : Trigger.new){
        if(strategicAreaRecord.OwnerId != Trigger.oldMap.get(strategicAreaRecord.Id).OwnerId){ strategicAreaIdSet.add(strategicAreaRecord.Id);
        }
    }
    
	Set<Id> sAreaIds = new Set<Id>();
    List<Business_Case__c> lstOfbCase = new List<Business_Case__c>();
    Map<Id,List<Business_Case__c>> strategyToBCaseMap = new Map<Id,List<Business_Case__c>>();
    
    Map<Id,Business_Case__c> mapOfBusinessCase = new Map<Id,Business_Case__c>([SELECT Id,Strategic_Area_Owner__c,Strategic_Area__c 
        												   					   FROM Business_Case__c 
        												  					   WHERE Strategic_Area__c IN : strategicAreaIdSet]);
    
    system.debug('mapOfBusinessCase>>>>>>>>>> '+mapOfBusinessCase);
    system.debug('Trigger.newMap.keySet() >>>>>>>>>>>>>>> '+Trigger.newMap.keySet()); 
    
    if (mapOfBusinessCase<>NULL && !mapOfBusinessCase.isEmpty()){for (Business_Case__c bCaseVal : mapOfBusinessCase.values()){if (strategyToBCaseMap<>NULL && !strategyToBCaseMap.containsKey(bCaseVal.Strategic_Area__c)){strategyToBCaseMap.put(bCaseVal.Strategic_Area__c,new List<Business_Case__c>());}strategyToBCaseMap.get(bCaseVal.Strategic_Area__c).add(bCaseVal);
    	}
    }
    system.debug('strategyToBCaseMap>>>>>>>>>>>>>> '+strategyToBCaseMap);
        												  					   
    if (Trigger.isUpdate){
        for (Strategic_Area__c sArea : Trigger.New){
             //if ((Trigger.isUpdate && Trigger.newMap.get(sArea.Id).ownerId<>Trigger.oldMap.get(sArea.Id).ownerId)){
	             if (strategyToBCaseMap.containsKey(sArea.Id)){for (Business_Case__c bCase : strategyToBCaseMap.get(sArea.Id)){if (bCase.Strategic_Area__c<>NULL){bCase.Strategic_Area_Owner__c = sArea.ownerId;lstOfbCase.add(bCase);
	              		} 
	              	}
	             }
             //}   
        }
        system.debug('lstOfbCase >>>>>>>>>>> '+lstOfbCase);
        //update business case only if variation process is not initiated
        if (lstOfbCase<>NULL && !lstOfbCase.isEmpty() && !isVariationInitiatied){
            
            update lstOfbCase;
        }
    }
}