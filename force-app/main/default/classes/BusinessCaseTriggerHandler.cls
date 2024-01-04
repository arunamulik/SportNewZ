public with sharing class BusinessCaseTriggerHandler {
   
   //Has been merged to reduced the update call for Initiative
   /*
    public static void updateInitiatives(List<Id> businessCaseIdList){
        system.debug('###Inside updateInitiatives #######');

        List<Initiative__c> initiatives_List = [SELECT Id, Approved__c, Business_Case__r.Status__c,Old_RecordTypeID__c, RecordTypeId  FROM Initiative__c WHERE Business_Case__c IN: businessCaseIdList];

        System.debug('--initiatives_List-->>>'+initiatives_List);

        for(Initiative__c i : initiatives_List){
            if(i.Approved__c && i.Business_Case__r.Status__c != 'Approved' && i.Business_Case__r.Status__c != 'Signed'){
                System.debug('false');
                i.Approved__c = false;
            }
            else if (!i.Approved__c && (i.Business_Case__r.Status__c == 'Approved' || i.Business_Case__r.Status__c == 'Signed')){
                System.debug('true');
                i.Approved__c = true;
            }
            
        }
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            update initiatives_List;
        }
    }*/

    // Added on 7th july 2015
    public static void updatePaymentStatusToScheduled(map<Id,Business_Case__c> newMap){

        //List<Payment__c> paymentLst = new List<Payment__c>();
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            List<Payment__c> lstOfPayment = new List<Payment__c>();
            List<Payment__c> tempLstOfPayment = new List<Payment__c>();
            
            List<Initiative__c> lstOfInv = [Select Id,Name,Business_Case__c,
                                                (Select Id,Name,Initiative__r.Business_Case__r.Status__c,Status__c,Initiative__r.Type__c,
                                                        Initiative__r.Partner__r.Type,Supplier_Invoice_Date__c,Supplier_Invoice_Number__c 
                                                 FROM Payments__r WHERE Status__c='Draft') 
                                            FROM Initiative__c
                                            WHERE Business_Case__c IN :newMap.keySet()];
          
                                            
            if (lstOfInv<>NULL && !lstOfInv.isEmpty()){
                for (Initiative__c inv : lstOfInv){
                    if (inv.Payments__r<>NULL){
                        for (Payment__c payment : inv.Payments__r){
                            if (payment.Initiative__r.Business_Case__r<>NULL &&
                                payment.Initiative__r.Business_Case__r.Status__c =='Signed' && payment.Initiative__r.Type__c != 'Paid to Third Party'
                                && payment.Initiative__r.Partner__r.Type!='Supplier') {
                                if (payment.Status__c=='Draft'){
                                    payment.Status__c = 'Scheduled';
                                    tempLstOfPayment.add(payment);
                                }
                                // Below code handle scenarios of supplier
                            } else {
                                    if(payment.Initiative__r.Business_Case__r<>NULL && 
                                        (payment.Initiative__r.Business_Case__r.Status__c =='Approved' || payment.Initiative__r.Business_Case__r.Status__c =='Signed')
                                        && payment.Initiative__r.Type__c == 'Paid to Third Party'){
                                        if (payment.Status__c=='Draft' && payment.Supplier_Invoice_Date__c<>NULL && 
                                            payment.Supplier_Invoice_Number__c<>NULL && !String.isBlank(payment.Supplier_Invoice_Number__c)){
                                                payment.Status__c = 'Scheduled';
                                                tempLstOfPayment.add(payment);
                                            
                                        }
                                        
                                    } else  if(payment.Initiative__r.Business_Case__r<>NULL && 
                                                (payment.Initiative__r.Business_Case__r.Status__c =='Approved' || payment.Initiative__r.Business_Case__r.Status__c =='Signed')
                                                && payment.Initiative__r.Type__c == 'Paid Direct' && payment.Initiative__r.Partner__r.Type=='Supplier'){
                                            
                                            if (payment.Status__c=='Draft' && payment.Supplier_Invoice_Date__c<>NULL && 
                                                payment.Supplier_Invoice_Number__c<>NULL && !String.isBlank(payment.Supplier_Invoice_Number__c)){
                                                    payment.Status__c = 'Scheduled';
                                                    tempLstOfPayment.add(payment);
                                            }
                                            
                                    } else if (payment.Initiative__r.Type__c == 'Paid Direct' && payment.Initiative__r.Business_Case__r.Status__c =='Signed' && payment.Initiative__r.Partner__r.Type!='Supplier' && 
                                               (payment.Supplier_Invoice_Date__c<>NULL || (payment.Supplier_Invoice_Number__c<>NULL && !String.isBlank(payment.Supplier_Invoice_Number__c)))){
                                               newMap.values()[0].addError('Suppplier Invoice number and Invoice date should not be populated because organization type of initiative is not supplier or Initiative is not paid to third party or status of investment schedule is not approved.');
                                    } 
                             }
                        }
                    }
                }
            }
            if (tempLstOfPayment<>NULL && !tempLstOfPayment.isEmpty()){
              try{
                if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                    update tempLstOfPayment;
                }
              }
              catch(Exception ex){
                system.debug('@@@ Exception-->'+ex.getMessage());
              }
            }
        }
    }

    public static void populateStrategicAreaOwner(Set<Id> setBusinessCaseIds){

        List<Business_Case__c> listBusinessCases = [SELECT Id, Strategic_Area__c, Strategic_Area__r.OwnerId, Strategic_Area_ID__c, Strategic_Area_Owner__c, Strategic_Area_Owner_Id__c FROM Business_Case__c WHERE Id IN: setBusinessCaseIds];
        List<Business_Case__c> listBusinessCasesToUpdate = new List<Business_Case__c>();
        for(Business_Case__c businessCase : listBusinessCases){
            if(businessCase.Strategic_Area__c != null){
                businessCase.Strategic_Area_Owner__c = businessCase.Strategic_Area__r.OwnerId;
                listBusinessCasesToUpdate.add(businessCase);
            }
        }
        if(listBusinessCasesToUpdate.size() > 0 && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))){
            update listBusinessCasesToUpdate;
        }
    }

    public static void setStrategicAreaOwner(List<Business_Case__c> isList){

        for(Business_Case__c i : isList){
            if(i.Investment_Area__c != null){
              i.Strategic_Area_Owner__c = i.Strategic_Area_Owner_Id__c;
              i.Investment_Area_Owner__c = i.Investment_Area_Owner_Id__c;
              i.Strategic_Area__c = i.Strategic_Area_Id__c;
            }
            else{
              //i.Strategic_Area_Owner__c = null;
              i.Investment_Area_Owner__c = null;
              //i.Strategic_Area__c = null;
            }
        }
        //update isList;
    }

    /*public static void setTermsAndConditions (List<Business_Case__c> isList){

        //List<Business_Case__c> isList = [SELECT T_Cs__c,T_C_PDF__c FROM Business_Case__c WHERE Id IN: isIDList];

        List<Terms_and_Conditions__c> tcList = [SELECT Name, PDF__c FROM Terms_and_Conditions__c];
        Map<String,String> tcMap = new Map<String,String>();

        for(Terms_and_Conditions__c tc: tcList){
            tcMap.put(tc.Name,tc.PDF__c);
        }

        for(Business_Case__c is: isList){
          if(tcMap.containsKey(is.T_Cs__c))
            is.T_C_PDF__c = tcMap.get(is.T_Cs__c);
          else
            is.T_C_PDF__c = null;
        }
        //update isList;
    }*/

    public static void setExecutiveSummary (List<Id> isIDList){

        List<Business_Case__c> isList = [SELECT Executive_Summary_Template__c,Executive_Summary__c FROM Business_Case__c WHERE Id IN: isIDList];
        List<Executive_Summary_Template__c> esList = [SELECT Id, Executive_Summary__c FROM Executive_Summary_Template__c];
        Map<Id,String> esMap = new Map<Id,String>();
        for(Executive_Summary_Template__c es: esList){
          esMap.put(es.Id,es.Executive_Summary__c);
        }
        for(Business_Case__c is: isList){
            if(esMap.containsKey(is.Executive_Summary_Template__c))
              is.Executive_Summary__c = esMap.get(is.Executive_Summary_Template__c);
            else{
              is.Executive_Summary__c = null;
            }
        }
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))
        update isList;
    }
    
    //Variation related changes
    public static Boolean updateRelatedInitiativesToEditable(Map<Id,Business_Case__c> newInvestmentSchedules, Map<Id,Business_Case__c> oldInvestmentSchedules){

        Boolean paymentUpdated = false;
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            //Return true if draft payment updated
                Map<String,Id> recordTypesAvailable = new Map<String,Id>();
                Set<String> objectsInvolved = new Set<String>();
                objectsInvolved.add('Initiative__c');
                objectsInvolved.add('Measure__c');
                objectsInvolved.add('Payment__c');
                objectsInvolved.add('Requirement__c');
                for(RecordType objRecordType: [Select Id, DeveloperName From RecordType WHERE sObjectType IN: objectsInvolved]){
                  recordTypesAvailable.put(objRecordType.DeveloperName , objRecordType.Id);
                }
            
            Set<ID> setInvestmentSchedule = new Set<ID>();
            Set<Id> investmentsToUpdate = new Set<Id>();
            Set<Id> investmentsToUpdateReadOnly = new Set<Id>();
            Set<Id> investmentsToUpdateSigned = new Set<Id>();
            List<Business_Case__c> listInvSchedule = new List<Business_Case__c>();
            Boolean isReadOnly = false;
            for(String investmentScheduleId : newInvestmentSchedules.keySet()){
                if(oldInvestmentSchedules.containsKey(investmentScheduleId)){
                    System.debug('Inside BCTriggerHandler : oldInvestmentSchedules.containsKey(investmentScheduleId)');
                    if(
                        (oldInvestmentSchedules.get(investmentScheduleId).Status__c == 'Approved' &&
                         ((oldInvestmentSchedules.get(investmentScheduleId).External_Signatory__c != newInvestmentSchedules.get(investmentScheduleId).External_Signatory__c)&&newInvestmentSchedules.get(investmentScheduleId).External_Signatory__c != NULL))
                        ||(oldInvestmentSchedules.get(investmentScheduleId).Status__c == 'Approved' &&
                           ((oldInvestmentSchedules.get(investmentScheduleId).Date_Signed_By_External_Party__c != newInvestmentSchedules.get(investmentScheduleId).Date_Signed_By_External_Party__c)&& newInvestmentSchedules.get(investmentScheduleId).Date_Signed_By_External_Party__c!= NULL))
                        ||(oldInvestmentSchedules.get(investmentScheduleId).Status__c == 'Approved' &&
                           ((oldInvestmentSchedules.get(investmentScheduleId).Document_Link_1__c != newInvestmentSchedules.get(investmentScheduleId).Document_Link_1__c)&& newInvestmentSchedules.get(investmentScheduleId).Document_Link_1__c!= NULL))
                        //||(oldInvestmentSchedules.get(investmentScheduleId).Status__c == 'Approved' && (oldInvestmentSchedules.get(investmentScheduleId).Document_Link_2__c != newInvestmentSchedules.get(investmentScheduleId).Document_Link_2__c))
                    ){
                        setInvestmentSchedule.add(investmentScheduleId);
                     }else if(
                        (oldInvestmentSchedules.get(investmentScheduleId).Status__c != 'Approved' && newInvestmentSchedules.get(investmentScheduleId).Status__c == 'Approved')
                    ){
                                investmentsToUpdateReadOnly.add(investmentScheduleId);
                                isReadOnly = true;
                    }else if(
                        (oldInvestmentSchedules.get(investmentScheduleId).Status__c == 'Approved' && newInvestmentSchedules.get(investmentScheduleId).Status__c == 'Signed')
                    ){
                                investmentsToUpdateReadOnly.add(investmentScheduleId);
                                isReadOnly  = true;
                    }
                    else if((oldInvestmentSchedules.get(investmentScheduleId).Status__c != 'Signed' &&  newInvestmentSchedules.get(investmentScheduleId).Status__c == 'Signed' )
                    ){
                                investmentsToUpdate.add(investmentScheduleId);
                    }
                 
                }
            }

           

            if(!setInvestmentSchedule.isEmpty() && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))){
                try{
                    if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                     
                        listInvSchedule = BusinessCaseTriggerHelper.updateinvestmentScheduleToSigned(setInvestmentSchedule);
                        if(!listInvSchedule.isEmpty()){
                            update listInvSchedule;
                        }
                    }
                }
                catch(DmlException e){
                        system.debug('The following exception has occurred during making records readonly: ' + e.getMessage());
                } 
            }
             List<Business_Case__c >listBusinessCase = new List<Business_Case__c>();
             List<Initiative__c> relatedInitiatives = new  List<Initiative__c> ();
             List<Initiative__c> listInitiative = new List<Initiative__c>();
             List<Measure__c> listMeasure = new List<Measure__c>();
             List<Requirement__c> listRequirement = new List<Requirement__c>();
             List<Payment__c> listPayment= new List<Payment__c>();
             List<Variation__c> variationsToUpdate = new List<Variation__c>();
             //Updated by RUL to revert status of related record to prior value ater completion of variation process.
             if(!investmentsToUpdateReadOnly.isEmpty() && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))){
                    variationsToUpdate = BusinessCaseTriggerHelper.updateVariation(investmentsToUpdateReadOnly);
                    if(!variationsToUpdate.isEmpty()){
                        try{
                            update variationsToUpdate;
                        }catch(DmlException e){
                           system.debug('The following exception has occurred during making records readonly: ' + e.getMessage());
                        }
                    }

                 for(Initiative__c objInitiative :  BusinessCaseTriggerHelper.relatedInitiativesReadOnly(investmentsToUpdateReadOnly) ){
                      if(investmentsToUpdateReadOnly.contains(objInitiative.Business_Case__c)){
                          listMeasure.addAll(BusinessCaseTriggerHelper.updateMeasureWithOldStatus(objInitiative.Measures__r));
                          listRequirement.addAll(BusinessCaseTriggerHelper.updateRequirementWithOldStatus(objInitiative.Requirements__r));
                          listPayment.addAll(BusinessCaseTriggerHelper.updatePaymentWithOldStatus(objInitiative.Payments__r));
                          
                     }
                 }
                
                 if(!listMeasure.isEmpty() || !listRequirement.isEmpty()|| !listPayment.isEmpty()){
                        try{
                            update listMeasure;
                            update listRequirement;
                            update listPayment;
                        }catch(DmlException e){
                           system.debug('The following exception has occurred during making records readonly: ' + e.getMessage());
                        }
                    }
            }
            if(!investmentsToUpdate.isEmpty() && !investmentsToUpdateReadOnly.isEmpty() && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))){

                Set<Id> tempSetForAllIds = new Set<Id>();
                 tempSetForAllIds.addAll(investmentsToUpdate);
                 tempSetForAllIds.addAll(investmentsToUpdateReadOnly);
                 relatedInitiatives = BusinessCaseTriggerHelper.relatedInitiativesReadOnly(tempSetForAllIds);
             }else if(!investmentsToUpdate.isEmpty()){
                relatedInitiatives = BusinessCaseTriggerHelper.relatedInitiativesReadOnly(investmentsToUpdate);
             }else if(!investmentsToUpdateReadOnly.isEmpty()){

                 relatedInitiatives = BusinessCaseTriggerHelper.relatedInitiativesReadOnly(investmentsToUpdateReadOnly);
             }
            if(!investmentsToUpdate.isEmpty()){

                if(!relatedInitiatives.isEmpty()){

                    Boolean hasInitiativeError = BusinessCaseTriggerHelper.updateInitiativeApproved( relatedInitiatives, isReadOnly  , recordTypesAvailable);
                }
            }
            if(!investmentsToUpdateReadOnly.isEmpty() && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))){

                if(!relatedInitiatives.isEmpty()){

                    Boolean reqHasError = false;
                    Boolean payHasError = false;
                    Boolean mesHasError = false;
                    Boolean initHasError = false;
                    if(!relatedInitiatives.isEmpty() && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))){
                        initHasError = BusinessCaseTriggerHelper.updateInitiativeApproved( relatedInitiatives, isReadOnly  , recordTypesAvailable);
                        if(!initHasError){
                            mesHasError = BusinessCaseTriggerHelper.updateMeasureRecordType(investmentsToUpdateReadOnly, relatedInitiatives, recordTypesAvailable);
                            reqHasError = BusinessCaseTriggerHelper.updateRequirementRecordType(investmentsToUpdateReadOnly, relatedInitiatives, recordTypesAvailable);
                            paymentUpdated = BusinessCaseTriggerHelper.updatePaymentsRecordType(investmentsToUpdateReadOnly, relatedInitiatives, recordTypesAvailable);
                        }
                    }
                }
            }
        }
        return paymentUpdated;
    }
    //updated by RUL on 12 December 2018 to clear Contract SIgned fields on Approved status and copy to Sign off History object
    public static void updateInvestmentSchedule(Map<Id,Business_Case__c> newInvestmentSchedules, Map<Id,Business_Case__c> oldInvestmentSchedules){

        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            List<Business_Case__c> listInvSchedule = new List<Business_Case__c>();
            List<Sign_Off_History__c> lstSign = new List<Sign_Off_History__c>();
            for(String investmentScheduleId : newInvestmentSchedules.keySet()){
                if(oldInvestmentSchedules.containsKey(investmentScheduleId)){
                   if(oldInvestmentSchedules.get(investmentScheduleId).Status__c != 'Approved' &&
                      newInvestmentSchedules.get(investmentScheduleId).Status__c == 'Approved' &&
                        (newInvestmentSchedules.get(investmentScheduleId).External_Signatory__c != NULL ||
                        newInvestmentSchedules.get(investmentScheduleId).Date_Signed_By_External_Party__c != NULL ||
                        newInvestmentSchedules.get(investmentScheduleId).Document_Link_1__c != NULL
                    )){
                        //Copy Contract signed window values to Sign Off History Object and 
                        Sign_Off_History__c obj = new Sign_Off_History__c();
                        Business_Case__c  objIS = new Business_Case__c();
                        obj.External_Signatory__c = newInvestmentSchedules.get(investmentScheduleId).External_Signatory__c;
                        objIS.External_Signatory__c = '';
                        obj.Date_Signed__c = newInvestmentSchedules.get(investmentScheduleId).Date_Signed_By_External_Party__c;
                        objIS.Date_Signed_By_External_Party__c = NULL;
                        obj.Document_Link_1__c = newInvestmentSchedules.get(investmentScheduleId).Document_Link_1__c; 
                        objIS.Document_Link_1__c = '';
                        obj.Document_Link_2__c = newInvestmentSchedules.get(investmentScheduleId).Document_Link_2__c;
                        objIS.Document_Link_2__c = '';
                        obj.Business_Case__c = newInvestmentSchedules.get(investmentScheduleId).id;
                        objIS.Id = newInvestmentSchedules.get(investmentScheduleId).id;
                        listInvSchedule.add(objIS);
                        lstSign.add(obj);
                     }
                              
                  }
                
                }
                if(!lstSign.isEmpty()){
                    try{
                        insert lstSign;
                        update listInvSchedule;
                    }
                    catch(Exception ex){
                        system.debug('Signoff is not inserted due to'+ex.getMessage());
                    }
               }
            }
            
        }
}