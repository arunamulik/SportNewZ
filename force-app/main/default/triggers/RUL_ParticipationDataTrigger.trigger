/*---------------------------------------------------------------------------------------------------------------------------
Description: This Trigger is used to test functionality of RUL_ParticipationDataTrigger

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 18-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of
                                                           RUL_ParticipationDataTrigger
   ==========================================================================================================================
*/
trigger RUL_ParticipationDataTrigger on Participation_Data__c (after delete, after insert, after update) {
    if(trigger.isAfter){
        RUL_ParticipationDataTriggerHandler objClass = new RUL_ParticipationDataTriggerHandler();
        if(trigger.isInsert){
            objClass.afterInsert(trigger.new);
        }
        if(trigger.isUpdate){
            objClass.afterUpdate(trigger.newMap, trigger.oldMap);
        }
        if(trigger.isDelete){
            objClass.afterInsert(trigger.old);
        }
    }
}