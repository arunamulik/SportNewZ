public class ActivityOnboardingLandingPageController {
   /* @AuraEnabled 
    public static Boolean getCommunityAccess() {
       List<PermissionSetAssignment> pset = [SELECT AssigneeId,PermissionSet.Name 
                                             FROM PermissionSetAssignment WHERE PermissionSet.Name = 'No_Maori_Initiatives' 
                                             and AssigneeId =: UserInfo.getUserId()];
           system.debug('pset==>'+pset);
           if(pset.size() > 0) {
                    return true;
           }
       return false;
    }
    @AuraEnabled 
    public static Boolean getTWRCommunityAccess() {
       List<PermissionSetAssignment> pset = [SELECT AssigneeId,PermissionSet.Name 
                                             FROM PermissionSetAssignment WHERE PermissionSet.Name = 'Te_Whetu_Rehua' 
                                             and AssigneeId =: UserInfo.getUserId()];
           system.debug('pset==>'+pset);
           if(pset.size() > 0) {
                    return true;
           }
       return false;
    }*/
    
    
    @AuraEnabled 
    public static Integer getDueDate(){ 
         RULconfigurations__c  customsettingdate =[select Due_Date_For_End_Year_Report__c,Due_Date_For_Planned_Activities__c from RULconfigurations__c];
        Date actyear=customsettingdate.Due_Date_For_End_Year_Report__c;
        Integer newactyear=actyear.year();
        return newactyear;
        
    }
    
    
    @AuraEnabled 
    public static String getlistvalue(Integer fyear){
    	
		String pickListValuesList;
        String nfyear=String.valueOf(fyear);
		Schema.DescribeFieldResult fieldResult = Activity__c.FilterByYear__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple){
            if(pickListVal.getValue()==nfyear)
				pickListValuesList=pickListVal.getValue();
		}     
		return pickListValuesList;
        
    }
    
    
    @AuraEnabled 
    public static String fetchUser(){
        User u = [select id,Name,FirstName  from User where id =: userInfo.getUserId()];
        
        List<Activity__c> relatedUsersActivity = [SELECT Id, OwnerId, Name, HOP_Outcome__c FROM Activity__c where OwnerId =: u.id];
        system.debug('8==>'+relatedUsersActivity);
        
        String returnData = u.FirstName+':'+relatedUsersActivity.Size();
        
        return returnData;
    }
    
    //Commenting for new solution
    /*@AuraEnabled 
    public static String fetchUser1(String fy){
        User u = [select id,Name,FirstName  from User where id =: userInfo.getUserId()];
        Integer fyear = integer.valueOf(fy);
        List<Activity__c> relatedUsersActivity = [SELECT Id, OwnerId, Name, HOP_Outcome__c,	StartYear__c  FROM Activity__c where OwnerId =: u.id AND CALENDAR_YEAR(Activity_Start_Date_Time__c )=:fyear];
        system.debug('8==>'+relatedUsersActivity);
        
        String returnData = u.FirstName+':'+relatedUsersActivity.Size();
        
        return returnData;
    }*/
    //till above

    
    @AuraEnabled 
    public static String getVideoOrImage(){
        Landing_Page_Image_Video__c landingPageBG = [SELECT Id, Embed_Video__c, Background_Image__c, Partner_Logo__c FROM Landing_Page_Image_Video__c];
        system.debug('17==>'+landingPageBG.Background_Image__c);
        return landingPageBG.Embed_Video__c+'==>'+landingPageBG.Background_Image__c +'==>'+landingPageBG.Partner_Logo__c;
    }
    
    @AuraEnabled
    public static Activity__c saveActivity (Activity__c act) {
        system.debug('>>>24>>'+act);
        List<Activity__c> lstAct = new List<Activity__c>();
        lstAct.add(act);
        system.debug('27==>'+lstAct);
        
        upsert act;
        return act;
    }
    @AuraEnabled
    public static void deleteSelectedActivity (boolean isDelete, string id) {
        List<Activity__c> lstAct = [select Id,Is_Activity_Deleted__c from Activity__c where Id=:id];
        system.debug('27==>'+lstAct);
        lstAct[0].Is_Activity_Deleted__c =isDelete;
        update lstAct;
        //delete lstAct;
    }
    @AuraEnabled
    public static void activityClone (string id) {
        Activity__c lstActivity = [select Name,HOP_Outcome__c,COVID_19_ALERT_LEVEL__c,HOP_Outcome_Domain__c,
        Description__c,Expectations_of_Impact__c,Event_Organiser_First_Name__c,Event_Organiser_Last_Name__c,
        Event_Organiser_Email__c, Event_Description__c,Activity_Start_Date_Time__c, Activity_End_Date_Time__c,
        Street__c,City__c,State__c,Country__c,Latitude__c,Longitude__c,Region__c,DiamensionBy_DescRichText__c, 
        DiamensionFor_DescRichText__c, DiamensionInOn_DescRichText__c, DiamensionThrough_DescRichText__c,
        DiamensionWith_DescRichText__c
         from Activity__c where Id= :id LIMIT 1];
         system.debug('lstAct : '+lstActivity);
         if (lstActivity != null) {
            Activity__c clonedRecord = new Activity__c();
            //clonedRecord.Field1__c = originalRecord.Field1__c;
            clonedRecord.Name = 'COPY '+lstActivity.Name;
            clonedRecord.HOP_Outcome__c=lstActivity.HOP_Outcome__c;
            clonedRecord.COVID_19_ALERT_LEVEL__c=lstActivity.COVID_19_ALERT_LEVEL__c;
            clonedRecord.HOP_Outcome_Domain__c=lstActivity.HOP_Outcome_Domain__c;
            clonedRecord.Description__c=lstActivity.Description__c;
            clonedRecord.Expectations_of_Impact__c=lstActivity.Expectations_of_Impact__c;
            clonedRecord.Event_Organiser_First_Name__c=lstActivity.Event_Organiser_First_Name__c;
            clonedRecord.Event_Organiser_Last_Name__c=lstActivity.Event_Organiser_Last_Name__c;
            clonedRecord.Event_Organiser_Email__c=lstActivity.Event_Organiser_Email__c;
            clonedRecord.Event_Description__c=lstActivity.Event_Description__c;
            clonedRecord.Activity_Start_Date_Time__c=lstActivity.Activity_Start_Date_Time__c;
            clonedRecord.Activity_End_Date_Time__c=lstActivity.Activity_End_Date_Time__c;
            clonedRecord.Street__c=lstActivity.Street__c;
            clonedRecord.City__c=lstActivity.City__c;
            clonedRecord.State__c=lstActivity.State__c;
            clonedRecord.Country__c=lstActivity.Country__c;
            clonedRecord.Latitude__c=lstActivity.Latitude__c;
            clonedRecord.Longitude__c=lstActivity.Longitude__c;
            clonedRecord.Region__c=lstActivity.Region__c;
            clonedRecord.DiamensionBy_DescRichText__c=lstActivity.DiamensionBy_DescRichText__c;
             clonedRecord.DiamensionFor_DescRichText__c=lstActivity.DiamensionFor_DescRichText__c;
             clonedRecord.DiamensionInOn_DescRichText__c=lstActivity.DiamensionInOn_DescRichText__c;
             clonedRecord.DiamensionThrough_DescRichText__c=lstActivity.DiamensionThrough_DescRichText__c;
             clonedRecord.DiamensionWith_DescRichText__c=lstActivity.DiamensionWith_DescRichText__c;
            insert clonedRecord; // Insert the cloned record to save it as a new record
        }
    }
    @AuraEnabled
    public static Activity__c activityYearCheck (string id,String previousYear,String ThisYear) {
        Activity__c lstActivity = [select Id,Name,Due_Date__c from Activity__c where Id= :id LIMIT 1];
        Integer activityYear=lstActivity.Due_Date__c.year();
       // Integer yearValue = DateUtility.getYearFromDate(lstActivity.Due_Date__c);
       // String yearString = String.valueOf(activityYear);
       if( String.valueOf(activityYear)==previousYear ||String.valueOf(activityYear)==ThisYear){
            return lstActivity;
        }
        else{
            return null;
        }
    }
    @AuraEnabled
    public static Activity__c SaveChangeReqandMail (Activity__c act) {
        List<Activity__c> lstAct = new List<Activity__c>();
        lstAct.add(act);
        //system.debug('27==>'+lstAct);
        for(Activity__c ac : lstAct){
            
        }
        upsert act;
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendEmailTo = new List<String>();
        String userName = UserInfo.getUserName();
        Id usrId=UserInfo.getUserId();
        system.debug('userName'+userName);
        User activeUser = [SELECT Email,Name FROM User WHERE Id= :usrId];
        Activity__c accList = [select id,Change_Request_Reason__c from Activity__c where Activity__c.Name = 'Test 2'];
        String userEmail = 'tushar.shinde@aress.com';
        sendEmailTo.add(userEmail);
        mail.setToAddresses(sendEmailTo);
        mail.setReplyTo(userEmail);
        mail.setSubject('Mail Regarding Change Request');
        string body = '<html><body>';
        body +='<br> Change Request';
        body += '<br>' ;
        body += activeUser.Name;
        body += '<br>';
        body += accList.Change_Request_Reason__c;
        body += '</body></html>';
        mail.setHtmlBody(body);
        mails.add(mail);
        Messaging.sendEmail(mails);
        
        /*  List<Approval.ProcessSubmitRequest> lstprocess=new List<Approval.ProcessSubmitRequest>();
if(accList.Raraunga_Kaunga_Question1__c !=Null)
{
approval.ProcessSubmitRequest aprlPrcs = new Approval.ProcessSubmitRequest();     
aprlPrcs .setComments('Submitting record for approval.');
aprlPrcs.setObjectId(accList.id);
lstprocess.add(aprlPrcs);
}
List<Approval.ProcessResult> resultlist = Approval.process(lstprocess);*/ 
        return act;
    }
    
    
    
    @AuraEnabled        
    public static Map<String, List<Activity__c>> getselectOptions(String objectType, String fieldName,Integer fyear){
        //system.debug('30==>'+objectType);
        //system.debug('31==>'+fieldName);
        Map<String, List<Activity__c>> mapofHOPact = new Map<String, List<Activity__c>>();
        
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(fieldName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        //system.debug('40==>'+pickListValuesList);
        for(String pickVal : pickListValuesList){
            //system.debug('44=>>'+pickVal);
        }
        List<Activity__c> Addvalues = new List<Activity__c>();
        List<Activity__c> act = [select id,Name,HOP_Outcome__c, Due_Date__c, Description__c, Expectations_of_Impact__c,Change_Request_Reason__c,
                                 By_OrgGoverned__c,
                                 Is_Read_Only__c,
                                 Region__c,
                                 //Initiative__c,
                                 COVID_19_ALERT_LEVEL__c,
                                 HOP_Outcome_Domain__c,
                                 By_ActivityGMDgoverned__c, 
                                 By_ActivityGMDmanaged__c,
                                 By_ActivityGMDdelivered__c, 
                                 Participation_NoOfParticipants__c,
                                 Particaipation_WhanauType_Marae__c,
                                 Particaipation_WhanauType_Hapu__c,
                                 Particaipation_WhanauType_lwi__c,
                                 Particaipation_WhanauType_Wh_nau__c,
                                 Particaipation_WhanauType_Waka__c,
                                 Particaipation_WhanauType_KohangaPunaReo__c,
                                 Particaipation_WhanauType_Kura_Kaupapa__c,
                                 Particaipation_WhanauType_Whare_Kura__c,
                                 Particaipation_WhanauType_Whare_Wananga__c,
                                 Particaipation_WhanauType_Kaupapa_H_kina__c	,
                                 Particaipation_WhanauType_Other__c,
                                 NoOfGroups_Marae__c,
                                 NoOfGroups_Hapu__c,
                                 NoOfGroups_Iwi__c,
                                 NoOfGroups_Wh_nau__c,
                                 NoOfGroups_Waka__c,
                                 NoOfGroups_KohangaPuna__c,
                                 NoOfGroups_Kura_Kaupapa__c,
                                 NoOfGroups_Whare_Kura__c,
                                 NoOfGroups_Whare_Wananga__c,
                                 NoOfGroups_Kaupapa_H_kinakina__c,
                                 NoOfGroups_Other__c,
                                 Through_typeActNgaTaonga__c,
                                 Through_TypeActNgaKemu__c,
                                 Through_TypeActNgaMahi__c,
                                 Through_typeActHakinakina__c,
                                 Through_typeActLandO__c,
                                 InOn_LocateActMaunga__c,
                                 InOn_LocateActAwa__c,
                                 InOn_LocateActMarae__c,
                                 InOn_LocateActKohanga__c,
                                 InOn_LocateActKura__c,
                                 InOn_LocateActWahi__c,
                                 InOn_LocateActSRC__c,
                                 InOn_LocateActSRC2__c,
                                 InOn_SignificanceLocation__c,
                                 With_UseOfTeReo__c,
                                 With_PrposeTeReoAwareness__c,
                                 With_PrposeTeReaoKnowledge__c,
                                 With_PrposeTeReaoExtendAct__c,
                                 With_PrposeTeReaoOther__c,
                                 With_PrposeTeRaoIntegral__c,
                                 With_SignificanceTeRao__c,
                                 With_PrposeTikangaRaiseAwareness__c,
                                 With_PrposeTikangaBuildKnowledge__c,
                                 With_PrposeTikangaOppApply__c,
                                 With_PrposeTikangaOther__c,
                                 With_PrposeTikangaIntegral__c,
                                 With_SigniOfTikanga__c,
                                 Particaipation_WhanauType_Total__c,
                                 NoOfGroups_Total__c,
                                 AgeOfParticipants_Mokopuna__c,
                                 AgeOfParticipants_Taiohi__c,
                                 AgeOfParticipants_Rangatahi13_15__c,
                                 AgeOfParticipants_Rangatahi16_19__c,
                                 AgeOfParticipants_Pakeke_20_39__c,
                                 AgeOfParticipants_Pakeke40_59__c,
                                 AgeOfParticipants_Kaum_tua__c,
                                 AgeOfParticipants_DidNotRespond__c,
                                 AgeOfParticipants_Total__c,
                                 GenderOfParticipants_Tane__c,
                                 GenderOfParticipants_Wahine__c,
                                 GenderOfParticipants_DidNotRespond__c,
                                 GenderOfParticipants_Total__c,
                                 EthnicityOfParticipants_M_ori__c,
                                 EthnicityOfParticipants_Non_M_ori__c,
                                 EthnicityOfParticipants_DidNotRespond__c,
                                 EthnicityOfParticipants_Total__c,
                                 DiamensionBy_DescRichText__c,
                                 DiamensionThrough_DescRichText__c,
                                 DiamensionInOn_DescRichText__c,
                                 DiamensionWith_DescRichText__c,
                                 DiamensionFor_DescRichText__c,
                                 Diamension_By_Score__c,
                                 Diamension_Thorugh_Score__c,
                                 Diamension_InOn_Score__c,
                                 Diamension_With_Score__c,
                                 Diamension_For_Score__c,
                                /* Completed_Date__c, Raraunga_Kaunga_Question1__c,
                                 Raraunga_Kaunga_Question2__c,
                                 Raraunga_Kaunga_Question3__c,
                                 Raraunga_Kaunga_Question4__c,
                                 Raraunga_Kaunga_Question5__c,
                                 Save_and_Complete_Question1__c,
                                 Save_and_Complete_Question2__c,
                                 Save_and_Complete_Question3__c,
                                 Save_and_Complete_Question4__c,
                                 Save_and_Complete_Question5__c,*/
                                 Is_Activity_Deleted__c
                                 from Activity__c 
                                 where HOP_Outcome__c !=null 
                                 AND Is_Activity_Deleted__c=false
                                AND CALENDAR_YEAR(Due_Date__c )=:fyear];
        system.debug('48==>'+act);
        if(!act.isEmpty()){
              
            for(Activity__c c:act){
                
        if(c.Participation_NoOfParticipants__c == null){
            c.Participation_NoOfParticipants__c=0;
        }
         if(c.Particaipation_WhanauType_Marae__c == null){
            c.Particaipation_WhanauType_Marae__c=0;
        }
         if(c.Particaipation_WhanauType_Hapu__c == null){
            c.Particaipation_WhanauType_Hapu__c=0;
        }
         if(c.Particaipation_WhanauType_lwi__c == null){
            c.Particaipation_WhanauType_lwi__c=0;
        }
         if(c.Particaipation_WhanauType_Wh_nau__c == null){
            c.Particaipation_WhanauType_Wh_nau__c=0;
        }
         if(c.Particaipation_WhanauType_KohangaPunaReo__c == null){
            c.Particaipation_WhanauType_KohangaPunaReo__c=0;
        }
         if(c.Particaipation_WhanauType_Kura_Kaupapa__c == null){
            c.Particaipation_WhanauType_Kura_Kaupapa__c=0;
        }
         if(c.Particaipation_WhanauType_Whare_Kura__c == null){
            c.Particaipation_WhanauType_Whare_Kura__c=0;
        }
         if(c.Particaipation_WhanauType_Whare_Wananga__c == null){
            c.Particaipation_WhanauType_Whare_Wananga__c=0;
        }
         if(c.Particaipation_WhanauType_Kaupapa_H_kina__c == null){
            c.Particaipation_WhanauType_Kaupapa_H_kina__c=0;
        }
         if(c.Particaipation_WhanauType_Other__c == null){
            c.Particaipation_WhanauType_Other__c=0;
        }
         if(c.AgeOfParticipants_Mokopuna__c == null){
            c.AgeOfParticipants_Mokopuna__c=0;
        }
         if(c.AgeOfParticipants_Taiohi__c == null){
            c.AgeOfParticipants_Taiohi__c=0;
        }
         if(c.AgeOfParticipants_Rangatahi13_15__c == null){
            c.AgeOfParticipants_Rangatahi13_15__c=0;
        }
         if(c.AgeOfParticipants_Rangatahi16_19__c == null){
            c.AgeOfParticipants_Rangatahi16_19__c=0;
        }
         if(c.AgeOfParticipants_Pakeke_20_39__c == null){
            c.AgeOfParticipants_Pakeke_20_39__c=0;
        }
         if(c.AgeOfParticipants_Pakeke40_59__c == null){
            c.AgeOfParticipants_Pakeke40_59__c=0;
        }
         if(c.AgeOfParticipants_Kaum_tua__c == null){
            c.AgeOfParticipants_Kaum_tua__c=0;
        }
         if(c.AgeOfParticipants_DidNotRespond__c == null){
            c.AgeOfParticipants_DidNotRespond__c=0;
        }
         if(c.GenderOfParticipants_Tane__c == null){
            c.GenderOfParticipants_Tane__c=0;
        }
         if(c.GenderOfParticipants_Wahine__c == null){
            c.GenderOfParticipants_Wahine__c=0;
        }
         if(c.GenderOfParticipants_DidNotRespond__c == null){
            c.GenderOfParticipants_DidNotRespond__c=0;
        }
         if(c.EthnicityOfParticipants_M_ori__c == null){
            c.EthnicityOfParticipants_M_ori__c=0;
        }
         if(c.EthnicityOfParticipants_Non_M_ori__c == null){
            c.EthnicityOfParticipants_Non_M_ori__c=0;
        }
         if(c.EthnicityOfParticipants_DidNotRespond__c == null){
            c.EthnicityOfParticipants_DidNotRespond__c=0;
        }
                 
                //system.debug('55======>'+c.By_ActivityGMDdelivered__c);
                if(!mapofHOPact.containsKey(c.HOP_Outcome__c)){
                    Addvalues = new List<Activity__c>();
                    Addvalues.add(c);
                    mapofHOPact.put(c.HOP_Outcome__c,Addvalues);
                    system.debug('54==>'+mapofHOPact);
                }else{
                    Addvalues = new List<Activity__c>();
                    Addvalues =  mapofHOPact.get(c.HOP_Outcome__c);  
                    Addvalues.add(c);
                    mapofHOPact.put(c.HOP_Outcome__c,Addvalues);
                    system.debug('59==>'+mapofHOPact);
                }
            }return mapofHOPact;
        }
        else{
            /*for(String pickVal : pickListValuesList){
                mapofHOPact.put(pickVal, Addvalues);*/
            return null;
            }
        }
        //System.debug('mapofHOPact=====>'+mapofHOPact);
        // return mapofHOPact;
        //return pickListValuesList;
    
    
    
    @AuraEnabled        
    public static List<String> getselectOption(String objectType, String fieldName){
        
        
       system.debug('60==>'+objectType);
        system.debug('61==>'+fieldName);
        
        
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(fieldName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            //pickListValuesList.add(pickListVal.getLabel());
            pickListValuesList.add(pickListVal.getValue());
        }     
        system.debug('328=====>'+pickListValuesList);
        return pickListValuesList;
    }
    
    
  /*@AuraEnabled        
    public static List<String> getselectOptionForCovid(String objectType, String fieldName){
        
        
       system.debug('60==>'+objectType);
        system.debug('61==>'+fieldName);
        
        
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(fieldName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            //pickListValuesList.add(pickListVal.getLabel());
            pickListValuesList.add(pickListVal.getValue());
        }     
        system.debug('328=====>'+pickListValuesList);
        return pickListValuesList;
    }  
    */
    @AuraEnabled        
    public static Activity__c showSelectedActivity(string id){
        //system.debug('71==>'+id);
        Activity__c actSelected = [select id, Name, HOP_Outcome__c, Due_Date__c, Description__c, Expectations_of_Impact__c, By_OrgGoverned__c, 
                                   By_ActivityGMDgoverned__c, By_ActivityGMDmanaged__c,COVID_19_ALERT_LEVEL__c,HOP_Outcome_Domain__c,
                                   By_ActivityGMDdelivered__c, Participation_NoOfParticipants__c,DiamensionBy_DescRichText__c,
                                   DiamensionThrough_DescRichText__c,
                                   DiamensionInOn_DescRichText__c,
                                   DiamensionWith_DescRichText__c,
                                   DiamensionFor_DescRichText__c,
                                   Diamension_By_Score__c,
                                   Diamension_Thorugh_Score__c,
                                   Diamension_InOn_Score__c,
                                   Diamension_With_Score__c,Diamension_For_Score__c,
                                   Event_Organiser_First_Name__c,
								   Event_Organiser_Last_Name__c,
								   Event_Organiser_Email__c,
								   Event_Description__c,
								   Activity_Start_Date_Time__c,
								   Activity_End_Date_Time__c,
                                   Street__c,
								   City__c,	
								   State__c,
								   Country__c,
								   Latitude__c,
								   Longitude__c,
								   Region__c,
                                  /* Completed_Date__c,Raraunga_Kaunga_Question1__c,Raraunga_Kaunga_Question2__c,Raraunga_Kaunga_Question3__c,
                                   Raraunga_Kaunga_Question5__c,Raraunga_Kaunga_Question4__c,Save_and_Complete_Question1__c,
                                   Save_and_Complete_Question2__c,
                                   Save_and_Complete_Question3__c,
                                   Save_and_Complete_Question4__c,
                                   Save_and_Complete_Question5__c,*/Change_Request_Reason__c
                                   from Activity__c where id =: id];
        //system.debug('73==>'+actSelected);
        return actSelected;
    }
    
    @AuraEnabled 
    public static List<String> getbyOrgGovernedPicklist(String objectType, String fieldName){
        
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(fieldName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        system.debug('40==>'+pickListValuesList);
        for(String pickVal : pickListValuesList){
            system.debug('44=>>'+pickVal);
        }
        return pickListValuesList;
    }
    @AuraEnabled 
    public static list<StaticResource> fetchstatic_resource(){
        list<StaticResource> static_resource = new list<StaticResource>([SELECT Name FROM StaticResource]);
        System.debug('sdgdgfffffffffff'+static_resource);
        return static_resource;
    }
    
    @AuraEnabled 
    public static Boolean isUserHasActivities(){
        List<Activity__c> activity = [SELECT id,Name,OwnerId,Is_Activity_Deleted__c FROM Activity__c WHERE OwnerId =: UserInfo.getUserId() AND Is_Activity_Deleted__c=false];
        if(activity.size() > 0){ 				            
            return true;
        } else{
            return false;	  
        }
    }
    @AuraEnabled
    public static List<String> getHOPoutcomePicklist(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Activity__c.HOP_Outcome__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
    
   /* @AuraEnabled
    public static void enddateassign(List<Activity__c> activityList){
         
        Set<Id> initiativeId = new Set<Id>();
       for(Activity__c b : activityList) {
           if(b.Initiative__c != null) {
           	 initiativeId.add(b.Initiative__c);
           }
       }
        
        if(initiativeId.size()>0) {
                Map<Id,Date> dueDates = new Map<Id,Date>();
            for(Initiative__c duedate :  [select id,name, End_Date__c from Initiative__c where Id IN:initiativeId]){
               dueDates.put(duedate.Id,duedate.End_Date__c); 
            }
            
            for(Activity__c b : activityList) {
                if(dueDates.get(b.Initiative__c) != null){
                    b.Due_Date__c = dueDates.get(b.Initiative__c); 
                } 
            }
        }

    }*/
    @AuraEnabled 
    public static Account fetchBGImage(){
                      
             User  contactIds = [select Id,ContactId from User where ContactId != null and  Id =: userInfo.getUserId()];//ContactId !=: null and        
             //system.debug('contactId==>'+contactIds.ContactId);        
            Contact AccountIds =  [select Id,AccountId from Contact where AccountId != null and Id =: contactIds.ContactId];//AccountId != null and        
           // system.debug('AccountIds==>'+AccountIds);      
            return [select Landing_Hero_Image__c from Account where Id =: AccountIds.AccountId];    
    }
    @AuraEnabled 
    public static Default_Hero_Image_url__c fetchDefaultBGImage(){
                           
            return [select Landing_Hero_Image__c from Default_Hero_Image_url__c];    
    }
    @AuraEnabled 
    public static String getContact(){              
        User  contactIds = [select Id,ContactId from User where ContactId != null and  Id =: userInfo.getUserId()];
        Contact UserContact=  [select id,name,FirstName From Contact where id=:contactIds.ContactId];
        return UserContact.FirstName;
    }
    
    @AuraEnabled 
    public static String getCurrentContact(String id){              
        User  contactIds = [select Id,ContactId from User where Id =:id];
        Contact UserContact=  [select id,name,FirstName From Contact where id=:contactIds.ContactId];
        return UserContact.name;
    }
     @AuraEnabled 
    public static boolean isDueDatePassed(){ 
         RULconfigurations__c  customsettingdate =[select Due_Date_For_End_Year_Report__c,Due_Date_For_Planned_Activities__c from RULconfigurations__c];
        if(customsettingdate.Due_Date_For_End_Year_Report__c < system.today() || customsettingdate.Due_Date_For_Planned_Activities__c < system.today()){
        return false;
        }
        return true;
    }
    @AuraEnabled 
    public static String userProfilePhoto(){
       User  userIds = [SELECT Id,FullPhotoUrl FROM User where Id =: userInfo.getUserId()];
        return userIds.FullPhotoUrl;
    }

    // Added by HP
     /**
    * @description : Auto suggestion Web Service 
    * @param : input: SearchAddress , types: Results Types , langug : language for getting the      results
    * @return : string
    **/  
    @AuraEnabled
    public static string getSuggestionsCommunity(String input) {
       String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
                    + 'input=' + EncodingUtil.urlEncode(input, 'UTF-8')
            + getKeyCommunity();   
      
        String response = getResponseCommunity(url); 
        system.debug('Response suggestions***'+response);
        return response;
    }
    
     /**
    * @description : Place Details Web Service 
    * @param : PlaceId: Unique Place Id , langug : language for getting the results
    * @return : string
    **/ 
    @AuraEnabled
    public static string getPlaceDetailsCommunity(String placeId) {
        String url = 'https://maps.googleapis.com/maps/api/place/details/json?'
            + 'placeid=' + EncodingUtil.urlEncode(placeId, 'UTF-8')
            + getKeyCommunity(); 
        String response = getResponseCommunity(url);
        system.debug('Response places****'+response);
        return response;
    }
    
      /**
    * @description : Common Utility method for making call out
    * @param : String
    * @return : string
    **/
    
    public static string getResponseCommunity(string strURL){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setMethod('GET');
        req.setEndpoint(strURL);
        req.setTimeout(120000);
        res = h.send(req); 
        String responseBody = res.getBody(); 
        system.debug('responseBody---'+responseBody);
        return responseBody; 
    }
    
     /**
    * @description : To get the google Api key from custom label
    * @param : 
    * @return : string
    **/
    public static string getKeyCommunity(){
        /*Enter your API key here*/
        string key = 'AIzaSyAajWqoSfSuucFmBfC-fyMOeulDS2L2QyA';
            string output = '&key=' + key;   
        return output;
    }
    
    @AuraEnabled
    public static string getAddressCommunity(String dealId ,String street, String city , String state, String country,string zip, string latitude, string longitude){
    	
    	Activity__c activity = new Activity__c();
    	warpper wrap = new warpper();
    	if(dealId != null){
    		try{
    			activity = [select id,Street__c,City__c,Country__c,State__c,Latitude__c, Longitude__c from Activity__c where id=: dealId];
    			activity.State__c = state;
    			activity.Country__c = country;
    			activity.City__c = city;
                //activity.Property_Zip_Postal_Code__c = zip;
                activity.Street__c = street;
                activity.Latitude__c = latitude;
                activity.Longitude__c = longitude;
    			update activity;
    			system.debug('*****Successfully updated the Deal');
    			
                wrap.isSuccess = true;
    		}catch(Exception e){
                wrap.isSuccess = false;
                wrap.errormessage = e.getMessage().substringAfter(',');
    			system.debug('Exception**'+e.getLinenumber());
    		}
    	}
    	return JSON.serialize(wrap);
    } 
    
    @AuraEnabled
    public static boolean getOppStageCommunity(String oppId){
    	List<Opportunity> opplist = new List<Opportunity>();
    	Boolean notstage ; 
    	if(oppId != null){
    		opplist = [select id , StageName from Opportunity where id=: oppId];
    		if(opplist[0].StageName == '06 - Mortgage Booked'){
    			notstage = true;
    		}else{
    			notstage = false;
    		}
    	}
    	return notstage;
    }
    
    public class warpper{
        @AuraEnabled
        public boolean isSuccess{get;set;}
        
        @AuraEnabled
        public String errormessage{get;set;}
    }
}