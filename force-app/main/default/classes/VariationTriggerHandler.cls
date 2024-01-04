/*------------------------------------------------------------
Author:         Ameya Wadke
Company:        Eternus Solutions Pvt. Ltd
Description:    Handler of trigger TrgVariation on Variation__c
Test Class:

History
25-05-2018      Ameya   Created
------------------------------------------------------------*/
public  class VariationTriggerHandler {
    public static Boolean getCatch = false;

    /**************************************************
    Purpose : Create set and map for different operations
    Params  : List<Variation__c>
    *****************************************************/
    public static void makeOtherVariationsInActive(List<Variation__c> newVariations){
        Set<Id> associatedInvestmentSchedule = new Set<Id>();
        Set<Id> newVariationsCreated = new Set<Id>();
        Map<Id,Id> investmentScheduleAndVariation = new Map<Id,Id>();
        //Creating set of new variations and all Investment schedules related to them
        for(Variation__c objVariations: newVariations){
            associatedInvestmentSchedule.add(objVariations.Investment_Schedule__c);
            newVariationsCreated.add(objVariations.Id);
            investmentScheduleAndVariation.put(objVariations.Investment_Schedule__c,objVariations.Id);
        }
        if(!investmentScheduleAndVariation.isEmpty()){
            connectVariationWithInitiatives(investmentScheduleAndVariation,associatedInvestmentSchedule);
        }
        if(!associatedInvestmentSchedule.isEmpty()){
            List<Business_Case__c> investmentSchedulesUpdate = [SELECT Id,
                                                                       Name,
                                                                       Status__c
                                                                FROM   Business_Case__c
                                                                WHERE  Id IN: associatedInvestmentSchedule];
            for(Business_Case__c objInvestmentSchedule : investmentSchedulesUpdate){
                //system.debug('Investment Name======'+objInvestmentSchedule.Name);
                //system.debug('condition>>>>>>>>>>>'+objInvestmentSchedule.Name.contains('Varied'));
                if(!objInvestmentSchedule.Name.contains('Varied')){
                 //system.debug('objInvestmentSchedule.Name >>>>>>>>>'+objInvestmentSchedule.Name);
                    objInvestmentSchedule.Name = 'Varied-'+objInvestmentSchedule.Name;
                }
                
                objInvestmentSchedule.Status__c = 'Being Varied';
            }
            update investmentSchedulesUpdate;
            makeRelatedVariationInActive(associatedInvestmentSchedule,newVariationsCreated);
        }

    }

