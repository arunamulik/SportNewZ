/********************************************************************************************
Name:           MFITGetActivity
Author:         RUL
Purpose:        This is REST web service class used by MFIT to get list of MFIT Activities
Created Date:   5 May 2021
Modification History:
<initials> -     <date>   -     <reason for update>
*********************************************************************************************/
@RestResource(urlMapping = '/MFITGetActivity/*')
global with sharing class MFITGetActivity {
    private static final String RESPONSE_SUCCESS = 'Success';
    private static final String RESPONSE_ERROR = 'Error';
    
    @httpget
    global static List < ActivityList > getMFITActivityList() {
        List < ActivityList > activityList = new List < ActivityList > ();
        List < Activity__c > result=new List<Activity__c>();
        String endDate;
        RestRequest restReq = RestContext.request;
        endDate = restReq.params.get('activityEndDate');
        if(endDate==null){
            result = [SELECT Id,
                      Name,
                      Organisation__r.Name,
                      Email__c,
                      Description__c,
                      Region__c,
                      Activity_Start_Date_Time__c,
                      Activity_End_Date_Time__c,
                      Event_Organiser_First_Name__c,
                      Event_Organiser_Last_Name__c,
                      Event_Organiser_Email__c,
                      Event_Organiser_Mobile_Number__c,
                      Owner.FirstName,
                      Owner.LastName,
                      Display_on_MaraeFit_App__c,
                      CreatedDate,
                      LastModifiedDate,
                      Image_URL__c,
                      Street__c,
                      City__c,
                      State__c,
                      Latitude__c,
                      Longitude__c,
                      Event_Description__c,
                      Participation_NoOfParticipants__c,
                      AgeOfParticipants_DidNotRespond__c,
                      AgeOfParticipants_Mokopuna__c,
                      AgeOfParticipants_Rangatahi13_15__c,
                      AgeOfParticipants_Rangatahi16_19__c,
                      AgeOfParticipants_Rangatahi13_19__c,
                      AgeOfParticipants_Matua_20_39__c,
                      AgeOfParticipants_Pakeke_20_39__c,
                      AgeOfParticipants_Pakeke40_59__c,
                      AgeOfParticipants_Kaum_tua__c,
                      AgeOfParticipants_Taiohi__c
                      FROM
                      Activity__c
                      WHERE
                      Is_Activity_Deleted__c = FALSE AND
                      Activity_End_Date_Time__c >= TODAY
                     ];
        }
        else{
            
        Date actendDate = Date.parse(endDate);
//convert date to DateTime.Can be used in soql but not in dynamic soql(output:2018-01-25 05:00:00)
DateTime actdtAndTime = DateTime.newInstance(actendDate.year(),actendDate.month(),actendDate.day(),0,0,0);
             result = [SELECT Id,
                      Name,
                      Organisation__r.Name,
                      Email__c,
                      Description__c,
                      Region__c,
                      Activity_Start_Date_Time__c,
                      Activity_End_Date_Time__c,
                      Event_Organiser_First_Name__c,
                      Event_Organiser_Last_Name__c,
                      Event_Organiser_Email__c,
                      Event_Organiser_Mobile_Number__c,
                      Owner.FirstName,
                      Owner.LastName,
                      Display_on_MaraeFit_App__c,
                      CreatedDate,
                      LastModifiedDate,
                      Image_URL__c,
                      Street__c,
                      City__c,
                      State__c,
                      Latitude__c,
                      Longitude__c,
                      Event_Description__c,
                      Participation_NoOfParticipants__c,
                      AgeOfParticipants_DidNotRespond__c,
                      AgeOfParticipants_Mokopuna__c,
                      AgeOfParticipants_Rangatahi13_15__c,
                      AgeOfParticipants_Rangatahi16_19__c,
                      AgeOfParticipants_Rangatahi13_19__c,
                      AgeOfParticipants_Pakeke_20_39__c,
                      AgeOfParticipants_Matua_20_39__c,
                      AgeOfParticipants_Pakeke40_59__c,
                      AgeOfParticipants_Kaum_tua__c,
                      AgeOfParticipants_Taiohi__c
                      FROM
                      Activity__c
                      WHERE
                      Is_Activity_Deleted__c = FALSE AND
                      Activity_End_Date_Time__c > :actdtAndTime
                     ];
        }
        
        for (Activity__c act: result) {
            activityList.add(getResponse(act));
        }
        return activityList;
    }
    
    public static ActivityList getResponse(Activity__c act) {
        
        ActivityList objActivity = new ActivityList();
        
        objActivity.RecordID = act.Id;
        objActivity.ActivityName = act.name;
        objActivity.Organisation = act.Organisation__r.Name;
        objActivity.EventOrganiserFirstName = act.Event_Organiser_First_Name__c;
        objActivity.EventOrganiserLastName = act.Event_Organiser_Last_Name__c;
        objActivity.EventOrganiserMobileNumber = act.Event_Organiser_Mobile_Number__c;
        objActivity.EventOrganiserEmail = act.Event_Organiser_Email__c;
        objActivity.OwnerFirstName = act.Owner.FirstName;
        objActivity.OwnerLastName = act.Owner.LastName;
        objActivity.Email = act.Email__c;
        objActivity.Description = act.Description__c;
        objActivity.ActivityStartDateTime = act.Activity_Start_Date_Time__c;
        objActivity.ActivityEndDateTime = act.Activity_End_Date_Time__c;
        objActivity.Location = act.Region__c;
        objActivity.Region = act.Region__c;
        objActivity.DisplayonMaraeFitApp = act.Display_on_MaraeFit_App__c;
        objActivity.CreatedDate = act.CreatedDate;
        objActivity.LastModifiedDate = act.LastModifiedDate;
        objActivity.ImageURL = act.Image_URL__c;
        objActivity.Street = act.Street__c;
        objActivity.City = act.City__c;
        objActivity.State = act.State__c;
        objActivity.Latitude = act.Latitude__c;
        objActivity.Longitude = act.Longitude__c;
        objActivity.EventDescription = act.Event_Description__c;
        if(act.AgeOfParticipants_DidNotRespond__c==null){
            act.AgeOfParticipants_DidNotRespond__c=0;
        }
        if(act.AgeOfParticipants_Kaum_tua__c==null){
            act.AgeOfParticipants_Kaum_tua__c=0;
        }
        if(act.AgeOfParticipants_Mokopuna__c==null){
            act.AgeOfParticipants_Mokopuna__c=0;
        }
        if(act.AgeOfParticipants_Pakeke40_59__c==null){
            act.AgeOfParticipants_Pakeke40_59__c=0;
        }
        if(act.AgeOfParticipants_Pakeke_20_39__c==null){
            act.AgeOfParticipants_Pakeke_20_39__c=0;
        }
        
       if(act.AgeOfParticipants_Matua_20_39__c==null){
            act.AgeOfParticipants_Matua_20_39__c=0;
        }
        if(act.AgeOfParticipants_Rangatahi13_15__c==null){
            act.AgeOfParticipants_Rangatahi13_15__c=0;
        }
        if(act.AgeOfParticipants_Rangatahi13_19__c==null){
            act.AgeOfParticipants_Rangatahi13_19__c=0;
        }
        if(act.AgeOfParticipants_Rangatahi16_19__c==null){
            act.AgeOfParticipants_Rangatahi16_19__c=0;
        }
        if(act.AgeOfParticipants_Taiohi__c==null){
            act.AgeOfParticipants_Taiohi__c=0;
        }
        objActivity.AgeOfParticipantsTotal=Integer.valueOf(act.AgeOfParticipants_DidNotRespond__c  +  act.AgeOfParticipants_Kaum_tua__c  +  act.AgeOfParticipants_Mokopuna__c  +  act.AgeOfParticipants_Pakeke_20_39__c  +  act.AgeOfParticipants_Pakeke40_59__c  +  act.AgeOfParticipants_Rangatahi13_15__c  +  act.AgeOfParticipants_Rangatahi16_19__c  + act.AgeOfParticipants_Taiohi__c+act.AgeOfParticipants_Rangatahi13_19__c); 
        objActivity.Ageofparticipantsdidnotrespond=Integer.valueOf(act.AgeOfParticipants_DidNotRespond__c);
        objActivity.AgeOfParticipantsMokopuna=Integer.valueOf(act.AgeOfParticipants_Mokopuna__c);
        objActivity.AgeOfParticipantsRangatahi13_15=Integer.valueOf(act.AgeOfParticipants_Rangatahi13_15__c);
        objActivity.AgeOfParticipantsRangatahi16_19=Integer.valueOf(act.AgeOfParticipants_Rangatahi16_19__c);
        objActivity.AgeOfParticipantsRangatahi13_19=Integer.valueOf(act.AgeOfParticipants_Rangatahi13_19__c);
        objActivity.AgeOfParticipantsPakeke20_39=Integer.valueOf(act.AgeOfParticipants_Pakeke_20_39__c);
        objActivity.AgeOfParticipants_Matua_20_39=Integer.valueOf(act.AgeOfParticipants_Matua_20_39__c);
        objActivity.AgeOfParticipantsPakeke40_59=Integer.valueOf(act.AgeOfParticipants_Pakeke40_59__c);
        objActivity.AgeOfParticipantsKaumatua=Integer.valueOf(act.AgeOfParticipants_Kaum_tua__c);
        objActivity.AgeOfParticipantsTaiohi=Integer.valueOf(act.AgeOfParticipants_Taiohi__c);      
        return objActivity;
    }
    
    global class ActivityList {
        webservice string Name;
        webservice string RecordID;
        webservice string ActivityName;
        webservice string Organisation;
        webservice string EventOrganiserFirstName;
        webservice string EventOrganiserLastName;
        webservice string EventOrganiserMobileNumber;
        webservice string EventOrganiserEmail;
        webservice string OwnerFirstName;
        webservice string OwnerLastName;
        webservice string Email;
        webservice string Description;
        webservice datetime ActivityStartDateTime;
        webservice datetime ActivityEndDateTime;
        webservice string Location;
        webservice string Region;
        webservice boolean DisplayonMaraeFitApp;
        webservice datetime CreatedDate;
        webservice datetime LastModifiedDate;
        webservice string ImageURL;
        webservice string Street;
        webservice string City;
        webservice string State;
        webservice string Latitude;
        webservice string Longitude;
        webservice string EventDescription;
        webservice integer AgeOfParticipantsTotal;
        webservice integer Ageofparticipantsdidnotrespond;
        webservice integer AgeOfParticipantsMokopuna;
        webservice integer AgeOfParticipantsRangatahi13_15;
        webservice integer AgeOfParticipantsRangatahi16_19;
        webservice integer AgeOfParticipantsRangatahi13_19;
        webservice integer AgeOfParticipantsPakeke20_39;
        webService integer AgeOfParticipants_Matua_20_39;
        webservice integer AgeOfParticipantsPakeke40_59;
        webservice integer AgeOfParticipantsKaumatua;
        webservice integer AgeOfParticipantsTaiohi;
    }
}