trigger Initiative on Initiative__c (before insert) {

	//get the partner field 
	Set<Id> planIds = new Set<Id>();
	for(Initiative__c init: trigger.new){		
		planIds.add(init.Plan__c);
	}
	
	Map<Id, Plan__c> planMap = new Map<Id, Plan__c>([Select Id, Partner__c from Plan__c where id in: planIds]);
	
	for(Initiative__c init: trigger.new){
		
		if(planMap.get(init.Plan__c).Partner__c != null)
		init.Partner__c = planMap.get(init.Plan__c).Partner__c;
		
	}
	
}