trigger RUL_ProgramTrigger on Programme__c (after insert, after update, after delete) {
	RUL_ProgramTriggerHandler objClass = new RUL_ProgramTriggerHandler();
	if(trigger.isAfter){
		if(trigger.isInsert){
			objClass.afterInsert(trigger.new);
		}
		if(trigger.isUpdate){
			objClass.afterUpdate(trigger.newmap, trigger.oldmap);
		}
		if(trigger.isDelete){
			objClass.afterInsert(trigger.old);
		}
	}
}