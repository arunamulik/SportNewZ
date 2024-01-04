trigger TrgRequirement on Requirement__c (before insert, before update, after insert, after update, after delete, after undelete) {
    //system.debug('RecursionHandler.getRunTimes  --------R---------------'+RecursionHandler.getRunTimes()+'-----Before--------------'+Trigger.isBefore+'---------Insert-------'+Trigger.isInsert+'----------------'  );
    if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
    
        
    //IsVariationInititated__c IsVariation = IsVariationInititated__c.getInstance(UserInfo.getProfileId());
         //added on 10/08/2018 static variable used to keep it as per user transaction and not org.
        Boolean isVariationInitiatied = RecursionHandler.TrgVariationBypass;
        /*if(IsVariation != null){
            // system.debug('CS Value ----------------------'+IsVariation.Variation_Inititated__c); 
             isVariationInitiatied = IsVariation.Variation_Inititated__c;
        }*/
        
        if(RecursionHandler.getRunTimes() < 16 && !isVariationInitiatied){
            
            
            if(Trigger.IsBefore && (Trigger.IsInsert || Trigger.isUpdate)) {
                RequirementTriggerHandler.updatePlan(Trigger.new);
                 RequirementTriggerHandler.updateOldRecordType(Trigger.new);
                RequirementTriggerHandler.updateStatus(Trigger.new,Trigger.oldMap);
                /*for(Requirement__c record: Trigger.new) {
                    Integer count;
                    if(record.Notes__c != null && (count = record.Notes__c
                        .normalizeSpace() // Don't count duplicate spaces
                        .stripHtmlTags() // Remove all HTML
                        .replaceAll('\\S','') // Remove all non-spaces
                        .length()) > 250) { 
                        record.Notes__c.addError('Please limit your input to 250 words or less. You currently have '+count+' words.');
                    }
                }*/
            }
            
            if(Trigger.isAfter) {
                if(Trigger.IsInsert || Trigger.isUndelete) 
                    RequirementTriggerHandler.processRequirements(Trigger.new);
                if(Trigger.isDelete) 
                    RequirementTriggerHandler.processRequirements(Trigger.old); //pass old id to get partner
                //Payment initiative? or payment date is updated
                if(Trigger.isUpdate) {
                    RequirementTriggerHandler.updateVariation(Trigger.newMap, Trigger.oldMap);
                    RequirementTriggerHandler.updatedRequirements(Trigger.oldMap, Trigger.new);
                }
            }
            RecursionHandler.setRunTimes();
        }

    //if (Trigger.isAfter && (Trigger.IsInsert || Trigger.isUpdate || Trigger.isUndelete)){       
    //   RequirementTriggerHandler.checkRequirements(Trigger.new);
    //}
    //if (Trigger.isAfter && Trigger.isDelete){       
    //   RequirementTriggerHandler.checkRequirements(Trigger.old);
    //}
    }
}