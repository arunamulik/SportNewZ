global with sharing class cloneApplication {

     webservice static String clone(Id applicationId, String recordTypeName) {
        //
        List<RecordType> recordTypeList = [Select Id, Name From RecordType where SobjectType='Application__c'];
        Map<String, Id> recordTypeMap = new Map<String, Id>();
        Application__c appClone = new Application__c();
        
        if(recordTypeList.size() > 0) {
            for(RecordType rec : recordTypeList) {
                recordTypeMap.put(rec.Name, rec.id);
            }
        }
        if(recordTypeName.endsWith('EOI')) {
            recordTypeName = recordTypeName.replace('EOI', 'Full');
            
            if(recordTypeMap.get(recordTypeName) != null) {
                //todo query the application
                List<Application__c> appUpsertList = new List<Application__c>();
                Application__c appObject = new Application__c();
                List<Application__c> appList = [Select Id, Name, Applicant__c, Application_Round__c, Contact__c, Description__c, End_Date__c,
                                            EOI_Application__c, Investment_Sought__c, Name__c, Plan__c, Start_Date__c, Total_Project_Cost__c, Application_Round__r.Full_Application_Round__c
                                            from Application__c where EOI_Clone__c=true and id=:applicationId];
                if(appList.size() > 0) {
                    appObject = appList.get(0);         
                    appObject.EOI_Clone_Already_Cloned__c = true;       
                    appClone = appObject.clone();
                    appClone.Date_Received__c = date.today();
                    appClone.EOI_Application__c = appObject.Id;
                    appClone.Application_Round__c = appObject.Application_Round__r.Full_Application_Round__c;
                    appClone.RecordTypeId = recordTypeMap.get(recordTypeName);
                    appUpsertList.add(appObject);
                    appUpsertList.add(appClone);            

                    if(appUpsertList.size() > 0) {
                        upsert appUpsertList;
                        return appClone.Id;
                    }
                    return null;    

                } return null;          
                
            }
            return null;
        }
        return null;
        
    }
}