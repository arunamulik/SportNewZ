trigger TrgInitiative on Initiative__c (before insert, before update, After update, After insert,After delete, After undelete) {
    //system.debug('@Start--TrgInitiative CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
    //system.debug('RecursionHandler.getRunTimes  --------Init---------------'+RecursionHandler.getRunTimes()+'-----Before--------------'+Trigger.isBefore+'---------Insert-------'+Trigger.isInsert+'----------------' );
    //IsVariationInititated__c IsVariation = IsVariationInititated__c.getInstance(UserInfo.getProfileId());
    //added on 10/08/2018 static variable used to keep it as per user transaction and not org. 
    Boolean isVariationInitiatied = RecursionHandler.TrgVariationBypass;
    /*if(IsVariation != null){
        // system.debug('CS Value ----------------------'+IsVariation.Variation_Inititated__c); 
         isVariationInitiatied = IsVariation.Variation_Inititated__c;
    }*/
    system.debug('----------Inside Trigger ----------------');
    
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        
         /*Id investmentId;
    Boolean flag=false;
    List<Initiative__c> initiativeList=new List<Initiative__c>();
    List<Business_Case__c> investmentList=new List<Business_Case__c>();
    List<Business_Case__c> investmentListToBeUpdate=new List<Business_Case__c>();
    
    //On update record
    for(Initiative__c intt:Trigger.new){
        //Checking if status is closed for initiative
        if(intt.Status__c=='Closed' || intt.End_Date__c<Date.Today())
        {   //if status is closed, taking investment id from the initiative record
            investmentId=intt.Business_Case__c;
            
            //getting all the initiative related to the investmentId
            initiativeList=[select Id,Status__c from Initiative__c where Business_Case__c=:investmentId];
            
            //checking, if all the initiative are closed or not 
            for(Initiative__c i:initiativeList)
            {
                if(i.Status__c!='Closed')
                {
                    //if initiative is not closed than setting flag to true
                    flag=true;
                }
            }
            //checking, if all the initiative are close 
            if(flag!=True)
            {   //getting the investment schedule record on which we have perform status update 
                investmentList=[select Id,Status__c from Business_Case__c where Id=:investmentId];
                
                //setting status as closed
                for(Business_Case__c b:investmentList)
                {
                    b.Status__c='Closed';
                    investmentListToBeUpdate.add(b);
                }
                //updating the record
                update investmentListToBeUpdate;
            }
        }
    }*/
        
        
        
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit) && !isVariationInitiatied){
        if(RecursionHandler.getRunTimes() < 16){
            //system.debug('Is Before -----------T/F---------'+RecursionHandler.TrgInitiativeBypassBefore);
            //system.debug('Is After -----------T/F---------'+RecursionHandler.TrgInitiativeBypassAfter);
           
            if(RecursionHandler.TrgInitiativeBypassBefore && RecursionHandler.TrgInitiativeBypassAfter && RecursionHandler.updateInitiative > 1 ){
              
              return;
             }else{
                Skip_Trigger__c isSkipTrigger = Skip_Trigger__c.getInstance('skipped');
                //system.debug('isSkipTrigger.is_Skipped__c ######## '+isSkipTrigger.is_Skipped__c);
                if (isSkipTrigger<>NULL && !isSkipTrigger.is_Skipped__c){
                 // system.debug('Skip Trigger false inside TrgInitiative >>>>>>>>>>.... ');
                      if(!RecursionHandler.TrgInitiativeBypassBefore){
                         
                              //System.debug('::Before::');
                              Boolean isInsert = Trigger.IsInsert || Trigger.IsUpdate;
                              InitiativeTriggerHandler.updatePartner(Trigger.new,isInsert);
                              InitiativeTriggerHandler.updateOldRecordType(Trigger.new);
                              RecursionHandler.TrgInitiativeBypassBefore = true;
                          }
                }
             }
        }
        }
    }
    
    
    
    if(Trigger.isBefore && Trigger.isInsert)
    {
       /* Set<Id> planIds = new Set<Id>();
        for(Initiative__c init: trigger.new){       
            planIds.add(init.Plan__c);
        }
        
        Map<Id, Plan__c> planMap = new Map<Id, Plan__c>([Select Id, Partner__c from Plan__c where id in: planIds]);
        
        for(Initiative__c init: trigger.new){
            
            if(planMap.get(init.Plan__c).Partner__c != null)
                init.Partner__c = planMap.get(init.Plan__c).Partner__c;
            
        }*/
        
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit) && !isVariationInitiatied){
        if(RecursionHandler.getRunTimes() < 16){
            //system.debug('Is Before -----------T/F---------'+RecursionHandler.TrgInitiativeBypassBefore);
            //system.debug('Is After -----------T/F---------'+RecursionHandler.TrgInitiativeBypassAfter);
           
            if(RecursionHandler.TrgInitiativeBypassBefore && RecursionHandler.TrgInitiativeBypassAfter && RecursionHandler.updateInitiative > 1 ){
              
              return;
             }else{
                Skip_Trigger__c isSkipTrigger = Skip_Trigger__c.getInstance('skipped');
                //system.debug('isSkipTrigger.is_Skipped__c ######## '+isSkipTrigger.is_Skipped__c);
                if (isSkipTrigger<>NULL && !isSkipTrigger.is_Skipped__c){
                 // system.debug('Skip Trigger false inside TrgInitiative >>>>>>>>>>.... ');
                      if(!RecursionHandler.TrgInitiativeBypassBefore){
                          /*if(Trigger.IsBefore && (Trigger.IsInsert || Trigger.isUpdate)) { original trigger block
                              //System.debug('::Before::');
                              Boolean isInsert = Trigger.IsInsert || Trigger.IsUpdate;
                              InitiativeTriggerHandler.updatePartner(Trigger.new,isInsert);
                              InitiativeTriggerHandler.updateOldRecordType(Trigger.new);
                              RecursionHandler.TrgInitiativeBypassBefore = true;
                          }*/
                          
                          
                          if(Trigger.IsBefore && Trigger.IsInsert ) {
                              //System.debug('::Before::');
                              Boolean isInsert = Trigger.IsInsert || Trigger.IsUpdate;
                              InitiativeTriggerHandler.updatePartner(Trigger.new,isInsert);
                              InitiativeTriggerHandler.updateOldRecordType(Trigger.new);
                              RecursionHandler.TrgInitiativeBypassBefore = true;
                          }
                      }
                }
             }
        }
        }
    }
    
    
    
    
    
    if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit) && !isVariationInitiatied){System.debug('If 1');
        if(RecursionHandler.getRunTimes() < 16){
            //system.debug('Is Before -----------T/F---------'+RecursionHandler.TrgInitiativeBypassBefore);
            //system.debug('Is After -----------T/F---------'+RecursionHandler.TrgInitiativeBypassAfter);
           System.debug('If 2');
            if(RecursionHandler.TrgInitiativeBypassBefore && RecursionHandler.TrgInitiativeBypassAfter && RecursionHandler.updateInitiative > 1 ){
              System.debug('If 3');
              return;
             }else{
                 System.debug('After else');
                Skip_Trigger__c isSkipTrigger = Skip_Trigger__c.getInstance('skipped');
                 system.debug('isSkipTrigger.is_Skipped__c ######## '+isSkipTrigger);
                //system.debug('isSkipTrigger.is_Skipped__c ######## '+isSkipTrigger.is_Skipped__c);
                if (isSkipTrigger<>NULL && !isSkipTrigger.is_Skipped__c){System.debug('If 4');
                 // system.debug('Skip Trigger false inside TrgInitiative >>>>>>>>>>.... ');
                     /* if(!RecursionHandler.TrgInitiativeBypassBefore){
                          if(Trigger.IsBefore && (Trigger.IsInsert || Trigger.isUpdate)) { original trigger block
                              //System.debug('::Before::');
                              Boolean isInsert = Trigger.IsInsert || Trigger.IsUpdate;
                              InitiativeTriggerHandler.updatePartner(Trigger.new,isInsert);
                              InitiativeTriggerHandler.updateOldRecordType(Trigger.new);
                              RecursionHandler.TrgInitiativeBypassBefore = true;
                          }
                          
                          
                         
                      }*/
                     // system.debug('RecursionHandler.updateInitiative ------------------'+RecursionHandler.updateInitiative);
                     // system.debug('RecursionHandler.TrgInitiativeBypassAfter ------------------'+RecursionHandler.TrgInitiativeBypassAfter);
                      if(!RecursionHandler.TrgInitiativeBypassAfter && RecursionHandler.updateInitiative < 2){
                          system.debug('Inside update ----------------');
                          if (Trigger.isAfter && Trigger.isUpdate){
                             system.debug('----------Inside After update ----------------');
                              //call for sse-90 trigger
                              initiativeTriggerHandler.closeinvestmentschedule(Trigger.new);
                              
                              //system.debug('----------Inside After update ----------------');
                                //System.debug('::After::');
                                if(RecursionHandler.updateInitiative == 0){
                                    initiativeTriggerHandler.updateChildPaymentNRequirement(Trigger.new,Trigger.old);
                                    initiativeTriggerHandler.updateBusinessCaseAmount(Trigger.New, Trigger.old);
                                    //RUL functionality
                                    system.debug('Update------------------------- ');
                                    //initiativeTriggerHandler.updateRecordTypesForRelatedObjects(Trigger.newMap,Trigger.oldMap);
                                }
                                initiativeTriggerHandler.updatePaymentAndRequirementAtVariation(Trigger.newMap,Trigger.oldMap);
                                RecursionHandler.TrgInitiativeBypassAfter = true;
                          }
                      }
                }
                RecursionHandler.setRunTimes();
                //system.debug('@End--TrgInitiative CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
             }
        }else{
            //system.debug('@End--TrgInitiative CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
            return ;
        }
    }
    //system.debug('@End--TrgInitiative CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
}