    /**************************************************
    Purpose : All Initiatives related to InvestmentSchedule
              of variation are connected to variation also
    Params  : Map<Id,Id>, Set<Id>
    *****************************************************/
    public static void connectVariationWithInitiatives(Map<Id,Id> investmentScheduleAndVariation, Set<Id> associatedInvestmentSchedule){
        Map<Id,List<Initiative__c>> investmentScheduleAndInitiatives = new Map<Id,List<Initiative__c>>();
        //Map creation for Investment Schedule and associated initiatives
        for(Initiative__c objInitiative : [SELECT Id,
                                                  Investment_Schedule_Variation__c,
                                                  Business_Case__c ,
                                                  Old_RecordTypeID__c,
                                                  RecordTypeId
                                           FROM   Initiative__c
                                           WHERE  Business_Case__c IN: associatedInvestmentSchedule]){
            if(investmentScheduleAndInitiatives.isEmpty()){
                List<Initiative__c> relatedInitiatives = new List<Initiative__c>();
                relatedInitiatives.add(objInitiative);
                investmentScheduleAndInitiatives.put(objInitiative.Business_Case__c,relatedInitiatives);
            }else{
                if(investmentScheduleAndInitiatives.containsKey(objInitiative.Business_Case__c)){
                    List<Initiative__c> relatedInitiatives = investmentScheduleAndInitiatives.get(objInitiative.Business_Case__c);
                    relatedInitiatives.add(objInitiative);
                    investmentScheduleAndInitiatives.put(objInitiative.Business_Case__c,relatedInitiatives);
                }else{
                    List<Initiative__c> relatedInitiatives = new List<Initiative__c>();
                    relatedInitiatives.add(objInitiative);
                    investmentScheduleAndInitiatives.put(objInitiative.Business_Case__c,relatedInitiatives);
                }
            }
        }
        if(!investmentScheduleAndInitiatives.isEmpty()){
            //Update Initiative with the active variation
            Set<Id> updatedInitiativeIds = new Set<Id>();
            List<Initiative__c> updateInitiatives = new List<Initiative__c>();
            for(String investmentId : investmentScheduleAndInitiatives.keySet()){
                for(Initiative__c objInitiative: investmentScheduleAndInitiatives.get(investmentId)){
                    objInitiative.Investment_Schedule_Variation__c = investmentScheduleAndVariation.get(investmentId);
                    objInitiative.Status_Value__c = 'Variation';
                    if(String.isNotBlank(objInitiative.Old_RecordTypeID__c)){
                        objInitiative.RecordTypeId = objInitiative.Old_RecordTypeID__c;
                    }
                    updateInitiatives.add(objInitiative);
                    updatedInitiativeIds.add(objInitiative.Id);
                }
            }
            //update all initiatives with current active variation
            if(!updateInitiatives.isEmpty()){
                //system.debug('Variation Cpu ------------------- '+Limits.getCpuTime());
                if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                    update updateInitiatives;
                }
            }

        }
    }
    public static void updateInitiativeRelatedObjects(Map<Id,Variation__c> newVariations){
        Set<Payment__c> updatePayments = new Set<Payment__c>();
        Set<Requirement__c> updateRequirements = new Set<Requirement__c>();
        Set<Measure__c> updateMeasures = new Set<Measure__c>();
        for(Initiative__c objInit: [SELECT Id,
                                         (SELECT Id,
                                                   Status__c,
                                                 RUL_Old_RecordType_Id__c,
                                                 RecordTypeId
                                             FROM   Payments__r
                                             WHERE Status__c != 'Paid'
                                             ),
                                             (SELECT Id,
                                                   Status__c,
                                                   RUL_Old_RecordType_Id__c, 
                                                   RecordTypeId
                                             FROM   Requirements__r
                                             WHERE status__C not in ('Completed','Cancelled')
                                             ),
                                           (SELECT Id,
                                                   Status__c,
                                                   RUL_Old_RecordType_Id__c, 
                                                   RecordTypeId
                                             FROM   Measures__r
                                             WHERE Status__c !='Met' 
                                             )
                                   FROM   Initiative__c
                                   WHERE  Investment_Schedule_Variation__c IN: newVariations.keySet()
                                   and Status__c !='Closed'
                                   ]){
            for(Payment__c objPayment : objInit.Payments__r){
                if(objPayment.status__c == 'On Hold' || objPayment.status__c == 'Scheduled' ){
                	objPayment.Status__c = 'Variation';
               }
                if(String.isNotBlank(objPayment.RUL_Old_RecordType_Id__c)){
                         objPayment.RecordTypeId = objPayment.RUL_Old_RecordType_Id__c;
                 }
                updatePayments.add(objPayment);
            }
            for(Measure__c objMeasure : objInit.Measures__r){
                if(objMeasure.status__c == 'Pending'){
                	objMeasure.Status__c = 'Variation';
                }
                if(String.isNotBlank(objMeasure.RUL_Old_RecordType_Id__c)){
                     objMeasure.RecordTypeId = objMeasure.RUL_Old_RecordType_Id__c;
                }
                updateMeasures.add(objMeasure);
            }
            for(Requirement__c objReq : objInit.Requirements__r){
                if(objReq.status__c == 'Overdue' || objReq.status__c =='Pending'){
                	objReq.Status__c = 'Variation';
                }
                if(String.isNotBlank(objReq.RUL_Old_RecordType_Id__c)){
                    objReq.RecordTypeId = objReq.RUL_Old_RecordType_Id__c;
                }
                updateRequirements.add(objReq);
            }
        }

        //system.debug('Payments--------------------'+updatePayments);
       //system.debug('Requirements--------------------'+updateRequirements);
        //system.debug('Measures--------------------'+updateMeasures);

        //system.debug('CPU before requirements -----------------'+Limits.getCpuTime());
        if(!updateRequirements.isEmpty()){
            update new List<Requirement__c>(updateRequirements);
        }
        //system.debug('CPU before measures -----------------'+Limits.getCpuTime());
        if(!updateMeasures.isEmpty()){
            update new List<Measure__c>(updateMeasures);
        }
        //system.debug('CPU before payments -----------------'+Limits.getCpuTime());
        if(!updatePayments.isEmpty()){
            update new List<Payment__c>(updatePayments);
        }
    }

    /**************************************************
    Purpose : Mark all the sibling Variations as
              inactive on creation of new
    Params  : Set<Id>, Set<Id>
    *****************************************************/
    public static void makeRelatedVariationInActive(Set<Id> associatedInvestmentSchedule, Set<Id> newVariationsCreated){
        Map<Id,List<Variation__c>> investmentScheduleAndVariations = new Map<Id,List<Variation__c>>();
        //Create map of investment and all its associated variations
        for(Variation__c objVariations : [SELECT Id,
                                                 Investment_Schedule__c,
                                                 Is_Active__c
                                          FROM   Variation__c
                                          WHERE  Investment_Schedule__c IN: associatedInvestmentSchedule]){
            if(investmentScheduleAndVariations.isEmpty()){
                List<Variation__c> relatedVariations = new List<Variation__c>();
                relatedVariations.add(objVariations);
                investmentScheduleAndVariations.put(objVariations.Investment_Schedule__c,relatedVariations);
            }else if(investmentScheduleAndVariations.containsKey(objVariations.Investment_Schedule__c)){
                List<Variation__c> relatedVariations = investmentScheduleAndVariations.get(objVariations.Investment_Schedule__c);
                relatedVariations.add(objVariations);
                investmentScheduleAndVariations.put(objVariations.Investment_Schedule__c,relatedVariations);
            }else{
                List<Variation__c> relatedVariations = new List<Variation__c>();
                relatedVariations.add(objVariations);
                investmentScheduleAndVariations.put(objVariations.Investment_Schedule__c,relatedVariations);
            }
        }
        if(!investmentScheduleAndVariations.isEmpty()){
            List<Variation__c> inActiveVariations = new List<Variation__c>();
            //Mark the sibling variation records to inactive on creation of new sibling
            for(String invsetmentScheduleId : investmentScheduleAndVariations.keySet()){
                for(Variation__c objVariation : investmentScheduleAndVariations.get(invsetmentScheduleId)){
                    if(!newVariationsCreated.contains(objVariation.Id)){
                        objVariation.Is_Active__c = false;
                        inActiveVariations.add(objVariation);
                    }
                }
            }
            if(!inActiveVariations.isEmpty()){
                //system.debug('Variation Cpu Inactive------------------- '+Limits.getCpuTime());
                //Update the list of all inActive variations
                if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                    update inActiveVariations;
                }
            }
        }
    }


    /**************************************************
    Purpose : Update checkboxes on variation
    Params  : List<Variation__c>
    *****************************************************/
    public static void markCheckboxesOnUpdate(List<Variation__c> newVariations){
        for(Variation__c objVariation: newVariations){
            //system.debug('Variation -----------'+objVariation.Name+'----------------'+objVariation.Id);
            //system.debug('Condition ----------------'+(objVariation.Measures_Varied__c || objVariation.Payments_Varied__c || objVariation.Requirements_Varied__c || objVariation.Initiatives_Added__c));
            //system.debug('Measure -----------'+objVariation.Measures_Varied__c);
            //system.debug('Requirement -----------'+objVariation.Requirements_Varied__c);
            //system.debug('Payment -----------'+objVariation.Payments_Varied__c);
            //system.debug('Initiative Added -----------'+objVariation.Initiatives_Added__c);

            // if(objVariation.Measures_Varied__c || objVariation.Payments_Varied__c || objVariation.Requirements_Varied__c || objVariation.Initiatives_Added__c){
            //     system.debug('Initiative Varied -----------'+objVariation.Initiatives_Varied__c);
            //     if(!objVariation.Initiatives_Varied__c){
            //         objVariation.Initiatives_Varied__c = true;
            //     }
            // }
        }
    }
}