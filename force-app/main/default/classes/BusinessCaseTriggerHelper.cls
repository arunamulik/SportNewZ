public with sharing class BusinessCaseTriggerHelper {
    
    public static  List<Business_Case__c> updateinvestmentScheduleToSigned (Set<Id> setInvestmentSchedule){

        List<Business_Case__c> listInvSchedule = new List<Business_Case__c>();
        for(Business_case__c objInvSch : [Select ID,status__c from Business_case__c Where ID IN : setInvestmentSchedule]){
            objInvSch.status__c = 'Signed';
            listInvSchedule.add(objInvSch);
        }
        return listInvSchedule;
    }
    
    public static  List<Variation__c> updateVariation(Set<Id> investmentsToUpdateReadOnly){

         List<Business_Case__c >listBusinessCase = getListofInvestmentSchedules(investmentsToUpdateReadOnly);
         if(!listBusinessCase.isEmpty()){
             List<Variation__c> relatedVariation = new List<Variation__c>();
             //system.debug('relatedVariation >>>>>>>>>>>>>'+relatedVariation );
             //if(!relatedVariation.isEmpty()){
                  for(Variation__c objVariation: [SELECT Id, Variation_Completed_Date__c, Is_Active__c FROM Variation__c WHERE Is_Active__c = true AND Investment_Schedule__c IN: listBusinessCase ]){
                      objVariation.Variation_Completed_Date__c = Date.today();
                      relatedVariation.add(objVariation);
                  } 
             //}
              return relatedVariation;
         }else{
            return new List<Variation__c>();
         }
        
    }
    
    private static  List<Business_Case__c > getListofInvestmentSchedules(Set<Id> investmentsToUpdateReadOnly){

        List<Business_Case__c >listBusinessCase = new List<Business_Case__c>();
         for(Business_Case__c objIS : [Select ID,Variation_Count__c From Business_Case__c Where ID IN: investmentsToUpdateReadOnly]){
           //System.debug('BusinessCase List>>>>>>>>>>>'+objIS.Variation_Count__c);
              if(objIS.Variation_Count__c > 0 ){
               //System.debug('Business Count>>>>>>>>'+objIS);
               listBusinessCase.add(objIS);
              }
          }
          return listBusinessCase;
    }
    
    public static List<Initiative__c> relatedInitiativesReadOnly(Set<Id> investmentsToUpdateReadOnly){

        return [SELECT Id, 
                       Business_Case__c,
                       Old_RecordTypeID__c, 
                       Business_Case__r.Status__c, 
                       Type__c,
                       Partner__r.Type,
                       Approved__c,
                       RecordType.DeveloperName , 
                       (SELECT Id, 
                               Old_Status__c,
                               Initiative__c, 
                               RecordTypeId, 
                               RecordType.DeveloperName 
                        FROM Measures__r
                        WHERE Status__c !='Met' ), 
                       (SELECT Id, 
                               Old_Status__c,
                               Initiative__c, 
                               RecordTypeId, 
                               RecordType.DeveloperName ,
                               Status__c,
                               Supplier_Invoice_Date__c,
                               Supplier_Invoice_Number__c 
                        FROM Payments__r
                        WHERE Status__c != 'Paid'), 
                       (SELECT Id, 
                               Old_Status__c,
                               Initiative__c, 
                               RecordTypeId, 
                               RecordType.DeveloperName 
                        FROM Requirements__r
                        WHERE status__C not in ('Completed','Cancelled')) 
                FROM   Initiative__c 
                WHERE Business_Case__c IN: investmentsToUpdateReadOnly];
    }
    
    public static List<Measure__c> updateMeasureWithOldStatus(List<Measure__c> listofRelatedMeasure){
         List<Measure__c> listMeasure = new List<Measure__c>();
         for(Measure__c objMeasure : listofRelatedMeasure){
             if(objMeasure.Old_Status__c != NULL){
                objMeasure.Status__c = objMeasure.Old_Status__c ;
                listMeasure.add(objMeasure);
             }
         }
         return listMeasure;
    }
    
    public static List<Requirement__c> updateRequirementWithOldStatus(List<Requirement__c> listofRelatedRequirement){

        List<Requirement__c> listRequirement = new List<Requirement__c>();
        for(Requirement__c objReq :listofRelatedRequirement){
            if(objReq.Old_Status__c != NULL){
                objReq.Status__c = objReq.Old_Status__c;
                listRequirement.add(objReq);
            }
        }
         return listRequirement;
    }
    
    public static List<Payment__c> updatePaymentWithOldStatus(List<Payment__c> listofRelatedPayment){

         List<Payment__c> listPayment = new List<Payment__c>();
         for(Payment__c objPay : listofRelatedPayment){
              if(objPay.Old_Status__c != NULL){
                  objPay.Status__c = objPay.Old_Status__c;
                  listPayment.add(objPay);
              }
          }
         return listPayment;
    }
    
    public static Boolean updateInitiativeApproved(List<Initiative__c> relatedInitiatives,Boolean isReadOnly, Map<String,Id> recordTypesAvailable){
        
	for(Initiative__c objInitiative : relatedInitiatives){
                
                if(isReadOnly){
                    objInitiative.RecordTypeId = recordTypesAvailable.get('RUL_Read_Only_Initiative');
                }else if(String.isNotBlank(objInitiative.Old_RecordTypeID__c)){
                    objInitiative.RecordTypeId = objInitiative.Old_RecordTypeID__c;
                }
                //////ool//////////////////////////////////
                if(objInitiative.Approved__c && objInitiative.Business_Case__r.Status__c != 'Approved' && objInitiative.Business_Case__r.Status__c != 'Signed'){
                    //System.debug('false');
                    objInitiative.Approved__c = false;
                }
                else if (!objInitiative.Approved__c && (objInitiative.Business_Case__r.Status__c == 'Approved' || objInitiative.Business_Case__r.Status__c == 'Signed')){
                    //System.debug('true');
                    objInitiative.Approved__c = true;
                }
                
              //////////////////////////////////////////////
        }
        //system.debug('relatedInitiatives -------------------------'+relatedInitiatives);
        
        try{
            update relatedInitiatives;
            return false;
        }catch(DmlException e){
           system.debug('The following exception has occurred during making records readonly(Initiative): ' + e.getMessage());
           return true;
        }
    }
    
    public static Boolean updateMeasureRecordType(Set<Id> investmentsToUpdateReadOnly, List<Initiative__c> relatedInitiatives,  Map<String,Id> recordTypesAvailable ){

        List<Measure__c> relatedMeasure = new List<Measure__c>();
        for(Initiative__c objInitiative : relatedInitiatives){
            //system.debug('Measure Present ---------------------'+(investmentsToUpdateReadOnly.contains(objInitiative.Id)));
            if(investmentsToUpdateReadOnly.contains(objInitiative.Business_Case__c)){
                //system.debug('Inside Measure>>>>>>>>');
                for(Measure__c objMeasure : objInitiative.Measures__r){
                    //system.debug('Messure>>>>>>>>>>>'+objMeasure.id);
                    if(objMeasure.RecordType.DeveloperName == 'Percent'){
                        objMeasure.RecordTypeId = recordTypesAvailable.get('RUL_Percent_Read_Only');
                    }else if(objMeasure.RecordType.DeveloperName == 'Number'){
                        objMeasure.RecordTypeId = recordTypesAvailable.get('RUL_Number_Read_Only');
                    }else if(objMeasure.RecordType.DeveloperName == 'Currency'){
                        objMeasure.RecordTypeId = recordTypesAvailable.get('RUL_Currency_Read_Only');
                    }else if(objMeasure.RecordType.DeveloperName == 'Text'){
                        objMeasure.RecordTypeId = recordTypesAvailable.get('RUL_Text_Read_Only');
                    }
                    relatedMeasure.add(objMeasure);
                    //system.debug('relatedMeasure>>>>>>>'+relatedMeasure);
                }
            }
        }
        if(!relatedMeasure.isEmpty()){
            try{
                update relatedMeasure;
                return false;
            }catch(DmlException e){
               system.debug('The following exception has occurred during making records readonly(Measure): ' + e.getMessage());
               return true;
            }
        }else{
            return false;
        }
        
    }
    
    public static Boolean updateRequirementRecordType(Set<Id> investmentsToUpdateReadOnly, List<Initiative__c> relatedInitiatives,  Map<String,Id> recordTypesAvailable ){

        List<Requirement__c> relatedRequirements =  new List<Requirement__c>();
        for(Initiative__c objInitiative : relatedInitiatives){
            if(investmentsToUpdateReadOnly.contains(objInitiative.Business_Case__c)){
                for(Requirement__c objRequirement : objInitiative.Requirements__r){
                    //system.debug('Inside Requirement'+objRequirement.RecordTypeId);
                   // system.debug('Condition Requirement>>>>>>'+(objRequirement.RecordTypeId != recordTypesAvailable.get('RUL Read Only')));
                    if(objRequirement.RecordType.DeveloperName == 'Initiative_Requirement' ){
                        objRequirement.RecordTypeId = recordTypesAvailable.get('RUL_Initiative_Requirement_ReadOnly');
                        //System.debug('Update Requirem,ent'+objRequirement);
                        relatedRequirements.add(objRequirement);
                    }else if(objRequirement.RecordType.DeveloperName == 'Requirement_Completed' ){
                        objRequirement.RecordTypeId = recordTypesAvailable.get('Initiative_Requirement_Completed_Read_Only');
                        //System.debug('Update Requirem,ent'+objRequirement);
                        relatedRequirements.add(objRequirement);
                    }
                }
            }
        }
        if(!relatedRequirements.isEmpty()){
            try{
                update relatedRequirements;
                return false;
            }catch(DmlException e){
               system.debug('The following exception has occurred during making records readonly(Requirement): ' + e.getMessage());
               return true;
            }
        }else{
            return false;
        }
    }
    
    public static Boolean updatePaymentsRecordType(Set<Id> investmentsToUpdateReadOnly, List<Initiative__c> relatedInitiatives,  Map<String,Id> recordTypesAvailable ){

        Boolean paymentUpdated = false;
        List<Payment__c> relatedPayments = new List<Payment__c>();
        for(Initiative__c objInitiative : relatedInitiatives){
            if(investmentsToUpdateReadOnly.contains(objInitiative.Business_Case__c)){
                for(Payment__c objPayment : objInitiative.Payments__r){
                    if(objInitiative.Business_Case__c<>NULL && (objInitiative.Business_Case__r.Status__c =='Approved') && objInitiative.Type__c == 'Paid to Third Party'){
                        if (objPayment.Status__c=='Draft' && objPayment.Supplier_Invoice_Date__c<>NULL && objPayment.Supplier_Invoice_Number__c<>NULL && !String.isBlank(objPayment.Supplier_Invoice_Number__c)){
                            objPayment.Status__c = 'Scheduled';
                            paymentUpdated = true;
                        }
                    }else if(objInitiative.Business_Case__c<>NULL && (objInitiative.Business_Case__r.Status__c =='Approved') && objInitiative.Type__c == 'Paid Direct' && objInitiative.Partner__r.Type=='Supplier'){
                        if (objPayment.Status__c=='Draft' && objPayment.Supplier_Invoice_Date__c<>NULL && 
                            objPayment.Supplier_Invoice_Number__c<>NULL && !String.isBlank(objPayment.Supplier_Invoice_Number__c)){
                            objPayment.Status__c = 'Scheduled';
                            paymentUpdated = true;
                        }
                    }
                    //system.debug('objpayment recordtype>>>'+objPayment.RecordTypeId);
                    //system.debug('Condition Payment>>>>>>'+(objPayment.RecordTypeId != recordTypesAvailable.get('RUL Payment Read Only')));
                    if(objPayment.RecordType.DeveloperName == 'Payment'){
                        objPayment.RecordTypeId = recordTypesAvailable.get('RUL_Payment_Read_Only');
                        paymentUpdated = true;
                       // system.debug('Update payemtn'+objPayment);
                    }else if(objPayment.RecordType.DeveloperName == 'Refund'){
                        objPayment.RecordTypeId = recordTypesAvailable.get('Refund_Read_Only');
                        paymentUpdated = true;
                        //system.debug('Update payemtn'+objPayment);
                    }else if(objPayment.RecordType.DeveloperName == 'Credit'){
                        objPayment.RecordTypeId = recordTypesAvailable.get('Credit_Read_Only');
                        paymentUpdated = true;
                        //system.debug('Update payemtn'+objPayment);
                    }else if(objPayment.RecordType.DeveloperName == 'Service_Credit'){
                        objPayment.RecordTypeId = recordTypesAvailable.get('Buy_Back_Read_Only');
                        paymentUpdated = true;
                        //system.debug('Update payemtn'+objPayment);
                    }
                    relatedPayments.add(objPayment);
                }
            }
        }
        if(!relatedPayments.isEmpty()){
            try{
                update relatedPayments;
            }catch(DmlException e){
               system.debug('The following exception has occurred during making records readonly(Payment): ' + e.getMessage());
               paymentUpdated = false;
            }
        }
        return paymentUpdated;
    }
}