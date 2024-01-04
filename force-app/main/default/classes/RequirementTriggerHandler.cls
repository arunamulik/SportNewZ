public with sharing class RequirementTriggerHandler {

    public static void updatePlan(List<Requirement__c> initList){
                 system.debug('Inside RequirementTriggerHandler updatePlan() method');

        Set<Id> InitiativeIdSet = new Set<Id>();
        for(Requirement__c req: initList){
            InitiativeIdSet.add(req.Initiative__c);
        }
        id reqRecordtypeId = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Map<Id, Initiative__c> initiativeMap = new Map<Id, Initiative__c>([Select Id, Plan__c, Partner__c from Initiative__c where id in: InitiativeIdSet]);
        for(Requirement__c init: initList){
           if (init.RecordTypeId == reqRecordtypeId && init.Initiative__c != null){             
                init.Plan__c = (initiativeMap.get(init.Initiative__c).Plan__c  != null) ? initiativeMap.get(init.Initiative__c).Plan__c : (init.Plan__c != null) ? init.Plan__c: null  ;
                init.Partner__c = (initiativeMap.get(init.Initiative__c).Partner__c != null) ? initiativeMap.get(init.Initiative__c).Partner__c : (init.Partner__c != null) ? init.Partner__c: null  ;
           }
        }
    }
	
    //added by Prajwal for SSE-129 on 14/3/2022
    public static void updateStatus(List<Requirement__c> requirementList,Map<Id,Requirement__c> oldMap)
    {
                         system.debug('Inside RequirementTriggerHandler updateStatus() method');

        if(oldMap==null)
        {
            for(Requirement__c req : requirementList){
            	req.RRD_Status__c=req.Status__c;
        	}
        }
        else
        {
            List<Requirement_Reporting_Detail__c> rrdlist =[select Id,Requirement__c from Requirement_Reporting_Detail__c where Requirement__c IN : oldMap.keySet()];
            Map<Id,Id> reqvsrrdMap= New Map<Id,Id>();
            for(Requirement_Reporting_Detail__c rrd:rrdlist)
            {
                reqvsrrdMap.put(rrd.Requirement__c,rrd.Id);
            }
            for(Requirement__c req : requirementList){
            	if(req.Status__c!=oldMap.get(req.Id).Status__c && !reqvsrrdMap.containsKey(req.Id))
                {
                    req.RRD_Status__c=req.Status__c;
                }
                	
        	}
        }
    }
    
    public static void processRequirements(List<Requirement__c> requirementList) {
                         system.debug('Inside RequirementTriggerHandler processRequirements() method');

        Set<Id> InitiativeSet = new Set<Id>();// Updated by RUL 15/11/2018
        for(Requirement__c req : requirementList){
            InitiativeSet.add(req.Initiative__c);
        }

        checkRequirements(InitiativeSet);
                        
    }
    public static void updatedRequirements(Map<Id, Requirement__c> oldMap, List<Requirement__c> requirementList) {   
                                 system.debug('Inside RequirementTriggerHandler updatedRequirements() method');

        //Updated by RUL 15/11/2018 as per SNIS-58
        //Set<Id> partnerIdSet = new Set<Id>();
        Set<Id> InitiativeIDSet = new Set<Id>();
        System.debug('In Update Requirements **********');
        for(Requirement__c req : requirementList) {
            if(req.Due_Date__c != oldMap.get(req.Id).Due_Date__c ||
               req.Initiative__c != oldMap.get(req.Id).Initiative__c ||
               req.Status__c != oldMap.get(req.Id).Status__c ||
               req.Hold_Payments__c != oldMap.get(req.Id).Hold_Payments__c ||
               req.Partner__c != oldMap.get(req.Id).Partner__c      
                ) {

                //if initiative was change add the old Initiative to update any payments related to old Initiative
                if(req.Initiative__c != oldMap.get(req.Id).Initiative__c) 
                    InitiativeIDSet.add(oldMap.get(req.Id).Initiative__c);//Updated by RUL 15/11/2018
                //default    
                InitiativeIDSet.add(req.Initiative__c);
            }
        }
        System.debug('Above Call***');
        checkRequirements(InitiativeIDSet);
    }

    public static void checkRequirements(Set<Id> InitiativeIDSet) {
        system.debug('Inside RequirementTriggerHandler checkRequirements() method');

    	/*
    	// Kahiwi Fixes - commented out code related to 'Organisation Requirement' record type
        Id orgRecordTypeId = Schema.SObjectType.Requirement__c.getRecordTypeInfosByName().get('Organisation Requirement').getRecordTypeId();
        */
        System.debug('In checkrequ***');
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
	        Id initRecorTypeId = Schema.SObjectType.Requirement__c.getRecordTypeInfosByName().get('Initiative Requirement').getRecordTypeId();
	        //Added by RUL on 20/03/2019 for read only record type as per PORT-144
            Id readOnlyRecorTypeId = Schema.SObjectType.Requirement__c.getRecordTypeInfosByName().get('Initiative Requirement Read Only').getRecordTypeId();
            List<Payment__c> updatePaymentList = new List<Payment__c>();        
	        Boolean pendingRequirements;
	        Boolean overdueRequirements;
            Boolean sendforpayment;
            
            //Updated by RUL 15/11/2018
	        List<Initiative__c> initiativeList = [Select Id, 
	                                (Select Id, Status__c, Date__c, Initiative__r.Investment_Area__c, Pending_Requirements__c, Overdue_Requirements__c from Payments__r where (Status__c != 'Paid' or Status__c != 'Processed' or Status__c != 'Cancelled')),
	                                (Select Id, Hold_Payments__c, RecordTypeId, Due_Date__c, Initiative__r.Investment_Area__c, Status__c FROM Requirements__r WHERE (Status__c = 'Pending' or Status__c = 'Overdue')) 
	                                From Initiative__c where Id in : InitiativeIDSet];
            System.debug('Initiative list*****'+initiativeList);
	        if(initiativeList.size() > 0) {
	            List<Payment__c> payList = initiativeList.get(0).Payments__r;
	            List<Requirement__c> reqList = initiativeList.get(0).Requirements__r;
	            if(payList.size() > 0) {
	                for(Payment__c p: payList){ // all payments related to accounts
	                    //todo check status of payment
	                    System.debug('Paylist****: '+payList);
                        System.debug('Reqlist****: '+reqList);
	                    if(p.Status__c != 'Paid' || p.Status__c != 'Processed' || p.Status__c != 'Cancelled') {
                            System.debug('In first coditions***');
	                        pendingRequirements = false;
	                        overdueRequirements = false;
                            sendforpayment = false;
	                        //!! todo lessen cpu limit-  
	                        
	                        
                            /*for(Requirement__c req : reqList){
	                            	//req due date is less than payment date
	                            	//before changes of SSE-75
	                            	System.debug('IN Record type **** :'+pendingRequirements);
	                                if((p.Overdue_Requirements__c == false && p.Pending_Requirements__c== false) || (p.Pending_Requirements__c== true && req.Due_Date__c > p.Date__c)) {
	                                //if(req.Hold_Payments__c == true && req.Status__c == 'Pending' ) {
	                                   System.debug('IN Conditions **** :'+pendingRequirements);
                                        sendforpayment = true;  
                                        System.debug('IN Record type After**** :'+pendingRequirements);
	                                    break; //stops loops as soon as condition is met
	                                }
	                            
	                        }*/
	                                                        
	                                                                                        
	                        for(Requirement__c req : reqList){
	                            //(org req || init rec && initiative investment area)
	                            
	                            //if((req.RecordTypeId == orgrecordtypeid || (req.RecordTypeId == initrecortypeid && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c))){
	                            //updated by RUL on 20/03/2019 to add read only record type check
                                if((req.RecordTypeId == initrecortypeid || req.RecordTypeId == readOnlyRecorTypeId) && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c){
	                            	//req due date is less than payment date
	                            	//before changes of SSE-75
	                            	System.debug('IN Record type **** :'+pendingRequirements);
	                                if(req.Hold_Payments__c == true && (req.Status__c == 'Pending' && req.Due_Date__c < p.Date__c)) {
	                                //if(req.Hold_Payments__c == true && req.Status__c == 'Pending' ) {
	                                   System.debug('IN Conditions **** :'+pendingRequirements);
                                        pendingRequirements = true;  
                                        System.debug('IN Record type After**** :'+pendingRequirements);
	                                    break; //stops loops as soon as condition is met
	                                }
	                            }
	                        }
	                        for(Requirement__c req : reqList){
	                            //(org req || init rec && initiative investment area)
	                            //if(req.Hold_Payments__c == true && (req.RecordTypeId == orgrecordtypeid || (req.RecordTypeId == initrecortypeid && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c))){
	                            //updated by RUL on 20/03/2019 to add read only record type check
                                if(req.Hold_Payments__c == true && ((req.RecordTypeId == initrecortypeid ||req.RecordTypeId == readOnlyRecorTypeId) && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c)){
	                            	if(req.Status__c == 'Overdue') {
                                        //updated by RUL on 20/03/2019 to add read only record type check
	                                    if(req.RecordTypeId == initrecortypeid || req.RecordTypeId == readOnlyRecorTypeId) {
	                                        if(p.Initiative__c == req.Initiative__c) {
	                                            overdueRequirements = true;
	                                            break; //stops loops as soon as condition is met
	                                        }
	                                    } else {
	                                        overdueRequirements = true;
	                                        break; //stops loops as soon as condition is met                                        
	                                    }
	                                }
	                            }
	                        }
	                        //if(pendingRequirements <> p.pending_Requirements__c || overdueRequirements <> p.overdue_requirements__c || sendforpayment <> p.Send_for_Payment__c){                       
                            if(pendingRequirements <> p.pending_Requirements__c || overdueRequirements <> p.overdue_requirements__c){   
                            	Payment__c updatedPayment = new Payment__c(Id = p.Id); 
                                System.debug('IN Final Set **** :'+pendingRequirements);
	                            updatedPayment.Pending_Requirements__c = pendingRequirements;
	                            updatedPayment.Overdue_Requirements__c = overdueRequirements;                       
	                            updatePaymentList.add(updatedPayment);                      
	                        }                                                          
	
	                    }
	                }
	                if(updatePaymentList.size() > 0){
	                	if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
	                		update updatePaymentList;
	                	}
	                }
	            }
	        }
        }
    }
    
    /**
    
    public static void checkRequirements(List<Requirement__c> requirementList) {
        id orgrecordtypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Organisation Requirement'].Id; 
        id initrecortypeid = [Select Id from RecordType where sobjectType = 'Requirement__c' and Name = 'Initiative Requirement'].Id;
        Set<Id> partnerIdSet = new Set<Id>();
        List<Payment__c> updatePaymentList = new List<Payment__c>();
        Boolean pendingRequirements;
        Boolean overdueRequirements;
        for(Requirement__c r : requirementList){
            partnerIdSet.add(r.Partner__c);
        }
        if(partnerIdSet.size () > 0) {
            List<Payment__c> payList = [Select Id, Status__c, Date__c, Initiative__r.Investment_Area__c, Pending_Requirements__c, Overdue_Requirements__c from Payment__c where Partner__c =: partnerIdSet and (Status__c != 'Paid' or Status__c != 'Processed' or Status__c != 'Cancelled')];  
            List<Requirement__c> reqList = [Select Id, Hold_Payments__c, RecordTypeId, Due_Date__c, Initiative__r.Investment_Area__c, Status__c FROM Requirement__c WHERE Partner__c =: partnerIdSet and (Status__c = 'Pending' or Status__c = 'Overdue')];         
            if(payList.size() > 0) {
                for(Payment__c p: payList){
                    pendingRequirements = false;
                    overdueRequirements = false;
                    for(Requirement__c req : reqList){
                        if(req.Due_Date__c <= p.Date__c && req.Hold_Payments__c == true && (req.RecordTypeId == orgrecordtypeid || (req.RecordTypeId == initrecortypeid && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c))){
                            if(req.Status__c == 'Pending')
                            pendingRequirements = true;
                            else if(req.Status__c == 'Overdue')
                            overdueRequirements = true;
                        }
                    }                       
                    if(pendingRequirements <> p.pending_Requirements__c || overdueRequirements <> p.overdue_requirements__c){                       
                        p.Pending_Requirements__c = pendingRequirements;
                        p.Overdue_Requirements__c = overdueRequirements;                        
                        updatePaymentList.add(p);                       
                    }           
                }
            } 
            if(updatePaymentList.size() > 0)            
                update updatePaymentList;           
        }   
    }
    
    **/
    
    //Update checkbox at variation
    public static void updateVariation(Map<Id,Requirement__c> newRequirements, Map<Id,Requirement__c> oldRequirements){
                system.debug('Inside RequirementTriggerHandler updateVariation() method');

    	Set<Id> initiative = new Set<Id>();
    	for(String requirementId :newRequirements.keySet()){
    		
    		if(((newRequirements.get(requirementId).Initiative__c != oldRequirements.get(requirementId).Initiative__c) || 
				(newRequirements.get(requirementId).Reporting_Type__c != oldRequirements.get(requirementId).Reporting_Type__c) || 
				(newRequirements.get(requirementId).Initiatives_Owner_Email__c != oldRequirements.get(requirementId).Initiatives_Owner_Email__c) || 
				(newRequirements.get(requirementId).Name != oldRequirements.get(requirementId).Name) || (newRequirements.get(requirementId).Due_Date__c != oldRequirements.get(requirementId).Due_Date__c) || (newRequirements.get(requirementId).Description__c != oldRequirements.get(requirementId).Description__c) || (newRequirements.get(requirementId).Instructions__c != oldRequirements.get(requirementId).Instructions__c) || (newRequirements.get(requirementId).Hold_Payments__c != oldRequirements.get(requirementId).Hold_Payments__c) || (newRequirements.get(requirementId).Completed_Date__c != oldRequirements.get(requirementId).Completed_Date__c) || (newRequirements.get(requirementId).Cancelled_Notes__c != oldRequirements.get(requirementId).Cancelled_Notes__c) || (newRequirements.get(requirementId).Cancelled_Date__c != oldRequirements.get(requirementId).Cancelled_Date__c) || (newRequirements.get(requirementId).Notes != oldRequirements.get(requirementId).Notes))){
				if(String.isNotBlank(newRequirements.get(requirementId).Initiative__c)){
	    			initiative.add(newRequirements.get(requirementId).Initiative__c);
	    		}
			}
    	}
    	if(!initiative.isEmpty()){
    		List<Initiative__c> relatedInitiatives = [SELECT Id, 
    														 Investment_Schedule_Variation__c, 
    														 Investment_Schedule_Variation__r.Is_Active__c
    												  FROM   Initiative__c 
    												  WHERE  Id IN: initiative
    												 ];
    		if(!relatedInitiatives.isEmpty()){
    			Set<Variation__c> updateVariation = new Set<Variation__c>();
    			for(Initiative__c objInitiative: relatedInitiatives){
                    //system.debug('objInitiative.Investment_Schedule_Variation'+objInitiative.Investment_Schedule_Variation__c);
    				if(String.isNotBlank(objInitiative.Investment_Schedule_Variation__c)){ if(objInitiative.Investment_Schedule_Variation__r.Is_Active__c){
	    				//update payment varied
	    					updateVariation.add(new Variation__c(
	    						Id = objInitiative.Investment_Schedule_Variation__c,
	    						Requirements_Varied__c = true
	    					));
	    				}
    				}
    			}
    			if(!updateVariation.isEmpty()){List<Variation__c> variationsUpdate = new List<Variation__c>(updateVariation);update variationsUpdate;
    			}
    		}
    		
    	}
    }
    public static void updateOldRecordType(List<Requirement__c> listRequirement){
                system.debug('Inside RequirementTriggerHandler updateOldRecordType() method');

        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            Set<String> recordTypeIdSet = new Set<String>();
            //To have number of SOQL queries executed so far
           for(Requirement__c objReq : listRequirement){
               if(objReq.RecordTypeId != fetchRecordTypeId('Initiative_Requirement_Completed_Read_Only') 
                   && objReq.RecordTypeId != fetchRecordTypeId('RUL_Initiative_Requirement_ReadOnly')){
                       objReq.RUL_Old_RecordType_Id__c = objReq.RecordTypeID;
                   }
                   if(!objReq.Status__c.containsIgnoreCase('Variation')){
                    objReq.Old_Status__c = objReq.Status__c;
                }
             }
        }
    }
    
    public static String fetchRecordTypeId (String recordTypeName) {
                system.debug('Inside RequirementTriggerHandler fetchRecordTypeId() method');

        String recordTypeId =  Schema.SObjectType.Requirement__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();        
        return recordTypeId;
    }
    

}