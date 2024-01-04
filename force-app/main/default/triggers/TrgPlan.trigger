trigger TrgPlan on Plan__c (after update) {
	
	if (Trigger.isAfter && Trigger.isUpdate){
		PlanTriggerhandler.UpdateInitiativeFields(Trigger.New);
	}
  
}