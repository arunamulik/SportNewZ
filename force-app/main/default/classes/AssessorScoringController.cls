public with sharing class AssessorScoringController {
	public List<ScoringWrapper> scoringWrapperList {get;set;}
    private String retURL;
	public AssessorScoringController() {
		scoringWrapperList = new List<ScoringWrapper>();
        List<Assessment__c> assessmentList = new List<Assessment__c>();
        Map<Id, Application__c> applicationMap = new Map<Id, Application__c>(); 
        Set<Id> appIds = new Set<Id>();
        Id userId = UserInfo.getUserId();

        if(ApexPages.currentPage().getParameters().get('retURL') != null) {
            retURL = ApexPages.currentPage().getParameters().get('retURL');
        }
        if(ApexPages.currentPage().getParameters().get('appId') != null) {
            Id appId = string.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('appId'));
            appIds.add(appId);

        } 
		if(ApexPages.currentPage().getParameters().get('appRoundId') != null) {
            //Get all the application from the application
            String appRoundId = string.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('appRoundId'));
			applicationMap = new Map<Id, Application__c>([Select Id, Application_Round__r.OwnerId, Final_Comments__c,                                                                                 
                                                                    Decision__c From Application__c where Application_Round__c=:approundId]);

            if(applicationMap.size() > 0)
                appIds = applicationMap.keySet();
        }  
         String queryString = 'Select Id, Application__c, Application__r.Applicant__c,' +
                      ' Application__r.Sharepoint_URL__c, Comments__c, Total_Weighted_Score__c, Assessor__c,' +
                      ' (Select Id, Assessment_Criteria__r.Name, Score__c, Assessment_Criteria__r.Weighting__c, Weighted_Score__c From Assessment_Scores__r order by Assessment_Criteria__r.Name ASC ) ' +
                      ' From Assessment__c where Application__c=:appIds'; 
        queryString  += ' and Assessor__c=:userId order by Name ASC';    

        assessmentList = Database.query(queryString);

        system.debug('### assessmentList =>' + assessmentList.size());
        for(Assessment__c ass: assessmentList) {
            ScoringWrapper scoring = new ScoringWrapper();
            scoring.assessment = ass;
            scoring.assessmentScoreList = ass.Assessment_Scores__r;
            scoringWrapperList.add(scoring);
        }
	} 

    public PageReference saveBtn() {
        SavePoint sp = Database.setSavePoint();
        List<Assessment__c> assessmentUpdateList = new List<Assessment__c>();
        List<Assessment_Score__c> assessmentScoreUpdateList = new List<Assessment_Score__c>(); 
        for(ScoringWrapper swrap : scoringWrapperList) {
            assessmentUpdateList.add(swrap.assessment);
            assessmentScoreUpdateList.addAll(swrap.assessmentScoreList);
        }
        try {
            update assessmentUpdateList;
            try {
                update assessmentScoreUpdateList;
                PageReference pageRef = null;
                if(retURL != null)
                    pageRef= new PageReference(retURL);
                return pageRef;
            } catch (Exception err) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error on Saving Assessor Scores. ' + err.getMessage() + ' ' + err.getLineNumber());
                ApexPages.addMessage(msg);
                return null;
            }
        } catch(Exception err) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error on Saving Assessor Scores. ' + err.getMessage() + ' ' + err.getLineNumber());
            ApexPages.addMessage(msg);
            return null;
        }
        return null;
    }

    public PageReference cancelBtn() {
         PageReference pageRef = null;
        if(retURL != null)
            pageRef= new PageReference(retURL);
        return pageRef;
    }

	public class ScoringWrapper {
		public List<Assessment_Score__c> assessmentScoreList {get;set;}
		public Assessment__c assessment {get;set;}
		public ScoringWrapper() {
			assessmentScoreList = new List<Assessment_Score__c>();
			assessment = new Assessment__c();
		}
	}

}