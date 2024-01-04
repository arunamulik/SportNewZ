public with sharing class AssessorTriggerHandler {
	public static void deleteOwnedAssessment(List<Assessor__c> assList) {
		Set<Id> appRoundIdSet = new Set<Id>();
		Set<Id> assessorIdSet = new Set<Id>();
		List<Assessment__c> assessmentDeleteList = new List<Assessment__c>();
		for(Assessor__c ass : assList) {
			appRoundIdSet.add(ass.Application_Round__c);
			assessorIdSet.add(ass.Assessor__c);
		}
		List<Assessment__c> assessmentList = [Select Id, Assessor__c, Application__r.Application_Round__c From Assessment__c Where Assessor__c =: assessorIdSet];
		
		if(assessmentList.size() > 0) {
				for(Assessment__c assessment : assessmentList) {
					if(appRoundIdSet.contains(assessment.Application__r.Application_Round__c)) {
						assessmentDeleteList.add(assessment);
					}
				}
				
			if(assessmentDeleteList.size() > 0)
				delete assessmentDeleteList;	
		}	
	}
	
	public static void avoidAssessorDuplicate(List<Assessor__c> assList) {
		Set<String> assAppRoundIdSet = new Set<String>();
		Set<Id> assessorIdSet = new Set<Id>();
		List<Assessment__c> assessmentDoubleList = new List<Assessment__c>();
		for(Assessor__c ass : assList) {
			assessorIdSet.add(ass.Assessor__c);
		}

		List<Assessment__c> assessmentList = [Select Id, Assessor__c, Application__r.Application_Round__c From Assessment__c Where Assessor__c =: assessorIdSet];
		if(assessmentList.size() > 0) {
			for(Assessment__c assessment : assessmentList) {
				for(Assessor__c ass : assList) {
					if(ass.Application_Round__c == assessment.Application__r.Application_Round__c)
						ass.Assessor__c.addError('The selected user is already an existing assessor for this application round');
				}
			}
		}	
	}
	

}