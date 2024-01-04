public with sharing class InitiativeTriggerHandler {
    
    //after insert/after update
    public static void updatePartner(List<Initiative__c> initList,Boolean isInsert){
        system.debug('Inside InitiativeTriggerHandler updatePartner() method');

        //get the partner field
        Set<Id> planIds = new Set<Id>();
        for(Initiative__c init: initList){
            planIds.add(init.Plan__c);
        }
        
        Map<Id, Plan__c> planMap = new Map<Id, Plan__c>([Select Id, Partner__c, RecordTypeId, RecordType.DeveloperName , Investment_Area__c from Plan__c where id in: planIds]);
        
        for(Initiative__c init: initList){
            if (planMap.get(init.Plan__c).RecordType.DeveloperName == 'Partner_Plan'  &&  planMap.get(init.Plan__c).Partner__c != null){
                //init.Partner__c = planMap.get(init.Plan__c).Partner__c;
            }
            else if (planMap.get(init.Plan__c).RecordType.DeveloperName == 'Bundled_Plan' &&  planMap.get(init.Plan__c).Investment_Area__c != null )   {
                init.Investment_Area__c = planMap.get(init.Plan__c).Investment_Area__c;
            }
        }
        //RUL functionality
        if(isInsert){
            linkActiveVariation(initList);
        }
    }
    
    
    public static void updateChildPaymentNRequirement(List<Initiative__c> initList, List<Initiative__c> oldinitList){
                system.debug('Inside InitiativeTriggerHandler updateChildPaymentNRequirement() method');

        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            set<id> InitiativeIdSet = new set<Id>();
            
            for (Initiative__c init : initList ){
                //Added check to prevent payments and requierments of variation Inititative to be Updated
                // This prevents the validation for incompatible status to be fired
                if(init.Status__c != Label.Variation){
                    InitiativeIdSet.add(init.Id);
                }
            }
            //system.debug('SetID======='+InitiativeIdSet);
            List<Requirement__c> reqLst= new List<Requirement__c>();
            List<Payment__c> payLst = new List<Payment__c>();
            map<Id,Initiative__c> oldInitmap = new map<Id,Initiative__c>(oldinitList);
            
            List<Initiative__c> comLst = [SELECT Id, name, Plan__c ,Investment_Area__c, Payments_Scheduled__c, Partner__c, Initiative_Owner__c, Initiative_Owner__r.Email,
                                          (SELECT Id, name, Plan__c, Partner__c,Initiative__c , RecordType.Name, Initiatives_Owner_Email__c FROM Requirements__r),
                                          (SELECT Id, Name, Plan__c, Initiative__c,  Partner__c, Status__c, Hold_Reason__c FROM Payments__r),Description__c
                                          FROM  Initiative__c
                                          WHERE id IN :InitiativeIdSet];
            
            System.Debug('Debug ::: Intiative records :: ' + comLst);
            System.Debug('Debug ::: Intiative records :: ' + comLst.size());
            
            for (Initiative__c item : ComLst){
                system.debug('Item');
                system.debug('size======'+item.Requirements__r.size());
                
                if (item.Requirements__r.size()>0 ){
                    system.debug('Condition 1========'+((item.Plan__c != NULL && oldInitmap.get(item.id).Plan__c != item.Plan__c) || (item.Partner__c != NULL && oldInitmap.get(item.id).Partner__c != item.Partner__c)));
                    system.debug('Condition 2========'+(item.Plan__c != NULL && oldInitmap.get(item.id).Plan__c != item.Plan__c));
                    system.debug('condition 3========'+(item.Partner__c != NULL && oldInitmap.get(item.id).Partner__c != item.Partner__c));
                    if(((item.Plan__c != NULL && oldInitmap.get(item.id).Plan__c != item.Plan__c) || (item.Partner__c != NULL && oldInitmap.get(item.id).Partner__c != item.Partner__c))){
                        for (Requirement__c Req :item.Requirements__r){
                            system.debug('Record type===='+Req.RecordType.Name);
                            if (Req.RecordType.Name == 'Initiative Requirement'){
                                // Req.Plan__c = (item.Plan__c  != null) ? item.Plan__c: (Req.Plan__c != null) ? Req.Plan__c: null;
                                Req.Plan__c = (item.Plan__c  != null) ? item.Plan__c : null;
                                Req.Partner__c = (item.Partner__c  != null) ? item.Partner__c: null ;//(Req.Partner__c != null) ? Req.Partner__c: null;
                                system.debug('Condition---------------'+(String.isNotBlank(item.Initiative_Owner__c) && String.isNotBlank(item.Initiative_Owner__r.Email)));
                                if(String.isNotBlank(item.Initiative_Owner__c) && String.isNotBlank(item.Initiative_Owner__r.Email) && Req.Initiatives_Owner_Email__c != item.Initiative_Owner__r.Email){
                                    Req.Initiatives_Owner_Email__c = item.Initiative_Owner__r.Email;
                                }
                                system.debug('Req ----------'+Req);
                                reqLst.add(Req);
                            }
                        }
                    }else{
                        for (Requirement__c Req :item.Requirements__r){
                            system.debug('Condition---------------'+(String.isNotBlank(item.Initiative_Owner__c) && String.isNotBlank(item.Initiative_Owner__r.Email)));
                            if(String.isNotBlank(item.Initiative_Owner__c) && String.isNotBlank(item.Initiative_Owner__r.Email) && Req.Initiatives_Owner_Email__c != item.Initiative_Owner__r.Email){
                                Req.Initiatives_Owner_Email__c = item.Initiative_Owner__r.Email;
                                system.debug('Req ----------'+Req);
                                reqLst.add(Req);
                            }
                        }
                    }
                }
                system.debug('Size of payment');
                if (item.Payments__r.size()>0 && ((item.Plan__c != NULL && oldInitmap.get(item.id).Plan__c != item.Plan__c) || (oldInitmap.get(item.id).Payments_Scheduled__c == false && item.Payments_Scheduled__c == true))){
                    for (Payment__c Pay : item.Payments__r){
                        //Pay.Plan__c = (item.Plan__c  != null) ? item.Plan__c: (Pay.Plan__c != null) ? Pay.Plan__c: null;
                        Pay.Plan__c = (item.Plan__c  != null) ? item.Plan__c : null;
                        if (Pay.Status__c =='Draft' && oldInitmap.get(item.id).Payments_Scheduled__c == false && item.Payments_Scheduled__c == true){
                            Pay.Status__c ='Scheduled';
                        }
                        payLst.add(Pay);
                        
                    }
                }
            }
            
            if (!reqlst.isEmpty()){    update reqLst;
            }
            
            System.Debug('Debug :: Payments  Initiative ::' + payLst);
            System.Debug('Debug :: Payments  Initiative :: Size' + payLst.size());
            
            if (!payLst.isEmpty()){ if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){   update payLst;
                }
            }
        }
    }
    
    public static void updateBusinessCaseAmount(List<Initiative__c> initList, List<Initiative__c> oldinitList){
                system.debug('Inside InitiativeTriggerHandler updateBusinessCaseAmount() method');

        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            
            set<id> businesscaseIdSet = new set<id>();
            map<id,Initiative__c> OldinitiativeMap = new map<id,Initiative__c>(oldinitList);
            
            for (Initiative__c init : initList){
                if (!businesscaseIdSet.contains(init.Business_Case__c)){
                    businesscaseIdSet.Add(init.Business_Case__c);
                }
            }
            
            List<Business_Case__c> BusinessCaselst = new list<Business_Case__c>();
            Set<Id> checkBusinessIdDuplicates = new Set<Id>();
            AggregateResult[] groupedResults = [SELECT Business_Case__c, SUM(Planned__c) PLANNED, SUM(SUM_Payments__c) PAYMENTS
                                                FROM Initiative__c
                                                WHERE Business_Case__c =:businesscaseIdSet and Business_Case__c <> null
                                                GROUP BY Business_Case__c];
            
            for (AggregateResult ar : groupedResults ){
                system.debug(ar);
                Business_Case__c Bcase = new Business_Case__c();
                Bcase.id = String.Valueof(ar.get('Business_Case__c'));
                Bcase.Total_Amount__c =  (ar.get('PLANNED') != null) ? decimal.Valueof(string.valueof(ar.get('PLANNED'))) : 0;
                Bcase.Total_Payments__c = (ar.get('PAYMENTS') != null) ? decimal.Valueof(string.valueof(ar.get('PAYMENTS'))) : 0;// Added by JTan 15/06/2017
                if(!checkBusinessIdDuplicates.contains(Bcase.Id)) {
                    BusinessCaselst.Add(Bcase);
                    checkBusinessIdDuplicates.add(Bcase.Id);
                }
            }
            
            System.debug('144Line businesscaseIdSet ' +businesscaseIdSet);
            
            for (Initiative__c oldinit :OldinitiativeMap.values() ){
                            System.debug('oldinit ' +oldinit);
                if(!businesscaseIdSet.contains(oldinit.Business_Case__c) && oldinit.Business_Case__c != null){
                    system.debug(oldinit);
                    Business_Case__c Bcase = new Business_Case__c();
                    Bcase.id = oldinit.Business_Case__c;
                    Bcase.Total_Amount__c = 0;
                    Bcase.Total_Payments__c = 0;// Added by JTan 15/06/2017
                    if(!checkBusinessIdDuplicates.contains(Bcase.Id)) {
                        BusinessCaselst.Add(Bcase);
                        checkBusinessIdDuplicates.add(Bcase.Id);
                    }
                }
            }
            //system.debug('BusinessCaselst-----------------------'+BusinessCaselst);
            //system.debug('BusinessCaselst --------------------- '+BusinessCaselst.size());
            if (!BusinessCaselst.isEmpty()){
                try{
                    if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                        update BusinessCaselst;
                    }
                }
                catch(Exception ex){
                    System.debug('Exception-->>>>'+ex);
                    /*Initiative__c inv = new Initiative__c(id= 'a020k000004Q0UA');
inv.addError('Record Is Loscked');*/
                }
            }
        }
    }
    
    
    //Variation related changes
    public static void updatePaymentAndRequirementAtVariation(Map<Id,Initiative__c> newInitiative, Map<Id,Initiative__c> oldInitiative){
                system.debug('Inside InitiativeTriggerHandler updatePaymentAndRequirementAtVariation() method');

        Set<Id> variations = new Set<Id>();
        
        for(String initiativeId :newInitiative.keySet()){
            
            if(((newInitiative.get(initiativeId).Start_Date__c != oldInitiative.get(initiativeId).Start_Date__c ||
                 newInitiative.get(initiativeId).End_Date__c != oldInitiative.get(initiativeId).End_Date__c ||
                 newInitiative.get(initiativeId).Initiative_Owner__c != oldInitiative.get(initiativeId).Initiative_Owner__c ||
                 newInitiative.get(initiativeId).Business_Case__c != oldInitiative.get(initiativeId).Business_Case__c ||
                 newInitiative.get(initiativeId).Investment_Area__c != oldInitiative.get(initiativeId).Investment_Area__c ||
                 newInitiative.get(initiativeId).Partner__c != oldInitiative.get(initiativeId).Partner__c ||
                 newInitiative.get(initiativeId).Plan__c != oldInitiative.get(initiativeId).Plan__c ||
                 newInitiative.get(initiativeId).Approved__c != oldInitiative.get(initiativeId).Approved__c ||
                 newInitiative.get(initiativeId).High_Performance__c != oldInitiative.get(initiativeId).High_Performance__c ||
                 newInitiative.get(initiativeId).NZ_Inc__c != oldInitiative.get(initiativeId).NZ_Inc__c ||
                 newInitiative.get(initiativeId).Community__c != oldInitiative.get(initiativeId).Community__c ||
                 newInitiative.get(initiativeId).Description__c != oldInitiative.get(initiativeId).Description__c ||
                 newInitiative.get(initiativeId).Details__c != oldInitiative.get(initiativeId).Details__c ||
                 newInitiative.get(initiativeId).Requested__c != oldInitiative.get(initiativeId).Requested__c ||
                 newInitiative.get(initiativeId).Planned__c != oldInitiative.get(initiativeId).Planned__c ||
                 newInitiative.get(initiativeId).Priority__c != oldInitiative.get(initiativeId).Priority__c ||
                 newInitiative.get(initiativeId).Type__c != oldInitiative.get(initiativeId).Type__c ||
                 newInitiative.get(initiativeId).Expense_Code__c != oldInitiative.get(initiativeId).Expense_Code__c ||
                 newInitiative.get(initiativeId).Activity_ID__c != oldInitiative.get(initiativeId).Activity_ID__c ||
                 newInitiative.get(initiativeId).Project_ID__c != oldInitiative.get(initiativeId).Project_ID__c ||
                 newInitiative.get(initiativeId).Cost_Centre__c != oldInitiative.get(initiativeId).Cost_Centre__c ||
                 newInitiative.get(initiativeId).Time_and_Advice_Planned_Hours__c != oldInitiative.get(initiativeId).Time_and_Advice_Planned_Hours__c ||
                 newInitiative.get(initiativeId).Time_and_Advice_Actual_Hours__c != oldInitiative.get(initiativeId).Time_and_Advice_Actual_Hours__c ||
                 newInitiative.get(initiativeId).CS_Strategic_Priority__c != oldInitiative.get(initiativeId).CS_Strategic_Priority__c ||
                 newInitiative.get(initiativeId).CS_Focus_Area__c != oldInitiative.get(initiativeId).CS_Focus_Area__c ||
                 newInitiative.get(initiativeId).BI_Service_Area__c != oldInitiative.get(initiativeId).BI_Service_Area__c ||
                 newInitiative.get(initiativeId).Partner_Planning_Priority__c != oldInitiative.get(initiativeId).Partner_Planning_Priority__c))){
                     //system.debug('Initiative changed --------------------');
                     if(String.isNotBlank(newInitiative.get(initiativeId).Investment_Schedule_Variation__c)){
                         variations.add(newInitiative.get(initiativeId).Investment_Schedule_Variation__c);
                     }
                 }
        }
        //system.debug('Changed Variations ------------------'+variations);
        
        if(!variations.isEmpty()){
            List<Variation__c> relatedVariations = [SELECT Id,
                                                    Initiatives_Varied__c
                                                    FROM   Variation__c
                                                    WHERE  Id IN: variations
                                                    AND    Is_Active__c = true];
            //system.debug('Related Initiatives ------------------'+relatedVariations);
            if(!relatedVariations.isEmpty()){
                for(Variation__c objVariation : relatedVariations){
                    if(!objVariation.Initiatives_Varied__c){
                        objVariation.Initiatives_Varied__c = true;
                    }
                }
                update relatedVariations;
            }
        }
    }
    //Variation related changes
    public static void linkActiveVariation(List<Initiative__c> initList){
                system.debug('Inside InitiativeTriggerHandler linkActiveVariation() method');

        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            Set<Id> investmentScheduleIds = new Set<Id>();
            
            Map<Id,List<Initiative__c>> investmentScheduleAndInitiatives = new Map<Id,List<Initiative__c>>();
            for(Initiative__c objInitiative : initList){
                investmentScheduleIds.add(objInitiative.Business_Case__c);
            }
            
            // system.debug('investmentScheduleIds--------------------------------'+investmentScheduleIds);
            if(!investmentScheduleIds.isEmpty()){
                Map<Id,Id> investmentAndActiveVariation = new Map<Id, Id>();
                List<Variation__c> updateVariation = new List<Variation__c>();
                for(Variation__c objVariation : [SELECT Id,
                                                 Investment_Schedule__c,
                                                 Initiatives_Added__c,
                                                 Initiatives_Varied__c
                                                 FROM   Variation__c
                                                 WHERE  Is_Active__c = true
                                                 AND    Investment_Schedule__c IN: investmentScheduleIds]){  objVariation.Initiatives_Added__c = true;objVariation.Initiatives_Varied__c = true;updateVariation.add(objVariation);investmentAndActiveVariation.put(objVariation.Investment_Schedule__c,objVariation.Id);
                                                 }
                system.debug('investmentAndActiveVariation--------------------------------'+investmentAndActiveVariation);
                if(!investmentAndActiveVariation.isEmpty()) {
                    
                    for(Initiative__c objInitiative : initList){objInitiative.Investment_Schedule_Variation__c = investmentAndActiveVariation.get(objInitiative.Business_Case__c);
                    }
                    //system.debug('updateVariation--------------------------------'+updateVariation);
                    //insert updateInitiatives;
                    if(!updateVariation.isEmpty()){update updateVariation;
                    }
                }
                
                //While Clone  do not populdate Investment_Schedule_Variation__c and Inv Schedule
                for(Initiative__c objInitiative : initList) {
                    
                    if( true == objInitiative.isClone()) // && String.isBlank(objInitiative.Business_Case__c) && String.isNotBlank(objInitiative.Investment_Schedule_Variation__c)
                    {
                        objInitiative.Investment_Schedule_Variation__c = null;
                        objInitiative.Business_Case__c = null;
                        System.debug('...here');
                    }
                }
            }
        }
    }
    //Variation related changes
    /* public static void updateRecordTypesForRelatedObjects(Map<Id,Initiative__c> newInitiatives, Map<Id,Initiative__c> oldInitiatives){
if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
Set<Id> updatedInititatives = new Set<Id>();
Id readOnlyRecordTypeId = [Select Id,DeveloperName   from RecordType where sobjectType = 'Initiative__c' and DeveloperName = 'RUL_Read_Only_Initiative'].Id;
system.debug('Read Only Record Type --------------------------- '+readOnlyRecordTypeId);
system.debug('Old Map -------------------------'+oldInitiatives);
system.debug('New Map -------------------------'+newInitiatives);
for(String initiativeId : newInitiatives.keySet()){
if(oldInitiatives.containsKey(initiativeId)){
system.debug('Condition --------------------------'+(oldInitiatives.get(initiativeId).RecordTypeId == readOnlyRecordTypeId && newInitiatives.get(initiativeId).RecordTypeId != readOnlyRecordTypeId)+' ----------------------------- '+initiativeId);
system.debug('Old RT ------------------------'+oldInitiatives.get(initiativeId).RecordTypeId);
system.debug('New RT ------------------------'+newInitiatives.get(initiativeId).RecordTypeId);
if(oldInitiatives.get(initiativeId).RecordTypeId == readOnlyRecordTypeId && newInitiatives.get(initiativeId).RecordTypeId != readOnlyRecordTypeId){
updatedInititatives.add(initiativeId);
}
}
}
system.debug('updatedInititatives---------------------------------'+updatedInititatives);
//Make payments editable
if(!updatedInititatives.isEmpty()){
List<Payment__c> payementsToUpdate = [SELECT Id, RUL_Old_RecordType_Id__c, RecordTypeId, Initiative__c FROM Payment__c WHERE Initiative__c IN: updatedInititatives];
List<Requirement__c> requirementsToUpdate = [SELECT Id, RUL_Old_RecordType_Id__c, RecordTypeId, Initiative__c FROM Requirement__c WHERE Initiative__c IN: updatedInititatives];
List<Measure__c> measuresToUpdate = [SELECT Id, RUL_Old_RecordType_Id__c, RecordTypeId, Initiative__c FROM Measure__c WHERE Initiative__c IN: updatedInititatives];

if(!payementsToUpdate.isEmpty()){
for(Payment__c objPayment : payementsToUpdate){
if(String.isNotBlank(objPayment.RUL_Old_RecordType_Id__c)){
objPayment.RecordTypeId = objPayment.RUL_Old_RecordType_Id__c;
}
}
system.debug('Updated Payments ----------------------- '+payementsToUpdate);
if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
update payementsToUpdate;
}
}
//Make Requirements editable
if(!requirementsToUpdate.isEmpty()){
for(Requirement__c objRequirement : requirementsToUpdate){
if(String.isNotBlank(objRequirement.RUL_Old_RecordType_Id__c)){
objRequirement.RecordTypeId = objRequirement.RUL_Old_RecordType_Id__c;
}
}
system.debug('Updated Requirements ----------------------- '+requirementsToUpdate);
if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
update requirementsToUpdate;
}
}
//Make Measures editable
if(!measuresToUpdate.isEmpty()){
for(Measure__c objMeasure : measuresToUpdate){
if(String.isNotBlank(objMeasure.RUL_Old_RecordType_Id__c)){
objMeasure.RecordTypeId = objMeasure.RUL_Old_RecordType_Id__c;
}
}
system.debug('Updated Measures ----------------------- '+measuresToUpdate);
if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
update measuresToUpdate;
}
}
}
}
}*/
    public static void updateOldRecordType(List<Initiative__c> listInitiative){
         system.debug('Inside InitiativeTriggerHandler updateOldRecordType() method');
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            //To have number of SOQL queries executed so far
            for(Initiative__c objInit: listInitiative){
                if(objInit.RecordTypeId != fetchRecordTypeId('RUL_Read_Only_Initiative')){
                    objInit.Old_RecordTypeID__c = objInit.RecordTypeID;
                }
            }
        }
    }
    public static String fetchRecordTypeId (String recordTypeName) {
         system.debug('Inside InitiativeTriggerHandler fetchRecordTypeId() method');
        String recordTypeId =  Schema.SObjectType.Initiative__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();        
        return recordTypeId;
    }
    
    
    public static void closeinvestmentschedule (List<Initiative__c> listInitiative){
        system.debug('Inside InitiativeTriggerHandler closeinvestmentschedule() method');

        Set<Id> businessCaseIdSet = new Set<Id>();
        List<Business_Case__c> investmentListToBeUpdate = new List<Business_Case__c>();

        for(Initiative__c initiativeRecord : listInitiative){
            if(initiativeRecord.Business_Case__c != null){
                businessCaseIdSet.add(initiativeRecord.Business_Case__c);
            }
        }
        List<Business_Case__c> investList = [
            SELECT Id,Status__c,(SELECT Id,Status__c,Business_Case__c FROM Initiatives__r)
            FROM Business_Case__c WHERE Id IN :businessCaseIdSet
        ];
        
        for(Business_Case__c businessCaseRecord : investList){
            Boolean flag = true;
            if(businessCaseRecord.Initiatives__r.size() > 0){
                for(Initiative__c initiativeRecord : businessCaseRecord.Initiatives__r){
                    if(initiativeRecord.Status__c != 'Closed'){
                        flag = false;
                        break;
                    }
                }
            }
            if(flag){
                businessCaseRecord.Status__c = 'Closed';
                investmentListToBeUpdate.add(businessCaseRecord);
            }
        }
        if(investmentListToBeUpdate.size() > 0){
            update investmentListToBeUpdate;
        }
    }
}