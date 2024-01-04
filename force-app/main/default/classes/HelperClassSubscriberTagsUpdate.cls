public class HelperClassSubscriberTagsUpdate {
    
    public static void beforeInsertFunction(List < Subscriber__c > newSubList) {
        
        Set < String > emailSet = new Set < String > ();
        for (Subscriber__c c: newSubList)
            emailSet.add(c.Email_Address__c);
        system.debug('**Email set : '+emailSet);
        //Creating recordtype set
        Set<ID> recordTypeSet = new Set<ID>();
        
        
        Map < String, Subscriber__c > duplicatePublicSubscriberMap = new Map < String, Subscriber__c > ();
        Map < String, Subscriber__c > duplicateHpsnzSubscriberMap = new Map < String, Subscriber__c > ();
        Map < String, Subscriber__c > duplicateMediaSubscriberMap = new Map < String, Subscriber__c > ();
        Map < String, Subscriber__c > duplicateIntegritySubscriberMap = new Map < String, Subscriber__c > ();
        
        List < Subscriber__c > subList = new List < Subscriber__c > ();
        
        Id publicRecordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Public').getRecordTypeId();
        system.debug('publicRecordTypeId :'+publicRecordTypeId);
        Id hpsnzRecordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('High Performance Sport NZ').getRecordTypeId();
        system.debug('hpsnzRecordTypeId :'+hpsnzRecordTypeId);
        Id mediaRecordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Media').getRecordTypeId();
        system.debug('mediaRecordTypeId :'+mediaRecordTypeId);
        Id integrityRecordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Integrity').getRecordTypeId();
        system.debug('integrityRecordTypeId :'+integrityRecordTypeId);
        Id duplicateHpsnzSubscriberId;
        Id duplicateMediaSubscriberId;
        Id duplicateIntegritySubscriberId;
        
        List < Subscriber__c > subPublicDupList = new List < Subscriber__c > ();
        List < Subscriber__c > subHpsnzDupList = new List < Subscriber__c > ();
        List < Subscriber__c > subMediaDupList = new List < Subscriber__c > ();
        List < Subscriber__c > subIntegrityDupList = new List < Subscriber__c > ();
        
        
        for (Subscriber__c c: newSubList)
        {
            recordTypeSet.add(c.RecordTypeId);
            
            //make weekly and monthly subscription true for new public record
            //By Aruna Mulik 10/2/2023
            if(c.RecordTypeId==publicRecordTypeId && c.Balance_is_Better__c==true)
            {
                c.Monthly__c=true;
                c.Weekly__c =true;
            }
            
            if(c.RecordTypeId==publicRecordTypeId && (c.Monthly__c==true || c.Weekly__c==true ))
            {
                c.Balance_is_Better__c=true;
            }
            
        }
        system.debug('**recordTypeSet : '+recordTypeSet);
        
        
        //Subscriber__c subList;
        for (Subscriber__c c: [select Id, IsDeleted, Name, RecordTypeId, Balance_is_Better__c, Email_Address__c,Partner_Type__c, First_Name__c, Healthy_Active_Learning__c, Last_Name__c,
                               Location__c, Mobile_Number__c, NZ_Coach__c, Organisation__c, Role__c, Sector_Update__c, Subscribed__c, Type__c,
                               Disability_Sector_News__c, General_Media__c, Carded_Athlete_Db__c, Healthy_Active_Quarterly__c, General_Db__c, Woman_in_Sport_Db__c,
                               Athlete_Life_Db__c, Coach_Db__c, NSO_Marcomms_Db__c, HP_Woman_Feedback__c, Do_you_identify_as_Maori__c, Kaupapa_Maori_News__c, Ko_wai_koe__c,
                               Click_Location__c, Signup_Type__c, High_Performance_Sport_New_Zealand__c, Tags__c, Youth_sport_options__c, isDuplicate__c,Integrity__c,Monthly__c,Weekly__c,
                               iseGuide__c,HiddenTag__c,Active_Recreation__c
                               FROM Subscriber__c 
                               WHERE Email_Address__c In: emailSet 
                               AND RecordTypeId In :recordTypeSet])
        {
            if(c.RecordTypeId==publicRecordTypeId){
                duplicatePublicSubscriberMap.put(c.Email_Address__c, c);
                system.debug('duplicatePublicSubscriberMap : '+duplicatePublicSubscriberMap);
            }
            if(c.RecordTypeId==hpsnzRecordTypeId){
                duplicateHpsnzSubscriberMap.put(c.Email_Address__c, c);
                system.debug('duplicateHpsnzSubscriberMap : '+duplicateHpsnzSubscriberMap);
            }
            if(c.RecordTypeId==mediaRecordTypeId){
                duplicateMediaSubscriberMap.put(c.Email_Address__c, c);
                system.debug('duplicateMediaSubscriberMap : '+duplicateMediaSubscriberMap);
            }
            if(c.RecordTypeId==integrityRecordTypeId){
                duplicateIntegritySubscriberMap.put(c.Email_Address__c, c);
                system.debug('duplicateIntegritySubscriberMap : '+duplicateIntegritySubscriberMap);
            }
            
        }
        
        System.debug('**Duplicate public Map : ' + duplicatePublicSubscriberMap);
        System.debug('**Duplicate public Map size : ' + duplicatePublicSubscriberMap.size());
        system.debug('***Duplicate hpsnz Map : '+duplicateHpsnzSubscriberMap);
        System.debug('**Duplicate hpsnz Map size : ' + duplicateHpsnzSubscriberMap.size());
        system.debug('****Duplicate media Map : '+duplicateMediaSubscriberMap);
        System.debug('**Duplicate media Map size : ' + duplicateMediaSubscriberMap.size());
        system.debug('****Duplicate Integrity Map : '+duplicateIntegritySubscriberMap);
        System.debug('**Duplicate Integrity Map size : ' + duplicateIntegritySubscriberMap.size());
        
        
        
        
        
        if (duplicatePublicSubscriberMap.size() > 0) 
        {
            for (Subscriber__c c: newSubList) {
                
                if(c.RecordTypeId==publicRecordTypeId && duplicatePublicSubscriberMap.containsKey(c.Email_Address__c)){
                    
                    system.debug('inside for loop c :' + c);
                    
                    Id duplicateSubscriberId = duplicatePublicSubscriberMap.get(c.Email_Address__c).id;
                    if (duplicateSubscriberId != null) 
                    {
                        
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Tags__c!=null){
                            c.Tags__c = duplicatePublicSubscriberMap.get(c.Email_Address__c).Tags__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).First_Name__c!=null){
                            c.First_Name__c = duplicatePublicSubscriberMap.get(c.Email_Address__c).First_Name__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Last_Name__c!=null){
                            c.Last_Name__c = duplicatePublicSubscriberMap.get(c.Email_Address__c).Last_Name__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Location__c!=null){
                            c.Location__c = duplicatePublicSubscriberMap.get(c.Email_Address__c).Location__c;
                        }
                        
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Organisation__c!=null){
                            c.Organisation__c = duplicatePublicSubscriberMap.get(c.Email_Address__c).Organisation__c;
                        }
                        // if(c.RecordTypeId=='0126F000001Msc2QAC'){
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Role__c!=null){
                            c.Role__c = duplicatePublicSubscriberMap.get(c.Email_Address__c).Role__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Click_Location__c!=null){
                            c.Click_Location__c = duplicatePublicSubscriberMap.get(c.Email_Address__c).Click_Location__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Signup_Type__c!=null){
                            c.Signup_Type__c = duplicatePublicSubscriberMap.get(c.Email_Address__c).Signup_Type__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).youth_sport_options__c==null){
                            if(c.Youth_sport_options__c!=null)
                                c.Youth_sport_options__c = c.youth_sport_options__c.replaceAll(',',';');
                        }
                        else{
                            c.Youth_sport_options__c =duplicatePublicSubscriberMap.get(c.Email_Address__c).youth_sport_options__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Sector_Update__c==true){
                            c.Sector_Update__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).Sector_Update__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).NZ_Coach__c==true){
                            c.NZ_Coach__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).NZ_Coach__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Balance_is_Better__c==true){
                            if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Monthly__c==true)
                                c.Monthly__c= true;                          
                            if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Weekly__c==true)
                                c.Weekly__c=true;
                            c.Balance_is_Better__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).Balance_is_Better__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Kaupapa_Maori_News__c==true){
                            c.Kaupapa_Maori_News__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).Kaupapa_Maori_News__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Disability_Sector_News__c==true){
                            c.Disability_Sector_News__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).Disability_Sector_News__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Healthy_Active_Learning__c==true){
                            c.Healthy_Active_Learning__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).Healthy_Active_Learning__c;
                        }
                        
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Active_Recreation__c==true){
                            c.Active_Recreation__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).Active_Recreation__c;
                        }
                        
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Healthy_Active_Quarterly__c==true){
                            c.Healthy_Active_Quarterly__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).Healthy_Active_Quarterly__c;
                        }
                        
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Do_you_identify_as_Maori__c==true){
                            c.Do_you_identify_as_Maori__c= duplicatePublicSubscriberMap.get(c.Email_Address__c).Do_you_identify_as_Maori__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Partner_Type__c!=null){
                            c.Partner_Type__c= duplicatePublicSubscriberMap.get(c.Email_Address__c).Partner_Type__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).Ko_wai_koe__c!=null){
                            c.Ko_wai_koe__c= duplicatePublicSubscriberMap.get(c.Email_Address__c).Ko_wai_koe__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).iseGuide__c == True){
                            c.iseGuide__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).iseGuide__c;
                        }
                        if(duplicatePublicSubscriberMap.get(c.Email_Address__c).HiddenTag__c!=null){
                            c.HiddenTag__c=duplicatePublicSubscriberMap.get(c.Email_Address__c).HiddenTag__c;
                        }
                        duplicatePublicSubscriberMap.get(c.Email_Address__c).isDuplicate__c = true;
                        subPublicDupList.add(duplicatePublicSubscriberMap.get(c.Email_Address__c));
                    }
                }
            }
            System.debug('subPublicDupList : '+subPublicDupList);
            if(subPublicDupList.size()>0){
                delete subPublicDupList;
            }
            
        }
        
        
        if(duplicateHpsnzSubscriberMap.size()>0)
        {
            system.debug('inside duplicateHpsnzSubscriberMap if');
            for (Subscriber__c c: newSubList) {
                if(c.RecordTypeId==hpsnzRecordTypeId && duplicateHpsnzSubscriberMap.containsKey(c.Email_Address__c)){
                    system.debug('inside for loop c :' + c);
                    
                    duplicateHpsnzSubscriberId = duplicateHpsnzSubscriberMap.get(c.Email_Address__c).id;
                    if (duplicateHpsnzSubscriberId != null)
                    {
                        system.debug('inside duplicateHpsnzSubscriberId not null if');
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).First_Name__c!=null){
                            c.First_Name__c = duplicateHpsnzSubscriberMap.get(c.Email_Address__c).First_Name__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Last_Name__c!=null){
                            c.Last_Name__c = duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Last_Name__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Location__c!=null){
                            c.Location__c = duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Location__c;
                        }
                        
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Organisation__c!=null){
                            c.Organisation__c = duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Organisation__c;
                        }
                        
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Role__c!=null){
                            c.Role__c = duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Role__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).High_Performance_Sport_New_Zealand__c==true){
                            c.High_Performance_Sport_New_Zealand__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).High_Performance_Sport_New_Zealand__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).General_Db__c==true){
                            system.debug('if condition general db');
                            c.General_Db__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).General_Db__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).NSO_Marcomms_Db__c==true){
                            c.NSO_Marcomms_Db__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).NSO_Marcomms_Db__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Coach_Db__c==true){
                            c.Coach_Db__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Coach_Db__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Athlete_Life_Db__c==true){
                            c.Athlete_Life_Db__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Athlete_Life_Db__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Carded_Athlete_Db__c==true){
                            c.Carded_Athlete_Db__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Carded_Athlete_Db__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Woman_in_Sport_Db__c==true){
                            c.Woman_in_Sport_Db__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Woman_in_Sport_Db__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).HP_Woman_Feedback__c==true){
                            c.HP_Woman_Feedback__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).HP_Woman_Feedback__c;
                        }
                        if(duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Subscribed__c==true){
                            c.Subscribed__c= duplicateHpsnzSubscriberMap.get(c.Email_Address__c).Subscribed__c;
                        }
                        duplicateHpsnzSubscriberMap.get(c.Email_Address__c).isDuplicate__c = true;
                        subHpsnzDupList.add(duplicateHpsnzSubscriberMap.get(c.Email_Address__c));
                    }
                } 
            }
            if(subHpsnzDupList.size()>0){
                delete subHpsnzDupList;
            }
        }
        
        if(duplicateIntegritySubscriberMap.size()>0)
        {
            system.debug('inside duplicateIntegritySubscriberMap if');
            for (Subscriber__c c: newSubList) {
                if(c.RecordTypeId==integrityRecordTypeId && duplicateIntegritySubscriberMap.containsKey(c.Email_Address__c)){
                    system.debug('inside for loop c :' + c);
                    
                    duplicateIntegritySubscriberId = duplicateIntegritySubscriberMap.get(c.Email_Address__c).id;
                    if (duplicateIntegritySubscriberId != null)
                    {
                        system.debug('inside integrityRecordTypeId not null if');
                        if(duplicateIntegritySubscriberMap.get(c.Email_Address__c).First_Name__c!=null){
                            c.First_Name__c = duplicateIntegritySubscriberMap.get(c.Email_Address__c).First_Name__c;
                        }
                        if(duplicateIntegritySubscriberMap.get(c.Email_Address__c).Last_Name__c!=null){
                            c.Last_Name__c = duplicateIntegritySubscriberMap.get(c.Email_Address__c).Last_Name__c;
                        }
                        if(duplicateIntegritySubscriberMap.get(c.Email_Address__c).Location__c!=null){
                            c.Location__c = duplicateIntegritySubscriberMap.get(c.Email_Address__c).Location__c;
                        }
                        
                        if(duplicateIntegritySubscriberMap.get(c.Email_Address__c).Organisation__c!=null){
                            c.Organisation__c = duplicateIntegritySubscriberMap.get(c.Email_Address__c).Organisation__c;
                        }
                        
                        if(duplicateIntegritySubscriberMap.get(c.Email_Address__c).Role__c!=null){
                            c.Role__c = duplicateIntegritySubscriberMap.get(c.Email_Address__c).Role__c;
                        }
                        
                        if(duplicateIntegritySubscriberMap.get(c.Email_Address__c).Integrity__c==true){
                            c.Integrity__c= duplicateIntegritySubscriberMap.get(c.Email_Address__c).Integrity__c;
                        }
                        
                        duplicateIntegritySubscriberMap.get(c.Email_Address__c).isDuplicate__c = true;
                        subIntegrityDupList.add(duplicateIntegritySubscriberMap.get(c.Email_Address__c));
                    }
                } 
            }
            if(subIntegrityDupList.size()>0){
                delete subIntegrityDupList;
            }
        }
        
        if(duplicateMediaSubscriberMap.size()>0)
        {
            system.debug('inside duplicateMediaSubscriberMap if');
            for (Subscriber__c c: newSubList) {
                if(c.RecordTypeId==mediaRecordTypeId && duplicateMediaSubscriberMap.containsKey(c.Email_Address__c)){
                    system.debug('inside for loop c :' + c);
                    duplicateMediaSubscriberId = duplicateMediaSubscriberMap.get(c.Email_Address__c).id;
                    if (duplicateMediaSubscriberId != null)
                    {
                        system.debug('inside duplicateMediaSubscriberMap if id not null ');
                        if(duplicateMediaSubscriberMap.get(c.Email_Address__c).First_Name__c!=null){
                            c.First_Name__c = duplicateMediaSubscriberMap.get(c.Email_Address__c).First_Name__c;
                        }
                        if(duplicateMediaSubscriberMap.get(c.Email_Address__c).Last_Name__c!=null){
                            c.Last_Name__c = duplicateMediaSubscriberMap.get(c.Email_Address__c).Last_Name__c;
                        }
                        if(duplicateMediaSubscriberMap.get(c.Email_Address__c).Location__c!=null){
                            c.Location__c = duplicateMediaSubscriberMap.get(c.Email_Address__c).Location__c;
                        }
                        
                        if(duplicateMediaSubscriberMap.get(c.Email_Address__c).Organisation__c!=null){
                            c.Organisation__c = duplicateMediaSubscriberMap.get(c.Email_Address__c).Organisation__c;
                        }
                        // if(c.RecordTypeId=='0126F000001Msc1QAC'){
                        if(duplicateMediaSubscriberMap.get(c.Email_Address__c).General_Media__c==true){
                            c.General_Media__c= duplicateMediaSubscriberMap.get(c.Email_Address__c).General_Media__c;
                        }
                        if(duplicateMediaSubscriberMap.get(c.Email_Address__c).Subscribed__c==true){
                            c.Subscribed__c = duplicateMediaSubscriberMap.get(c.Email_Address__c).Subscribed__c;
                        }
                        duplicateMediaSubscriberMap.get(c.Email_Address__c).isDuplicate__c = true;
                        subMediaDupList.add(duplicateMediaSubscriberMap.get(c.Email_Address__c));
                    }
                } 
            }
            if(subMediaDupList.size()>0){
                delete subMediaDupList;
            }
        }
        
        
        
    }
    @future
    public static void deleteDuplicateSubscribers() {
        List < Subscriber__c > subList = [select Id from Subscriber__c where isDuplicate__c = true];
        //Subscriber__c subList;
        system.debug('**subList : ' + subList);
        if (subList.size() > 0) {
            system.debug('in delete update');
            try {
                delete subList;
            } catch (Exception e) {
                System.debug(e.getMessage());
            }
        }
    }
    
    
    
    public static void afterUpdate(List < Subscriber__c > newSubList) {
        List<Subscriber__c> subList= [SELECT Id FROM Subscriber__c WHERE isDuplicate__c = true];
        if (subList.size() > 0) {
            deleteDuplicateSubscribers();
        }
        
       /* List<Subscriber__c> updatesubList = new List<Subscriber__c>();
		
        for(Subscriber__c c : newSubList)
        {
         
            //To check if subscriber has requested for eguide
            List< Subscriber__History> histrec = [select Id, CreatedDate, Field 
                                                  from Subscriber__History 
                                                  where Field='Tags__c' 
                                                  AND CreatedDate =: c.LastModifiedDate limit 1];
            
            System.debug('Histrec ******* '+histrec);
            System.debug('Last modified date ******* '+c.LastModifiedDate);
            
            if(histrec.size()>0)
                c.iseGuide__c = true;
            else
                c.iseGuide__c = false;
            
            updatesubList.add(c);    
        }		
        
        update updatesubList;*/
        
    }
    
    /*  @future
public static void updateTagSubscriber(String jsonsubUpdateList) {
List<Subscriber__c> subUpdateList = (List<Subscriber__c>)Json.deserialize(jsonsubUpdateList, List<Subscriber__c>.class);
if(subUpdateList.size()>0){
system.debug('subUpdateList: '+subUpdateList);
// update subUpdateList;
Database.SaveResult[] srList = Database.update(subUpdateList, true);
// Database method to update the records in List
// Iterate through each returned result by the method
for (Database.SaveResult sr : srList) {
if (sr.isSuccess()) {
// This condition will be executed for successful records and will fetch
// the ids of successful records
System.debug('Successfully updated Invoice. Invoice ID is : ' + sr.getId());
} else {
// This condition will be executed for failed records
for(Database.Error objErr : sr.getErrors()) {
System.debug('The following error has occurred.');

// Printing error message in Debug log
System.debug(objErr.getStatusCode() + ': ' + objErr.getMessage());
System.debug('Invoice oject field which are affected by the error:' 
+ objErr.getFields());
}
}
}
} 
}*/
    public static void beforeUpdate(List < Subscriber__c > newSubList,Map<Id,Subscriber__c> oldmap) {
        
        System.debug('NewSubLidy:- '+newSubList);
        Boolean recUpdate=false;
        
        
        
        
        Set < String > emailSet = new Set < String > ();
        Set < String > recordTypeSet = new Set < String > ();
        
        //System.debug('DUpemail Before update:- '+ emailSet);
        //Creating recordtype set
        
        Id publicRecordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Public').getRecordTypeId();
        system.debug('publicRecordTypeId :'+publicRecordTypeId);
        Id hpsnzRecordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('High Performance Sport NZ').getRecordTypeId();
        system.debug('hpsnzRecordTypeId :'+hpsnzRecordTypeId);
        Id mediaRecordTypeId = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Media').getRecordTypeId();
        system.debug('mediaRecordTypeId :'+mediaRecordTypeId);
        Set < String > notPublicEmailSet = new Set < String > ();
        
       
        for(Subscriber__c c : newSubList)
        {
            
            System.debug('Tag field **** :- '+c.Tags__c);
            if(c.youth_sport_options__c!=null){
                c.youth_sport_options__c=c.youth_sport_options__c.replaceAll(',',';');
            }
            
            emailSet.add(c.Email_Address__c);
            recordTypeSet.add(c.RecordTypeId);
            
            Subscriber__c oldsub = oldmap.get(c.Id);
            if(oldsub.Balance_is_Better__c == false && c.Balance_is_Better__c == true)
            {
                if(oldsub.Monthly__c == false && oldsub.Weekly__c == false && (c.Monthly__c == false && c.Weekly__c == false) )
                {    
                	c.Monthly__c = true;
                	c.Weekly__c = true;
                }
            }
            if(((oldsub.Weekly__c == true && c.Weekly__c == false) && (oldsub.Monthly__c == true && c.Monthly__c == false) ) || (oldsub.Weekly__c == true && (c.Weekly__c == false && c.Monthly__c == false)) || (oldsub.Monthly__c == true && (c.Monthly__c == false && c.Weekly__c == false) ))
                c.Balance_is_Better__c = false;
            
            if(oldsub.Balance_is_Better__c == true && c.Balance_is_Better__c == false)
            {
                c.Monthly__c = false;
                c.Weekly__c = false;
            }
            
            if((oldsub.Weekly__c == false && c.Weekly__c == true) || (oldsub.Monthly__c == false && c.Monthly__c == true) )
                c.Balance_is_Better__c = true;
            
            //To check if subscriber has requested for eguide
           /* List< Subscriber__History> histrec = [select Id, CreatedDate, Field 
                                                  from Subscriber__History 
                                                  where Field='Tags__c' 
                                                  AND CreatedDate =: c.LastModifiedDate limit 1];
            
            System.debug('Histrec ******* '+histrec);
            System.debug('Last modified date ******* '+c.LastModifiedDate);
            
            if(histrec.size()>0)
                c.iseGuide__c = true;
            else
                c.iseGuide__c = false;*/
            
                        
        }
        
        
        
        /*List< Subscriber__History> histrec = [select Id, CreatedDate, Field from Subscriber__History where Field='Tags__c' Order by CreatedDate desc limit 1];
        List < Subscriber__c > newrec= [select id, LastModifiedDate from Subscriber__c where Email_Address__c IN:emailSet ];*/
		        
        
        
        Map<String,Subscriber__c> incRrecordsMap=new Map<String,Subscriber__c>();
        Map<ID,Subscriber__c> pickedRrecordsMap=new Map<ID,Subscriber__c>();
        if(checkRecursive.firstRun)
        {
            checkRecursive.firstRun = false;
            
            
            for (Subscriber__c c: newSubList){
                // Id publicRecordTypeIdInSet = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Public').getRecordTypeId();
                if((c.Balance_is_Better__c==true || c.Tags__c!=null) && c.RecordTypeId!=publicRecordTypeId){
                    recUpdate=true;
                    notPublicEmailSet.add(c.Email_Address__c);
                    incRrecordsMap.put(c.Email_Address__c,c);
                    pickedRrecordsMap.put(c.id,c);
                }
            }  
            
            if(notPublicEmailSet.size()>0){
                List<Subscriber__c> publicExistingSubList= [select Id, Balance_is_Better__c, Email_Address__c, First_Name__c,Last_Name__c,
                                                            Tags__c, HiddenTag__c, iseGuide__c
                                                            FROM Subscriber__c
                                                            WHERE Email_Address__c In: notPublicEmailSet 
                                                            AND RecordTypeId = :publicRecordTypeId];
                
                system.debug('publicExistingSubList :'+publicExistingSubList);
                List<Subscriber__C> subUpdateList= new List<Subscriber__c>();
                if(publicExistingSubList.size()>0){
                    for(Subscriber__c c:publicExistingSubList){
                        system.debug('INSIDE for LOOP1');
                        Subscriber__c subRecord = incRrecordsMap.get(c.Email_Address__c);
                        System.debug('***subRecord : '+subRecord);
                        c.Balance_is_Better__c=subRecord.Balance_is_Better__c;
                        c.First_Name__c=subRecord.First_Name__c;
                        c.Last_Name__c=subRecord.Last_Name__c;
                        c.iseGuide__c=subRecord.iseGuide__c;
                        
                       if(subRecord.Tags__c== null && c.Tags__c!= null){
                            System.debug('Inside publicExistingSubList not null(OLD/NEW)');
                            	
                            List < String > oldtags = c.Tags__c.split(',');
                           Boolean res;
                           res=oldtags.Contains(subRecord.Tags__c);
                           System.debug('tag res : '+res);
                           if(!res){
                               system.debug('inside not res for Tags__c');
                               c.Tags__c=c.Tags__c+ ', '+subRecord.Tags__c;
                           }
                           /* for (String tag: oldtags) {
                                system.debug('publicExistingSubList OLDtag :'+tag);
                                system.debug('publicExistingSubList subRecord.Tags__c : '+subRecord.Tags__c);
                                if (!subRecord.Tags__c.Contains(tag)) {
                                    System.debug('publicExistingSubList in if tag :' + c.Tags__c);
                                    c.Tags__c = subRecord.Tags__c + ', ' + tag;
                                }  
                                
                            }*/
                            
                        }
                        else 
                        {
                            system.debug('inside else of tag publicExistingSubList');
                            c.Tags__c = subRecord.Tags__c;
                        } 
                        if(subRecord.HiddenTag__c == null && c.HiddenTag__c!= null){
                            System.debug('Inside publicExistingSubList not null(OLD/NEW)');
                            	
                            List < String > oldtags = c.HiddenTag__c.split(',');
                             Boolean res;
                           res=oldtags.Contains(subRecord.HiddenTag__c);
                            system.debug('res for hidden tag : '+res);
                           if(!res){
                               system.debug('inside not res for hiddenTag__C');
                               c.HiddenTag__c=c.HiddenTag__c+ ', '+subRecord.HiddenTag__c;
                           }
                           /* for (String tag: oldtags) {
                                system.debug('publicExistingSubList OLDtag :'+tag);
                                system.debug('publicExistingSubList subRecord.Tags__c : '+subRecord.HiddenTag__c);
                                if (!subRecord.HiddenTag__c.Contains(tag)) {
                                    System.debug('publicExistingSubList in if tag :' + c.HiddenTag__c);
                                    c.HiddenTag__c = subRecord.HiddenTag__c + ', ' + tag;
                                }  
                                
                            }*/
                            
                        }
                        else 
                        {
                            system.debug('inside else of tag publicExistingSubList');
                            c.HiddenTag__c = subRecord.HiddenTag__c;
                        } 
                        
                        subUpdateList.add(c);
                    }
                } 
                Map<Id,Subscriber__c> pickedExistingSubMap=new  Map<Id,Subscriber__c>([select Id,Balance_is_Better__c, Email_Address__c, First_Name__c,Last_Name__c,
                                                                                       Tags__c,iseGuide__c,HiddenTag__c
                                                                                       FROM Subscriber__c
                                                                                       WHERE ID In: pickedRrecordsMap.keySet()]);
                if(pickedExistingSubMap.size()>0){
                    for (Subscriber__c c: newSubList){
                        system.debug('INSIDE for LOOP picked 2');
                        Subscriber__c existingSubRecord = pickedExistingSubMap.get(c.id);
                        System.debug('***existingSubRecord : '+existingSubRecord);
                        if(existingSubRecord!=null)
                        {
                            c.Balance_is_Better__c=existingSubRecord.Balance_is_Better__c;
                            c.First_Name__c=existingSubRecord.First_Name__c;
                            c.Last_Name__c=existingSubRecord.Last_Name__c;
                            c.Tags__c=existingSubRecord.Tags__c;
                            //subUpdateList.add(c);
                            c.iseGuide__c=existingSubRecord.iseGuide__c;
                            c.HiddenTag__c=existingSubRecord.HiddenTag__c;
                        }
                    }
                    
                    //String jsonList=JSON.serialize(subUpdateList);
                    //updateTagSubscriber(jsonList);
                }
                if(subUpdateList.size()>0){
                    system.debug('subUpdateList : '+subUpdateList);
                    update subUpdateList;
                }
            }
        }
        
        Map < String, Subscriber__c > duplicateSubscriberMap = new Map < String, Subscriber__c > ();
        List < Subscriber__c > subList = new List < Subscriber__c > ();
        //Subscriber__c subList;
        System.debug(emailSet);
        
        
        if (emailSet.size() > 0 && recUpdate == FALSE) {
            
            for (Subscriber__c c: [select Id, IsDeleted, Name, RecordTypeId, Balance_is_Better__c, Email_Address__c, First_Name__c, Healthy_Active_Learning__c, Last_Name__c,
                                   Location__c, Mobile_Number__c, NZ_Coach__c, Organisation__c, Role__c, Sector_Update__c, Subscribed__c, Type__c,
                                   Disability_Sector_News__c, General_Media__c, Carded_Athlete_Db__c,Healthy_Active_Quarterly__c, General_Db__c, Woman_in_Sport_Db__c,
                                   Athlete_Life_Db__c, Coach_Db__c, NSO_Marcomms_Db__c, HP_Woman_Feedback__c, Do_you_identify_as_Maori__c, Kaupapa_Maori_News__c, Ko_wai_koe__c,
                                   Click_Location__c, Signup_Type__c, High_Performance_Sport_New_Zealand__c, Tags__c, Youth_sport_options__c, isDuplicate__c,Weekly__c,Monthly__c,
									iseGuide__c,HiddenTag__c,Active_Recreation__c
                                   FROM Subscriber__c
                                   WHERE Email_Address__c In: emailSet 
                                   AND isDuplicate__c = false 
                                   AND RecordTypeId In :recordTypeSet])
                duplicateSubscriberMap.put(c.Email_Address__c, c);
            System.debug('**Before Update Duplicate Map : ' +duplicateSubscriberMap);
            List < Subscriber__c > subDupList = new List < Subscriber__c > ();
            if (duplicateSubscriberMap.size() > 0) {
                system.debug('duplicateSubscriberMap in before update : '+duplicateSubscriberMap);
                for (Subscriber__c c: newSubList) {
                    
                    if(!c.Balance_is_Better__c && c.RecordTypeId==publicRecordTypeId)
                    {
                        system.debug('inside for loop c :' + c);
                        Id duplicateSubscriberId = duplicateSubscriberMap.get(c.Email_Address__c).id;
                        if (duplicateSubscriberId != null) {
                            String youthopt=null;
                            if(c.youth_sport_options__c!=null)
                                youthopt=c.youth_sport_options__c.replaceAll(',',';');
                            subList.add(new Subscriber__c(
                                Id = duplicateSubscriberId,
                                Click_Location__c = c.Click_Location__c,
                                Signup_Type__c = c.Signup_Type__c,
                                Balance_is_Better__c = c.Balance_is_Better__c,
                                youth_sport_options__c=youthopt,
                                sector_Update__c=c.Sector_Update__c,
                                Kaupapa_Maori_News__c=c.Kaupapa_Maori_News__c,
                                NZ_Coach__c=c.NZ_Coach__c,
                                Disability_Sector_News__c=c.Disability_Sector_News__c,
                                Healthy_Active_Learning__c=c.Healthy_Active_Learning__c,
                                Healthy_Active_Quarterly__c=c.Healthy_Active_Quarterly__c,
                                Active_Recreation__c = c.Active_Recreation__c
                               
                            ));
                            system.debug('Inside if to chk duplicates & update');
                            
                        }
                    }
                    else if(c.Balance_is_Better__c && c.RecordTypeId==publicRecordTypeId)
                    {
                        
                        system.debug('***INSIDE duplicateSubscriberMap bib true condition');
                        if(duplicateSubscriberMap.get(c.Email_Address__c).Tags__c!=null){
                            system.debug('inside tag..not null');
                            List < String > maptagsval = duplicateSubscriberMap.get(c.Email_Address__c).Tags__c.split(',');
                            system.debug('***duplicateSubscriberMap maptagsval : '+maptagsval);
                            String tags=duplicateSubscriberMap.get(c.Email_Address__c).Tags__c;
                            system.debug('String tags : '+tags);
                            Boolean result;
                            if(c.Tags__c!=null){
                                System.debug('trigger new : '+c.Tags__c);
                                if(maptagsval.size()>0){
                                    if(tags!=null){
                            		result=tags.contains(c.Tags__c);
                                        if(!result){
                                            system.debug('in if duplicateSubscriberMap....');
                                           c.Tags__c = c.Tags__c + ',' + tags; 
                                        }
                                       else{
                                            system.debug('in else duplicateSubscriberMap.....');
                                            c.Tags__c=tags;
											}
                                    }
                                   
                                }
                            }
                        }
                       
                        
                        if(duplicateSubscriberMap.get(c.Email_Address__c).HiddenTag__c !=null){
                        	system.debug('inside tag..not null HiddenTag__c');
                            List < String > maptagsval = duplicateSubscriberMap.get(c.Email_Address__c).HiddenTag__c.split(',');
                            system.debug('***duplicateSubscriberMap maptagsval HiddenTag__c : '+maptagsval);
                            String tags=duplicateSubscriberMap.get(c.Email_Address__c).HiddenTag__c;
                            Boolean result;
                            if(c.HiddenTag__c!=null){
                                System.debug('trigger new HiddenTag__c : '+c.HiddenTag__c);
                                if(maptagsval.size()>0){
                                    if(tags!=null){
                            		result=tags.contains(c.HiddenTag__c);
                                        if(!result){
                                            system.debug('in if duplicateSubscriberMap HiddenTag__c....'); 
                                           c.HiddenTag__c = c.HiddenTag__c + ',' + tags; 
                                        }
                                       else{
                                            system.debug('in else duplicateSubscriberMap HiddenTag__c.....');
                                            c.HiddenTag__c=tags;
											}
                                    }
                                   
                                }
                            }
                        
                        
                        }
                        
                        
                        
                        if(duplicateSubscriberMap.get(c.Email_Address__c).Click_Location__c!=null){
                            c.Click_Location__c = duplicateSubscriberMap.get(c.Email_Address__c).Click_Location__c;
                        }
                        if(duplicateSubscriberMap.get(c.Email_Address__c).Signup_Type__c!=null){
                            c.Signup_Type__c = duplicateSubscriberMap.get(c.Email_Address__c).Signup_Type__c;	
                        }
                        
                        /* if(duplicateSubscriberMap.get(c.Email_Address__c).HiddenTag__c!=null){
                            c.HiddenTag__c = duplicateSubscriberMap.get(c.Email_Address__c).HiddenTag__c;
                        }*/
                        
                        if(duplicateSubscriberMap.get(c.Email_Address__c).iseGuide__c==true && c.iseGuide__c != false){
                            c.iseGuide__c = duplicateSubscriberMap.get(c.Email_Address__c).iseGuide__c;
                        }
                        
                        if(c.youth_sport_options__c!=null)
                            c.Youth_sport_options__c=c.youth_sport_options__c.replaceAll(',',';');
                        duplicateSubscriberMap.get(c.Email_Address__c).isDuplicate__c = true;
                        subList.add(duplicateSubscriberMap.get(c.Email_Address__c));
                    }
                    
                }
                if (subList.size() > 0) {
                    system.debug('in insert update');
                    //update subList;
                }
            }
        }
    }
    
    public static void updatedfunction(Subscriber__c sub, Subscriber__c oldsub) 
	{
		Id publicRecordTypeIdInSet = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Public').getRecordTypeId();
		System.debug('Printing Sub *** :'+sub);
		if(sub.Balance_is_Better__c==true && sub.RecordTypeId==publicRecordTypeIdInSet)
		{



			System.debug('Outside sub.HiddenTag__c :' + sub.HiddenTag__c);
			System.debug('Outside oldsub.HiddenTag__c :' + oldsub.HiddenTag__c);
            //String hidden_tags=
            String tags=oldsub.HiddenTag__c;
             Boolean result;
			if (sub.HiddenTag__c != null)
			{
                if(tags!=null)
                {
                    System.debug('tags : '+tags);
                    result=tags.contains(sub.HiddenTag__c);
                    system.debug('***result '+result);
                }
                List < String > oldtags=new List<String>();
                if(oldsub.HiddenTag__c!=null){
               	 oldtags = oldsub.HiddenTag__c.split(',');
                }
                for (String tag: oldtags) 
                {
                    if(!result)
                    {
                        system.debug('in if....');
                        sub.HiddenTag__c= sub.HiddenTag__c+ ',' + tag; 
                    }
                    else
                    {
                        system.debug('in else.....');
                        sub.HiddenTag__c=tags;
                    }
                }
               /* if (oldsub.HiddenTag__c != null) 
                {
                    System.debug('tags : '+oldsub.HiddenTag__c);
                    result=tags.contains(sub.HiddenTag__c);
                    system.debug('***result '+result);
                }
				if (oldsub.HiddenTag__c != null) 
				{
					
					
					System.debug('sub.HiddenTag__c :' + sub.HiddenTag__c);
					System.debug('oldsub.HiddenTag__c :' + oldsub.HiddenTag__c);
					List < String > oldtags = oldsub.HiddenTag__c.split(',');
					for (String tag: oldtags) 
					{
						System.debug('sub.HiddenTag__c :' + sub.HiddenTag__c);
							
						if (!sub.HiddenTag__c.contains(tag)) 
						{
							System.debug('tag :' + tag);
							sub.HiddenTag__c = sub.HiddenTag__c + ',' + tag;
						}

					}
					System.debug('sub.HiddenTag__c :' + sub.HiddenTag__c);

				} 
				else 
				{
					sub.HiddenTag__c = sub.HiddenTag__c;
				}*/
			}

		}
	}
    
    /*   public static void updatedfunction(Subscriber__c sub, Subscriber__c oldsub) {
Id publicRecordTypeIdInSet = Schema.SObjectType.Subscriber__c.getRecordTypeInfosByName().get('Public').getRecordTypeId();

if(sub.Balance_is_Better__c==true && sub.RecordTypeId==publicRecordTypeIdInSet){



System.debug('Outside sub.HiddenTag__c :' + sub.Tags__c);
System.debug('Outside oldsub.HiddenTag__c :' + oldsub.Tags__c);
if (sub.HiddenTag__c != null) {
	if (oldsub.HiddenTag__c != null) 
	{
//oldsub.Tags__c=oldsub.Tags__c.split(',');
		System.debug('sub.HiddenTag__c :' + sub.HiddenTag__c);
		System.debug('oldsub.HiddenTag__c :' + oldsub.HiddenTag__c);
        List < String > oldtags = oldsub.HiddenTag__c.split(',');
        for (String tag: oldtags) {
        System.debug('sub.HiddenTag__c :' + sub.HiddenTag__c);
        
        if (!sub.HiddenTag__c.Contains(tag)) 
		{
        	System.debug('tag :' + tag);
        	sub.HiddenTag__c = sub.HiddenTag__c + ', ' + tag;
		}

	}
System.debug('sub.HiddenTag__c :' + sub.HiddenTag__c);

} 
else {
	sub.HiddenTag__c = sub.HiddenTag__c;
	}
  }

}
}*/
    
}