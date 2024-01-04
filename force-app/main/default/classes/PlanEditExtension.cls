public with sharing class PlanEditExtension {
	public Plan__c plan {get;set;} //dynamic fields     
	public String pageSectionFields {get;set;}  
    public List<sectionsWrapper> sectionsWrapperList {get;set;}
	public Plan__c planData {get;set;} //related list data 
    public Id tempId {get;set;}public Id rtId {get;set;}
	//related list
	public List<wInitiative> initWrapList {get;set;}
	public Integer rowInitDelete {get;set;}
	private List<Initiative__c> initDeleteList {get;set;}
	public List<wOpportunity> oppWrapList {get;set;}
	public Integer rowOppDelete {get;set;}
	private List<Opportunity__c> oppDeleteList {get;set;}
	public List<wChallenge> challengeWrapList {get;set;}
	public Integer rowChallDelete {get;set;}
	private List<Challenge__c> challDeleteList {get;set;}	
	public PlanEditExtension(ApexPages.StandardController controller){
		if(sectionsWrapperList == null)
        	sectionsWrapperList = new List<sectionsWrapper>();
        //related list initialize
		initWrapList = new List<wInitiative>();
		oppWrapList = new List<wOpportunity>();
		challengeWrapList = new List<wChallenge>();
		initDeleteList = new List<Initiative__c>();
		oppDeleteList = new List<Opportunity__c>();
		challDeleteList = new List<Challenge__c>();        
        tempid=ApexPages.currentPage().getParameters().get('id');
        if(tempid != null){
        	//build the related list for detail view if needed
        	List<Plan__c> planList = 
        	[Select Id, Name,
        	(Select Id, Name,Plan__c, Start_Date__c, End_Date__c, Requested__c,
             Description__c,
             Investment_Area__c, Planned__c, Priority__c, Timeframe__c From Initiatives__r),
        	(Select Id, Name, Description__c, Partner_Plan__c,Sport_NZ_Support__c  From Opportunities__r),
        	(Select Id, Name,  Description__c, Partner_Plan__c,Sport_NZ_Support__c From Challenges__r)
        	 From Plan__c  where id=:tempid];
			if(planList.size() > 0) {
				planData = planList.get(0);
				if(planData.Initiatives__r.size() > 0){
					for (Integer i = 0; i < planData.Initiatives__r.size(); i++){
		                wInitiative tempInit = new wInitiative();
		                tempInit.initiative = planData.Initiatives__r[i];
		                tempInit.rowNum = i;
		                initWrapList.add(tempInit);
		            }
				}
				if(planData.Opportunities__r.size() > 0){
					for (Integer i = 0; i < planData.Opportunities__r.size(); i++){
		                wOpportunity tempOpp = new wOpportunity();
		                tempOpp.opportunity = planData.Opportunities__r[i];
		                tempOpp.rowNum = i;
		                oppWrapList.add(tempOpp);
		            }
				}
				if(planData.Challenges__r.size() > 0){
					for (Integer i = 0; i < planData.Challenges__r.size(); i++){
		                wChallenge tempChallenge = new wChallenge();
		                tempChallenge.challenge = planData.Challenges__r[i];
		                tempChallenge.rowNum = i;
		                challengeWrapList.add(tempChallenge);
		            }
				}
			} else {
				tempId = null;
			}
        }
	}
	
	public void loadEditSectionCall() {
		List<String> perSectionList = new List<String>();
		//Project Detail:#2:::#Name##Primary_Contact__c##:::#Application Outcomes:#2::#Application__c## etc...
		if(pageSectionFields != null) {perSectionList = pageSectionFields.split(':::#');
			for(String str : perSectionList){
			    sectionsWrapper secWrap = new sectionsWrapper();
				list<String> strList = str.split('::#');
			    system.debug('## strlist =>' + strlist.get(0)); //project details:#2
			    list<String> headList = strList.get(0).split(':#');
			    system.debug('## headlist =>' + headlist.get(0)); 
			    secWrap.sectionName=headlist.get(0); //column name
			    if(headlist.size() > 1)
	        		secWrap.sectionColumns = headlist.get(1); //column count
			   //split the fields
			   if(strList.size() > 1){
			   	   String tempString = strList.get(1).replace('null##', '');
				   list<String> fieldsList = tempString.split('##');
				   system.debug('## fieldsList =>' + fieldsList);
				   secWrap.sectionFields = fieldsList;
			   }
			   sectionsWrapperList.add(secWrap);
			}  
			system.debug('## sectionsWrapperList =>' + sectionsWrapperList);
			//display the fields
			if(tempid == null){ //NEW
				plan = new Plan__c(); 
			} else { 
				//EDIT - Display the fields 
				String query = 'Select ';   
				for(sectionsWrapper sect: sectionsWrapperList){
					if(sect.sectionFields != null){
						for(String str: sect.sectionFields){
							 if(str != 'null')
							 query += ' ' + str + ',';
						}
					}
				}
			    query = query.Substring(0,query.length()-1);
			   	query += ' from plan__c';
		       	if(tempid != null)
		       		query += ' where id=\'' + tempid + '\'';
		        query += ' limit 1';
		    	system.debug('## query =>' + query);
		        plan = database.query(query);   
			}
		}
	}
	public pageReference refreshPage() {
		return page.PlanEditor; 
	}
	//page actions	
    public void addInitiativeRow() {
        wInitiative wInit = new wInitiative();
        wInit.initiative = new Initiative__c(Plan__c = planData.Id);
        wInit.rowNum = initWrapList.size();
        initWrapList.add(wInit);
    }
    public void deleteInitiativeRow(){
        if (initWrapList.size() > 0 ){
            wInitiative initToDelete = new wInitiative();
            initToDelete = initWrapList.remove(rowInitDelete);
            // delete existing
            if(initToDelete.initiative.id != null)
            initDeleteList.add(initToDelete.initiative);
        }
    }
    public void addOpportunityRow() {
        wOpportunity wOpp = new wOpportunity();
        wOpp.opportunity = new Opportunity__c(Partner_Plan__c = planData.Id);
        wOpp.rowNum = oppWrapList.size();
        oppWrapList.add(wOpp);
    }
    public void deleteOpportunityRow(){
        if (oppWrapList.size() > 0 ){
            wOpportunity oppToDelete = new wOpportunity();
            oppToDelete = oppWrapList.remove(rowOppDelete);
            //only delete existing
            if(oppToDelete.opportunity.id != null)
            oppDeleteList.add(oppToDelete.opportunity);
        }
    }
    public void deleteChallengeRow(){
        if (challengeWrapList.size() > 0 ){
            wChallenge challToDelete = new wChallenge();
            challToDelete = challengeWrapList.remove(rowChallDelete);
            //only delete existing
            if(challToDelete.challenge.id != null)
            challDeleteList.add(challToDelete.challenge);
        }
    }
    public void addChallengeRow() {
        wChallenge wChall = new wChallenge();
        wChall.challenge = new Challenge__c(Partner_Plan__c = planData.Id);
        wChall.rowNum = challengeWrapList.size();
        challengeWrapList.add(wChall);
    }
    public pageReference cancelDetails() {
        PageReference pageRef = new PageReference('/' + planData.id);
        return pageRef;
    }
    public pageReference saveDetails() {
    	SavePoint sp = Database.setSavepoint();
    	Boolean initiativeComplete = true;
    	Boolean challengesComplete = true;
    	Boolean opportunitiesComplete = true;
    	List<Initiative__c> initiativeToUpsert = new List<Initiative__c>();
    	List<Challenge__c> challengesToUpsert = new List<Challenge__c>();
    	List<Opportunity__c> opportunitiesToUpsert = new List<Opportunity__c>();
    	//validate fields
    	if(initWrapList.size() > 0){
    		for(wInitiative init: initWrapList){
    			if(init.initiative.Name != null && init.initiative.Investment_Area__c != null){
    				//todo update list
    				initiativeToUpsert.add(init.initiative);
    			} else {
    				initiativeComplete = false;
    			}
    		}
    	}
    	if(challengeWrapList.size() > 0){
    		for(wChallenge ch : challengeWrapList){
    			if(ch.challenge.Name != null && ch.challenge.Description__c != null && ch.challenge.Sport_NZ_Support__c != null){
    				//todo update list
    				challengesToUpsert.add(ch.challenge);
    			} else {
    				challengesComplete = false;
    			}
    		}
    	}
    	if(oppWrapList.size() > 0){
    		for(wOpportunity opp : oppWrapList){
    			if(opp.opportunity.Description__c != null && opp.opportunity.Name != null && opp.opportunity.Sport_NZ_Support__c != null){
    				//todo update list
    				opportunitiesToUpsert.add(opp.opportunity);
    			} else {
    				opportunitiesComplete = false;
    			}
    		}
    	}
        if(!initiativeComplete){
            ApexPages.Message pMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Name and Investment Area fields are required. Please make sure all fields are populated.');
            ApexPages.addMessage(pMessage);
        }
        if(!challengesComplete){
            ApexPages.Message pMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'All challenge row fields are required. Please make sure all fields are populated.');
            ApexPages.addMessage(pMessage);
        }
        if(!opportunitiesComplete){
            ApexPages.Message pMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'All Opportunity row fields are required. Please make sure all fields are populated.');
            ApexPages.addMessage(pMessage);
        }
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        if(msgs.size() > 0){
        	return null;
        } else {
        	try
        	{
        		upsert plan;if(initiativeToUpsert.size() > 0)upsert initiativeToUpsert;
        		if(initDeleteList.size() > 0)
        			delete initDeleteList;
        		//challenges
        		if(challengesToUpsert.size() > 0)
        			upsert challengesToUpsert;
        		if(challDeleteList.size() > 0)
        			delete challDeleteList;
				//opportunity
        		if(opportunitiesToUpsert.size() > 0)
        			upsert opportunitiesToUpsert;
        		if(oppDeleteList.size() > 0)
        			delete oppDeleteList;
        	} 
        	catch (Exception e)
        	{
	            ApexPages.Message pMessage = new ApexPages.Message(ApexPages.severity.ERROR, 'Plan not updated. Contact Administrator');
	            ApexPages.addMessage(pMessage);
	            Database.rollback(sp);
	            return null;
        	}
        }
    	PageReference pageRef = new PageReference('/' + plan.id);
        return pageRef;
    }
	//Wrapper classes
    public class wInitiative {
        public Integer rowNum {get;set;}
        public Boolean allowDelete {get;set;} 
        public Initiative__c initiative {get;set;}
    }
    public class wChallenge {
        public Integer rowNum {get;set;}
        public Boolean allowDelete {get;set;} 
        public Challenge__c challenge {get;set;}
    }
    public class wOpportunity {
        public Integer rowNum {get;set;}
        public Boolean allowDelete {get;set;} 
        public Opportunity__c opportunity {get;set;}
    }
	public class sectionsWrapper{
		public string sectionName {get;set;}
		public string sectionColumns {get;set;}
		public List<String> sectionFields {get;set;}
	}
}