/*------------------------------------------------------------
Author:         Jack Tan
Company:        Davanti Consulting
Description:    Handler of trigger TrgMeasure on Measure__c
Test Class:     TestMeasureTriggerhandler

History
03-08-2017      JTan    Created
24-05-2018      ESPL    Modified as per checkVariationConditionVariation functionality
03-12-2018      ESPL    As per SNIS-94 to update Pending Measure Count
------------------------------------------------------------*/

public class MeasureTriggerhandler {
    
    /**************************************************
    Purpose : Pass set of Initiative__c.Id to method rollupMeasuresOnInitiative
    Params  : List<Measure__c>
    *****************************************************/
    public static void updateInitiative(List<Measure__c> measureList) {
                system.debug('Inside MeasureTriggerhandler updateInitiative() method');

        Set<Id> initiativeIdSet = new Set<Id>();
        
        //RUL for all incomplete measures
        Set<Id> relatedInitiatives = new Set<Id>();
        //RUL for all cancelled measures
        Set<Id> relatedCancelledInitiatives = new Set<Id>();
        //RUL for count of measures linked
        Set<Id> relatedInit = new Set<Id>();
        
        for(Measure__c measure : measureList){
            if(measure.Initiative__c != null && measure.Status__c == 'Pending'){
                initiativeIdSet.add(measure.Initiative__c);
            }
            //Variation related changes
            if(measure.Initiative__c != null && measure.Status__c != 'Met'){
                relatedInitiatives.add(measure.Initiative__c);
            }
            //Variation related changes
            if(measure.Initiative__c != null && measure.Status__c == 'Cancelled'){
                relatedCancelledInitiatives.add(measure.Initiative__c);
            }
            if(measure.Initiative__c != null ){
            	relatedInit.add(measure.Initiative__c);
            }
        }
        if(!relatedInit.isEmpty()){
        	rollupMeasuresOnInitiative(initiativeIdSet,relatedInitiatives,relatedCancelledInitiatives);
        }
        
    }
    
