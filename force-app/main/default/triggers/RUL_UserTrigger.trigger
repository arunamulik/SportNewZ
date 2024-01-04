trigger RUL_UserTrigger on User (before insert, before update, after insert, after update) {
    RUL_UserTriggerHandler objClass = new RUL_UserTriggerHandler();
    if(trigger.isBefore) {
        if(trigger.isInsert){
            objClass.beforeInsert(trigger.new);
        }
        if(trigger.isUpdate){
            objClass.beforeUpdate(trigger.newMap, trigger.oldMap);
        }
    }
    
    if(trigger.isAfter) {
        if(trigger.isInsert) {
            objClass.afterInsertOfUser(trigger.new);
        }
        
        if(trigger.isUpdate) {
            objClass.afterUpdateOfUser(trigger.new, trigger.oldMap);
        }
    }
}