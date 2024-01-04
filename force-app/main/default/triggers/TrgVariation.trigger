/*------------------------------------------------------------
Author:         Ameya Wadke
Company:        Eternus Solutions Pvt. Ltd
Description:    Trigger on Variation__c
Test Class:     

History
25-05-2018      Ameya Created
------------------------------------------------------------*/
trigger TrgVariation on Variation__c (after insert, before insert, before update) {
    public class MyCatchException extends Exception {}

    system.debug('@Start--TrgVariation CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
    system.debug('RecursionHandler.getRunTimes  --------V---------------'+RecursionHandler.getRunTimes()+'-----Before--------------'+Trigger.isBefore+'---------Insert-------'+Trigger.isInsert+'----------------'  );
    if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
         if(RecursionHandler.TrgVariationBypassAfterUpdate && RecursionHandler.TrgVariationBypassBeforeInsert){
            return ;
        }
       
        //Trigger depth check
        if(RecursionHandler.getRunTimes() < 16){
            system.debug('RecursionHandler.TrgVariationBypassAfterUpdate ---------------------'+RecursionHandler.TrgVariationBypassAfterUpdate);
            if(Trigger.isInsert && Trigger.isAfter){
                if(!RecursionHandler.TrgVariationBypassAfterUpdate){
                    //system.debug('@1--TrgVariation CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
                    system.debug('===Inside TrgVariation===');
                    //Method to link Initiatives and mark other sibling variation to Inactive
                    
                    //if there are related investment schedule then method will update its status to 'Being Varied'
                    //Entity : Business_Case__c--------------Trigger Business case (before & after update)
                     try {
                           VariationTriggerHandler.makeOtherVariationsInActive(trigger.new);
                            if (VariationTriggerHandler.getCatch) {
                                throw new MyCatchException('First exception');
                            }
                        } catch (Exception e) {
                            PaymentTriggerhandler.createLog(e, 'makeOtherVariationsInActive');
                        }
                    try{
                    		VariationTriggerHandler.updateInitiativeRelatedObjects(trigger.newMap);
                            if (VariationTriggerHandler.getCatch) {
                                throw new MyCatchException('First exception');
                            }
                    }catch (Exception e) {
                            PaymentTriggerhandler.createLog(e, 'updateInitiativeRelatedObjects');
                        }
                }
            }else if(Trigger.isUpdate && Trigger.isBefore){
                system.debug('Inside Before insert');
                if(!RecursionHandler.TrgVariationBypassBeforeInsert){
                    VariationTriggerHandler.markCheckboxesOnUpdate(trigger.new);
                    RecursionHandler.TrgVariationBypassBeforeInsert = true;
                }
            }
        }
    }
    system.debug('@End--TrgVariation CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
    system.debug('##TrgVariation'+RecursionHandler.executionCount);
}