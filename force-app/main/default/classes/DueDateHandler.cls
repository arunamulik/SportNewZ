public class DueDateHandler {
    
    public static void DueDateMethod(List<Activity__c> ActList){
        RULconfigurations__c  customsettingdate =[select Due_Date_For_End_Year_Report__c,Due_Date_For_Planned_Activities__c from RULconfigurations__c];
        List<User> communityUser =[SELECT Username, Id,ContactId, ProfileId, IsPortalEnabled FROM User where IsPortalEnabled =true And Id=:UserInfo.getUserId()];
        
        try{
            Contact AccountIds =  [select Id,AccountId from Contact where AccountId != null and Id =: communityUser[0].ContactId ];//AccountId != null and
            Account acc=[select id,Name,Partner_Logo__c from Account where Id =: AccountIds.AccountId];
            for(Activity__c act:ActList){
                act.Due_Date__c=customsettingdate.Due_Date_For_End_Year_Report__c;
                act.Due_Date_For_Planned_Activities__c=customsettingdate.Due_Date_For_Planned_Activities__c;     
                act.Organisation__c=acc.Id;
            }    
        }
        catch(exception e){
            for(Activity__c act:ActList){
                act.Due_Date__c=customsettingdate.Due_Date_For_End_Year_Report__c;
                act.Due_Date_For_Planned_Activities__c=customsettingdate.Due_Date_For_Planned_Activities__c;
            }
        }
    }
}