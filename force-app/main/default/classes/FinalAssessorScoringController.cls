public with sharing class FinalAssessorScoringController {
    public List<FinalScoringWrapper> finalScoringWrapperList {get;set;}
    public List<Assessment_Score__c> assessmentScoringHeaderList {get;set;} //For VF table header
    public Map<Id,List<Assessment_Score__c>> assessmentScoreMap {get;set;}
    
    //For weighting list
    public String assessmentCriteriaFlag {get;set;}
    public List<Decimal> weightingList {get;set;}

    private String appRoundId;
	public FinalAssessorScoringController() {
        finalScoringWrapperList = new List<FinalScoringWrapper>();
        assessmentScoreMap = new Map<Id,List<Assessment_Score__c>>();
        Map<Id, Application__c> applicationMap = new Map<Id, Application__c>(); 
        assessmentScoringHeaderList =  new List<Assessment_Score__c>();
        
        assessmentCriteriaFlag = null;
        weightingList = new List<Decimal>();
        
        Id userId = UserInfo.getUserId();


		if(ApexPages.currentPage().getParameters().get('appRoundId') != null) {
            //Get all the application from the application
            appRoundId = string.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('appRoundId'));
			//get the owner of the account
			String finalDecisionStr = ApexPages.currentPage().getParameters().get('FinalDecision');
            if(finalDecisionStr == 'true') {
                applicationMap = new Map<Id, Application__c>([Select Id, Applicant__c, Application_Round__r.OwnerId, Final_Comments__c, Moderated_Scores__c,
                                                        Decision__c, Sharepoint_URL__c, Name, Investment__c,
                                                        (Select Id, Name, Assessor__r.Name, Total_Weighted_Score__c, Real_Total_Weighted_Score__c, Comments__c,
                                                         Application__r.Applicant__c From Assessments__r) From Application__c where Application_Round__c=:approundId and Application_Round__r.OwnerId=:userId]);
            }
        }  

        if(applicationMap.size() > 0) {
            //get the assessments ids to get the assessment criteria score
            Map<Id,Assessment__c> assessmentMap = new Map<Id,Assessment__c> ();
            for(Application__c app: applicationMap.values()) {
                if(app.Assessments__r.size() > 0) {
                    for(Assessment__c ass : app.Assessments__r) {
                        assessmentMap.put(ass.Id, ass);
                    }
                }
            }
            //todo: get the asssessment criteria scores 
            if(assessmentMap.size() > 0) {
                List<Assessment_Score__c> assessmentScoreList = [Select Id, AssessmentCriteriaAssessment__c, Assessment__c, Assessment_Criteria__r.Name, Assessment_Criteria__r.Weighting__c, Score__c, Weighted_Score__c 
                                                                From Assessment_Score__c where Assessment__c=:assessmentMap.keyset() order by Assessment_Criteria__r.Name ASC];
                if(assessmentScoreList.size() > 0) {

                    //put assessment in a map assessmentId and list of scores
                    //Map<Id,List<Assessment_Score__c>> assessmentScoreMap = new Map<Id,List<Assessment_Score__c>> ();
                    for(Assessment_Score__c assScore : assessmentScoreList) {
                        if(!assessmentScoreMap.containsKey(assScore.Assessment__c)) {
                            List<Assessment_Score__c> assScList = new List<Assessment_Score__c>();
                            assScList.add(assScore);
                            assessmentScoreMap.put(assScore.Assessment__c, assScList);
                        } else {
                            assessmentScoreMap.get(assScore.Assessment__c).add(assScore);
                        }
                        //put weighting in a list
                        if(assessmentCriteriaFlag != assScore.Assessment_Criteria__r.Name) {
                        	assessmentCriteriaFlag = assScore.Assessment_Criteria__r.Name;
                        	weightingList.add(assScore.Assessment_Criteria__r.Weighting__c);
                        }
                    }

                    //build the final scoring wrapper
                    if(assessmentScoreMap.size() > 0) {
                         for(Application__c app: applicationMap.values()) {
                            FinalScoringWrapper finalScoring = new FinalScoringWrapper();
                            finalScoring.application = app;
                            List<Assessment__c> assList = new List<Assessment__c>();
                            for(Assessment__c ass : assessmentMap.values()) {
                                if(ass.Application__c == app.id) {
                                    assList.add(ass);
                                    finalScoring.averageWeightedScore += ass.Real_Total_Weighted_Score__c;
	                                assessmentScoringHeaderList = assessmentScoreMap.get(ass.id);
	                                //initialise the list of average weighted scores
	                                if(finalScoring.averageAssessmentScoreList.size() == 0)
	                                	for(Integer i = 0; i < assessmentScoringHeaderList.size(); i++)
	                                		finalScoring.averageAssessmentScoreList.add(0);
	                                //get average weighted scores
	                                for(Integer i = 0; i < assessmentScoringHeaderList.size(); i++) {
	                                	if(assessmentScoringHeaderList.get(i).Score__c != null && assessmentScoringHeaderList.get(i).Score__c != 0) {
	                                		Decimal temp = finalScoring.averageAssessmentScoreList.get(i) + assessmentScoringHeaderList.get(i).Score__c;
	                                		finalScoring.averageAssessmentScoreList.set(i, temp);
	                                	}
	                                }
                                }
                            }
                            finalScoring.assessmentList = assList;
                            for(Integer i = 0; i < finalScoring.averageAssessmentScoreList.size(); i++) {
                            	Decimal temp = finalScoring.averageAssessmentScoreList.get(i);
                            	if(temp != 0) {
                            		temp /= assList.size();
                            		finalScoring.averageAssessmentScoreList.set(i, temp.setScale(2));
                            	}
                            }
                            finalScoring.averageWeightedScore = (finalScoring.averageWeightedScore/assList.size()).setScale(2);
                            //get moderated scores
                            if(finalScoring.application.Moderated_Scores__c != null && finalScoring.application.Moderated_Scores__c != '') {
                            	List<String> strList = finalScoring.application.Moderated_Scores__c.split(';');
                            	while(strList.size() < assessmentScoringHeaderList.size())
                            		strList.add('');
                            	for(Integer i = 0; i < strList.size(); i++) {
                            		Decimal score, weightedScore;
                            		if(strList.get(i) == null || strList.get(i) == '') {
                            			score = 0;
                            			weightedScore = 0;
                            		} else {
                            			score = Decimal.valueOf(strList.get(i));
                            			weightedScore = weightingList.get(i)*score/100;
                            		}
                            		finalScoring.moderatedScoreList.add(new ModeratedScoreWrapper(score.setScale(2), weightedScore.setScale(2)));
                            	}
                            } else {
                            	for(Integer i = 0; i < assessmentScoringHeaderList.size(); i++)
                            		finalScoring.moderatedScoreList.add(new ModeratedScoreWrapper(0, 0));
                            }
                            //get moderated scores for the last column
                            for(ModeratedScoreWrapper ms : finalScoring.moderatedScoreList)
                            	finalScoring.averageWeightedModeratedScore += ms.weightedModeratedScore;
                            finalScoring.averageWeightedModeratedScore = finalScoring.averageWeightedModeratedScore.setScale(2);
                            
                            finalScoringWrapperList.add(finalScoring);
                        }
                    }

                }                
            }
        }
}

    public PageReference saveBtn() {
        SavePoint sp = Database.setSavePoint();
        List<Application__c> applicationUpdateList = new List<Application__c>();

        for(FinalScoringWrapper fscore : finalScoringWrapperList) {
            //set moderated scores
            fscore.application.Moderated_Scores__c = '';
            for(ModeratedScoreWrapper scoreWrapper : fscore.moderatedScoreList)
            	fscore.application.Moderated_Scores__c += (';' + scoreWrapper.moderatedScore);
            fscore.application.Moderated_Scores__c = fscore.application.Moderated_Scores__c.substring(1);
            applicationUpdateList.add(fscore.application);
        }
        try {
            update applicationUpdateList;
            PageReference pageRef = new PageReference('/' + appRoundId);
            return pageRef;
        } catch(Exception err) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error on Saving. ' + err.getMessage() + ' ' + err.getLineNumber());
            ApexPages.addMessage(msg);
            return null;
        }
        return null;
    }

    public PageReference cancelBtn() {
        PageReference pageRef = new PageReference('/' + appRoundId);
        return pageRef;
    }

	//workaround the problem of apex:inputText not working inside nested apex:repeat tags
	public class ModeratedScoreWrapper {
		public Decimal moderatedScore {get;set;}
		public Decimal weightedModeratedScore {get;set;}
		public ModeratedScoreWrapper(Decimal score, Decimal weightedScore) {
			this.moderatedScore = score;
			this.weightedModeratedScore = weightedScore;
		}
	}

    public class FinalScoringWrapper {
        public Application__c application {get;set;}
        public List<Assessment__c> assessmentList {get;set;}
        public List<Decimal> averageAssessmentScoreList {get;set;}
        public Decimal averageWeightedScore {get;set;}
        public Decimal averageWeightedModeratedScore {get;set;}
        public List<ModeratedScoreWrapper> moderatedScoreList {get;set;}
        public FinalScoringWrapper() {
            application = new Application__c();
            assessmentList = new List<Assessment__c>();
            averageAssessmentScoreList = new List<Decimal>();
            moderatedScoreList = new List<ModeratedScoreWrapper>();
            averageWeightedScore = 0;
            averageWeightedModeratedScore = 0;
        }
    }    
}