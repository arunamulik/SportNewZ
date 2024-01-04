public without sharing class RUL_ProgramTriggerHandler {
	public void afterInsert(list<Programme__c> lstNew){
		set <Id> setOrganizationId = new set <Id>();
		for(Programme__c objP : lstNew){
			if(!String.isBlank(objP.Organization_Id__c)){
				setOrganizationId.add(objP.Organization_Id__c);
			}
		}
		if(!setOrganizationId.isEmpty()){
			rollupDetails(setOrganizationId);
		}
	}
	
	public void afterUpdate(map<Id,Programme__c> mapNewMap, map <Id,Programme__c> mapOldMap){
		set <Id> setOrganizationId = new set <Id>();
		for(Programme__c objP : mapNewMap.values()){
			if(!String.isBlank(objP.Organization_Id__c)
			&& (objP.Organization_Id__c != 
			mapOldMap.get(objP.Id).Organization_Id__c
			|| objP.Number_of_Programmes_Delivered__c != 
			mapOldMap.get(objP.Id).Number_of_Programmes_Delivered__c
			|| objP.Number_of_Sessions_Delivered__c != 
			mapOldMap.get(objP.Id).Number_of_Sessions_Delivered__c
			|| objP.Avg_No_of_Participants_at_Each_Session__c != 
			mapOldMap.get(objP.Id).Avg_No_of_Participants_at_Each_Session__c)){
				setOrganizationId.add(objP.Organization_Id__c);
			}
		}
		if(!setOrganizationId.isEmpty()){
			rollupDetails(setOrganizationId);
		}
	}
	
	public void rollupDetails(set<Id> setOrgId){
		list <Account> lstA = [Select 
								a.No_of_Sessions_Delivered__c, 
								a.No_of_Programs_Delivered__c, 
								a.Id, 
								a.Avg_No_of_Participants_at_Each_Session__c, 
								(Select 
								Id, 
								Number_of_Programmes_Delivered__c, 
								Number_of_Sessions_Delivered__c, 
								Avg_No_of_Participants_at_Each_Session__c, 
								Organization_Id__c 
								From Programme_and_Event_Participation1__r) 
								From Account a
								where a.Id IN : setOrgId];
		
		for(Account objA : lstA){
			decimal intAvg = 0;
			decimal intSessions = 0;
			decimal intPrograms = 0;
			for(Programme__c objP : objA.Programme_and_Event_Participation1__r){
				if(objP.Avg_No_of_Participants_at_Each_Session__c != null){
					intAvg = intAvg + objP.Avg_No_of_Participants_at_Each_Session__c;
				}
				if(objP.Number_of_Programmes_Delivered__c != null){
					intPrograms = intPrograms + objP.Number_of_Programmes_Delivered__c;
				}
				if(objP.Number_of_Sessions_Delivered__c != null){
					intSessions = intSessions + objP.Number_of_Sessions_Delivered__c;
				}
			}
			objA.Avg_No_of_Participants_at_Each_Session__c = intAvg;
			objA.No_of_Sessions_Delivered__c = intSessions;
			objA.No_of_Programs_Delivered__c = intPrograms;
		}
		update lstA;
	}
}