    /**************************************************
    Purpose : Pass set of Initiative__c.Id to method rollupMeasuresOnInitiative
    Params  : Map<Id, Measure__c>, List<Measure__c>
    *****************************************************/
    public static void updateInitiative(Map<Id, Measure__c> oldMap, List<Measure__c> measureList) {
        system.debug('Inside MeasureTriggerhandler updateInitiative() method');

        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
	        Set<Id> initiativeIdSet = new Set<Id>();
	        
	         //RUL for all incomplete measures
	         Set<Id> relatedInitiatives = new Set<Id>();
	         
	         //RUL for all cancelled measures
        	Set<Id> relatedInitiativesMet = new Set<Id>();
	         //RUL for all cancelled measures
        	Set<Id> relatedCancelledInitiatives = new Set<Id>();
	        //RUL for count of measures linked
       		Set<Id> relatedInit = new Set<Id>();
        
	        for(Measure__c measure : measureList) {
	            if((measure.Status__c != oldMap.get(measure.Id).Status__c ||
	               measure.Initiative__c != oldMap.get(measure.Id).Initiative__c) ){
                       //Update by RUL on 03/12/2018 to update Pending Measure count on change of status from Measure to any other
	                   if(measure.Initiative__c != null && (measure.Status__c != 'Pending' || oldMap.get(measure.Id).Status__c == 'Pending'))
	                       initiativeIdSet.add(measure.Initiative__c);
	                   if(oldMap.get(measure.Id).Initiative__c != null && (measure.Status__c == 'Pending' || oldMap.get(measure.Id).Status__c != 'Pending'))
	                       initiativeIdSet.add(oldMap.get(measure.Id).Initiative__c);
	            }
	            if(measure.Initiative__c != null && measure.Status__c != 'Met' ){
	                relatedInitiatives.add(measure.Initiative__c);
	            }
	            if(measure.Initiative__c != null && measure.Status__c == 'Met'){
	                relatedInitiativesMet.add(measure.Initiative__c);
	            }
	            if(measure.Initiative__c != null && measure.Status__c == 'Cancelled'){
                	relatedCancelledInitiatives.add(measure.Initiative__c);
            	}
            	
	        }
	       if(!initiativeIdSet.isEmpty() || !relatedInitiatives.isEmpty() || !relatedCancelledInitiatives.isEmpty()){
				rollupMeasuresOnInitiative(initiativeIdSet,relatedInitiatives,relatedCancelledInitiatives);
	        }
	        if(!relatedInitiativesMet.isEmpty()){
	            AggregateResult[] aggregateResults = [SELECT COUNT(Id) CNT, Initiative__c INIT FROM Measure__c
	                                              WHERE Initiative__c IN :relatedInitiativesMet AND Status__c = 'Met' GROUP BY Initiative__c];
	             List<Initiative__c> initiativeToUpdate = new List<Initiative__c>();
	             for(AggregateResult ar : aggregateResults) {
	                initiativeToUpdate.add(
	                    new Initiative__c(
	                        Id = (Id) ar.get('INIT'),
	                        RUL_Incomplete_Measures__c = 0
	                    )
	                );
	             }
	             if(!initiativeToUpdate.isEmpty()){
	             	if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
	             		update initiativeToUpdate;
	             	}
	             }
	        }
        }
    }

    /**************************************************
    Purpose : Count Pending Measure__c records and update Initiative__c.Pending_Measures__c
    Params  : Set<Id>
    *****************************************************/
    public static void rollupMeasuresOnInitiative(Set<Id> initiativeIdSet, Set<Id> relatedInitiatives, Set<Id> relatedCancelledInitiatives) {
                        system.debug('Inside MeasureTriggerhandler rollupMeasuresOnInitiative() method');

		if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
	        //system.debug('@--MeasureTriggerhandler CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
	
	        List<Initiative__c> initiativeToUpdate = new List<Initiative__c>();
	
	         AggregateResult[] aggregateResults = new List<AggregateResult>();
	        if(!initiativeIdSet.isEmpty()){
	            aggregateResults = [SELECT COUNT(Id) CNT, Initiative__c INIT FROM Measure__c
	                                              WHERE Initiative__c IN :initiativeIdSet AND Status__c = 'Pending' GROUP BY Initiative__c];
	        	system.debug('Aggregate Result of Pending -----------------------'+aggregateResults.size());
	        }
	
	        AggregateResult[] aggregateResults1 = new List<AggregateResult>();
	        if(!relatedInitiatives.isEmpty()){
	            aggregateResults1 = [SELECT COUNT(Id) CNT, Initiative__c INIT FROM Measure__c
	                                              WHERE Initiative__c IN :relatedInitiatives AND Status__c != 'Met' GROUP BY Initiative__c];
	
	            //system.debug('Aggregate Result of not Met -----------------------'+aggregateResults1);
	        }
	        
	        AggregateResult[] aggregateResults2 = new List<AggregateResult>();
	        if(!relatedCancelledInitiatives.isEmpty()){
	            aggregateResults2 = [SELECT COUNT(Id) CNT, Initiative__c INIT FROM Measure__c
	                                              WHERE Initiative__c IN :relatedCancelledInitiatives AND Status__c = 'Cancelled' GROUP BY Initiative__c];
	
	            //system.debug('Aggregate Result of Cancelled -----------------------'+aggregateResults2);
	        }
	        
	        AggregateResult[] aggregateResults3 = new List<AggregateResult>();
	        if(!relatedCancelledInitiatives.isEmpty()){
	            aggregateResults3 = [SELECT COUNT(Id) CNT, Initiative__c INIT FROM Measure__c
	                                              WHERE Initiative__c != null GROUP BY Initiative__c];
	
	            //system.debug('Aggregate Result of Measures -----------------------'+aggregateResults3);
	        }
	
	        Map<Id,Initiative__c> initiativeToUpdateIdAndRecord = new Map<Id,Initiative__c>();
            if(aggregateResults.size() > 0){ //Added by RUL on 03/12/2018 to check the Pending Measure count is greater than o 
                for(AggregateResult ar : aggregateResults) {
	            initiativeToUpdateIdAndRecord.put((Id) ar.get('INIT'),new Initiative__c(
	                    Id = (Id) ar.get('INIT'),
	                    Pending_Measures__c = (Integer) ar.get('CNT')
                ));}
            }
            //Updated by RUL on 03/12/2018 to update the Pending Measure count on Initiative
            else{
                    for(id initid :initiativeIdSet ){
                     initiativeToUpdateIdAndRecord.put(initid,new Initiative__c(
	                    Id = initid,
	                    Pending_Measures__c = 0  ));  
                }
                                                
                }
            
            for(AggregateResult ar : aggregateResults3) {
	            initiativeToUpdateIdAndRecord.put((Id) ar.get('INIT'),new Initiative__c(
	                    Id = (Id) ar.get('INIT'),
	                    RUL_Total_Measures__c = (Integer) ar.get('CNT')
	                ));
	           
	        }
	        
	        for(AggregateResult ar : aggregateResults1) {
	            Id key = (Id) ar.get('INIT');
	            if(initiativeToUpdateIdAndRecord.containsKey(key)){
	                Initiative__c newInitiative = initiativeToUpdateIdAndRecord.get(key);
	                newInitiative.RUL_Incomplete_Measures__c = (Integer) ar.get('CNT');
	                initiativeToUpdateIdAndRecord.put(key,newInitiative);
	            }else{
	                Initiative__c newInitiative = new Initiative__c(
	                    Id = (Id) ar.get('INIT'),
	                    RUL_Incomplete_Measures__c = (Integer) ar.get('CNT')
	                );
	                initiativeToUpdateIdAndRecord.put(key,newInitiative);
	            }
	        }
	        for(AggregateResult ar : aggregateResults2) {
	            Id key = (Id) ar.get('INIT');
	            if(initiativeToUpdateIdAndRecord.containsKey(key)){
	                Initiative__c newInitiative = initiativeToUpdateIdAndRecord.get(key);
	                newInitiative.Total_cancelled_Measures_for_Initiative__c = (Integer) ar.get('CNT');
	                initiativeToUpdateIdAndRecord.put(key,newInitiative);
	            }else{
	                Initiative__c newInitiative = new Initiative__c(
	                    Id = (Id) ar.get('INIT'),
	                    Total_cancelled_Measures_for_Initiative__c = (Integer) ar.get('CNT')
	                );
	                initiativeToUpdateIdAndRecord.put(key,newInitiative);
	            }
	        }
	
	        for(String initiativeIds : initiativeToUpdateIdAndRecord.keySet()){
	            initiativeToUpdate.add(initiativeToUpdateIdAndRecord.get(initiativeIds));
	        }
	       if(!initiativeToUpdate.isEmpty()){
                system.debug('initiativeToUpdate============'+initiativeToUpdate);
	        	if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
	        		update initiativeToUpdate;
                }
	        }
	        
		}
    }
    
    
    //Update checkbox at variation
    public static void updateVariation(Map<Id,Measure__c> newMeasures, Map<Id,Measure__c> oldMeasures){
                                system.debug('Inside MeasureTriggerhandler updateVariation() method');

    	Set<Id> initiative = new Set<Id>();
    	
    	for(String measureId :newMeasures.keySet()){
    		
    		if(((newMeasures.get(measureId).Name != oldMeasures.get(measureId).Name) || 
				(newMeasures.get(measureId).Partner__c != oldMeasures.get(measureId).Partner__c) || 
				(newMeasures.get(measureId).Initiative__c != oldMeasures.get(measureId).Initiative__c) || 
				(newMeasures.get(measureId).Reporting_Type__c != oldMeasures.get(measureId).Reporting_Type__c) || 
				(newMeasures.get(measureId).Baseline_Number__c != oldMeasures.get(measureId).Baseline_Number__c) || 
				(newMeasures.get(measureId).Result_Rich_Text__c != oldMeasures.get(measureId).Result_Rich_Text__c) || 
				(newMeasures.get(measureId).Target_Text__c != oldMeasures.get(measureId).Target_Text__c) || 
				(newMeasures.get(measureId).Target_Currency__c != oldMeasures.get(measureId).Target_Currency__c) || 
				(newMeasures.get(measureId).Baseline_Percent__c != oldMeasures.get(measureId).Baseline_Percent__c) || 
				(newMeasures.get(measureId).Status__c != oldMeasures.get(measureId).Status__c) || 
				(newMeasures.get(measureId).Outcomes__c != oldMeasures.get(measureId).Outcomes__c) || 
				(newMeasures.get(measureId).Description__c != oldMeasures.get(measureId).Description__c) || 
				(newMeasures.get(measureId).Instructions__c != oldMeasures.get(measureId).Instructions__c) || 
				(newMeasures.get(measureId).Baseline_Date__c != oldMeasures.get(measureId).Baseline_Date__c) || 
				(newMeasures.get(measureId).Target_Date__c != oldMeasures.get(measureId).Target_Date__c) || 
				(newMeasures.get(measureId).Result_Date__c != oldMeasures.get(measureId).Result_Date__c) || 
				(newMeasures.get(measureId).Baseline_Currency__c != oldMeasures.get(measureId).Baseline_Currency__c) || 
				(newMeasures.get(measureId).Result_Currency__c != oldMeasures.get(measureId).Result_Currency__c) || 
				(newMeasures.get(measureId).Baseline_Text__c != oldMeasures.get(measureId).Baseline_Text__c) || 
				(newMeasures.get(measureId).Target_Text__c != oldMeasures.get(measureId).Target_Text__c))){
				//system.debug('Measure changed --------------------');
				if(String.isNotBlank(newMeasures.get(measureId).Initiative__c)){
	    			initiative.add(newMeasures.get(measureId).Initiative__c);
	    		}
			}
    	}
    	system.debug('Changed Measures ------------------'+initiative);
    	
    	if(!initiative.isEmpty()){
    		List<Initiative__c> relatedInitiatives = [SELECT Id, 
    														 Investment_Schedule_Variation__c, 
    														 Investment_Schedule_Variation__r.Is_Active__c
    												  FROM   Initiative__c 
    												  WHERE  Id IN: initiative
    												 ];
    		system.debug('Related Initiatives ------------------'+relatedInitiatives);
            Map<ID,Initiative__c> mapInitiative = new Map<ID,Initiative__c>();
            mapInitiative.putall(mapInitiative);
    		if(mapInitiative.size()>0){
    			List<Variation__c> updateVariation = new List<Variation__c>();
    			for(Initiative__c objInitiative: mapInitiative.values()){
    				if(String.isNotBlank(objInitiative.Investment_Schedule_Variation__c)){
	    				if(objInitiative.Investment_Schedule_Variation__r.Is_Active__c){
	    					//update payment varied
	    					updateVariation.add(new Variation__c(
	    						Id = objInitiative.Investment_Schedule_Variation__c,
	    						Measures_Varied__c = true
	    					));
	    				}
    				}
    			}
    			system.debug('Variations to update -------------------'+updateVariation);
    			if(!updateVariation.isEmpty()){
    				update updateVariation;
    			}
    		}
    		
    	}
    }
    public static void updateOldRecordType(List<Measure__c> listMeasure){
       system.debug('Inside MeasureTriggerhandler updateOldRecordType() method');

        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            //To have number of SOQL queries executed so far
            Set<String>setRecordTypes = new Set<String>{'RUL_Currency_Read_Only','RUL_Number_Read_Only','RUL_Percent_Read_Only','RUL_Text_Read_Only'};
            for(Measure__c objMeasure : listMeasure){
                //system.debug('objMeasure.RecordType.DeveloperName'+objMeasure.RecordType.DeveloperName);
                if(objMeasure.RecordTypeId != fetchRecordTypeId('RUL_Currency_Read_Only') 
                   && objMeasure.RecordTypeId != fetchRecordTypeId('RUL_Number_Read_Only')
                   && objMeasure.RecordTypeId != fetchRecordTypeId('RUL_Percent_Read_Only')
                   && objMeasure.RecordTypeId != fetchRecordTypeId('RUL_Text_Read_Only')){
                       objMeasure.RUL_Old_RecordType_Id__c = objMeasure.RecordTypeID;
                  }
                  if(!objMeasure.Status__c.containsIgnoreCase('Variation')){
                    objMeasure.Old_Status__c = objMeasure.Status__c;
                }
             }
        }
    }
     public static String fetchRecordTypeId (String recordTypeName) {
        system.debug('Inside MeasureTriggerhandler fetchRecordTypeId() method');

        String recordTypeId =  Schema.SObjectType.Measure__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();        
        return recordTypeId;
    }
}