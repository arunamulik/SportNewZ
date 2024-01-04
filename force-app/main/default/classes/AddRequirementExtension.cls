public with sharing class AddRequirementExtension {
	private String retUrl;
	private Id recTypeId;
	private Id accountId;
	private Id initiativeId;
	public List<RequirementWrapper> requirementList {get;set;}
	public List<Requirement_Template__c> requirementTemplateList {get{
		if(requirementTemplateList == null){
			requirementTemplateList = [Select Id, Name, Description__c From Requirement_Template__c Order By Name];
		}
		return requirementTemplateList;
	}set;}
	public AddRequirementExtension(ApexPages.StandardController controller) {
		requirementList = new List<RequirementWrapper>();
		List<RecordType> recordTypeList = new List<RecordType>([Select Id, Name From RecordType Where SObjectType='Requirement__c']);
		Map<String, RecordType> recordTypeMap = new Map<String, RecordType>();
		if(recordTypeList.size() > 0) {
			for(RecordType rt : recordTypeList) {
				recordTypeMap.put(rt.Name, rt);
			}
		}
		/*
		// Kahiwi Fixes - commented out code related to 'Organisation Requirement' record type
		if(ApexPages.currentPage().getParameters().get('accountId') != null) {
			accountId = ApexPages.currentPage().getParameters().get('accountId');
			recTypeId = recordTypeMap.get('Organisation Requirement').Id;
		}
		*/
		if(ApexPages.currentPage().getParameters().get('initiativeId') != null) {
			initiativeId = ApexPages.currentPage().getParameters().get('initiativeId');
			recTypeId = recordTypeMap.get('Initiative Requirement').Id;
		}
		if(ApexPages.currentPage().getParameters().get('retUrl') != null) {
			retUrl = ApexPages.currentPage().getParameters().get('retUrl');
		}
		if(requirementTemplateList.size() > 0) {
			for(Requirement_Template__c reqT : requirementTemplateList) {
				RequirementWrapper reqWrapper = new RequirementWrapper();
				reqWrapper.requirement.Name = reqT.Name;
				reqWrapper.requirement.Description__c = reqT.Description__c;
				reqWrapper.requirement.Due_Date__c = null;
				reqWrapper.requirement.Hold_Payments__c = null;
				reqWrapper.requirement.RecordTypeId = recTypeId;
				if(accountId != null)
					reqWrapper.requirement.Partner__c = accountId;
				if(initiativeId != null)
					reqWrapper.requirement.Initiative__c = initiativeId;	
				requirementList.add(reqWrapper);
			}				
		}
	}
	public PageReference saveButton() {
		PageReference pageRef = null;
		List<Requirement__c> requirementInsertList = new List<Requirement__c>();
		for(RequirementWrapper req : requirementList) {
			if(req.bSelected) {
				//validate row
				if(validate(req.requirement) == false) return pageRef;
				requirementInsertList.add(req.requirement);
			}
		}
		if(requirementInsertList.size() > 0) {
			//save the record
			Database.insert(requirementInsertList, false); system.debug('###: insert ');    
			if(retUrl != null) {
				pageRef = new PageReference(retUrl);
				return pageRef;
			} 
		}
		addPageMessage(ApexPages.severity.Error,'No rows selected.');
		return pageRef;
	}
	public PageReference cancelButton() {
		if(retUrl != null) {
			PageReference pageRef = new PageReference(retUrl);
			return pageRef;
		} else {
			return null;
		}
	}
    // VALIDATION
    public Boolean validate(Requirement__c req) {
        Boolean bReturnValue = true;
		if(req.Name == null) {
			addPageMessage(ApexPages.severity.Error,'Requirement Name is required');
			bReturnValue = false;
		}
		if(req.Description__c == '' || req.Description__c == null || req.Description__c == ' ') {
			addPageMessage(ApexPages.severity.Error,'Description is required');
			bReturnValue = false;
		}
		if(req.Due_Date__c == null) {
			addPageMessage(ApexPages.severity.Error, 'Due Date is required');
			bReturnValue = false;
		}
		if(req.Due_Date__c != null && req.Due_Date__c <= date.today()){
			addPageMessage(ApexPages.severity.Error, 'Due Date should be a future date');
			bReturnValue = false;
		}
		return bReturnValue;
    }
	
    // Add Page Messages
    public void addPageMessage(ApexPages.severity severity, Object objMessage) {
        ApexPages.Message pMessage = new ApexPages.Message(severity, String.valueOf(objMessage));
        ApexPages.addMessage(pMessage);
    }
    public void addPageMessage(Object objMessage) {
        addPageMessage(ApexPages.severity.INFO, objMessage);
    }       
	//Wrapper
	public class RequirementWrapper {
		public boolean bSelected {get;set;}
		public Requirement__c requirement {get;set;}
		public RequirementWrapper() {
			bSelected = false;
			requirement = new Requirement__c();
		}
	}
}