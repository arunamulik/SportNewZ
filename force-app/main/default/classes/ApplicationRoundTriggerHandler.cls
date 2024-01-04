public with sharing class ApplicationRoundTriggerHandler {
	public static void createAssessmentRecords(List<Application_Round__c> appRoundList) {
		Set<Id> appRoundIds = new Set<Id>();
		List<Application_Round__c> applicationRoundUpdateList = new List<Application_Round__c>();
		List<Assessment__c> assessmentInsertList = new List<Assessment__c>();
		List<Assessment_Score__c> assessmentScoreInsertList = new List<Assessment_Score__c>();
		for(Application_Round__c appRound :appRoundList) {
			if(appRound.Create_Assessments__c == true)
				appRoundIds.add(appRound.id);
		}
		List<Application_Round__c> appRoundRelatedList = [Select Id, (Select Id From Assessment_Criteria__r), (Select id From Applications__r), 
													(Select Id, Assessor__c From Assessors__r) From Application_Round__c where id=:appRoundIds];
		
		if(appRoundRelatedList.size() > 0) {
			//Assessor * Applications
			for(Application_Round__c appRound : appRoundRelatedList) {
				if(appRound.Assessors__r.size() > 0  && appRound.Applications__r.size() > 0) {
					for(Assessor__c ass : appRound.Assessors__r) {						
						for(Application__c app : appRound.Applications__r){
							Assessment__c assessment = new Assessment__c();
							assessment.Application__c = app.id;
							assessment.Assessor__c = ass.Assessor__c;
							assessment.AssessorApplicationId__c = ass.Assessor__c + '' + app.id;	
							assessmentInsertList.add(assessment);
						}	
					}
				}
			}
			if(assessmentInsertList.size() > 0) 
				upsert assessmentInsertList AssessorApplicationId__c; 
			//Assessment Criteria * Assessment
			for(Application_Round__c appRound : appRoundRelatedList) {
				if(appRound.Assessment_Criteria__r.size() > 0) {
					for(Assessment_Criteria__c assCriteria : appRound.Assessment_Criteria__r){
						for(Integer i=0; i < assessmentInsertList.size(); i ++){
							Assessment_Score__c assessmentScore = new Assessment_Score__c();
							assessmentScore.Assessment__c = assessmentInsertList.get(i).id;
							assessmentScore.Assessment_Criteria__c = assCriteria.id;
							assessmentScore.AssessmentCriteriaAssessment__c = assCriteria.id + '' + assessmentInsertList.get(i).id;
							assessmentScoreInsertList.add(assessmentScore);
						}	
					}
					//Reupdate Application Round List
					Application_Round__c applicationRound = new Application_Round__c();
					applicationRound.id = appRound.id;
					applicationRound.Create_Assessments__c = false;
					applicationRoundUpdateList.add(applicationRound);
				}
			}	
			if(assessmentScoreInsertList.size() > 0)
				upsert assessmentScoreInsertList AssessmentCriteriaAssessment__c;
				
			if(applicationRoundUpdateList.size() > 0)
				update applicationRoundUpdateList;	
		}	

			
	}
}