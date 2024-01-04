trigger TrgAssessor on Assessor__c (before insert, before delete) {

	if(Trigger.IsBefore) {
		//select all assessment where assessor and app id are a match and delete
		if(Trigger.isDelete)
		AssessorTriggerHandler.deleteOwnedAssessment(Trigger.old);

		if(Trigger.isInsert)
		AssessorTriggerHandler.avoidAssessorDuplicate(Trigger.new);
	}
}