public class VfForApprovalController {
    public static boolean isUserValid{get;set;} 
    public static boolean isUserApprover{get;set;} 
    public static boolean isPlannedActApprover{get;set;}
    public static boolean isUserPlannedActApprover{get;set;} 
    public static Activity__c activity{get;set;}
    public static String currentRecordId {get;set;}
    public static String changeRequestReason{get;set;}
    public static String PlannedActchangeRequestReason{get;set;}
    public VfForApprovalController(){
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('Id');
        activity = [SELECT Id,Name,Is_Read_Only__c,OwnerId,Change_Request_Approval__c,Planned_Act_Change_Request_Reson__c,IsPlannedActivity__c,requestForChangeRequest__c,Change_Request_Reason__c FROM Activity__c where id =:currentRecordId];
        RULconfigurations__c  customsettingemail =[select id,Default_Change_request_Approval__c from RULconfigurations__c];
        List<User> sys_adm = [SELECT Id,Email,Name FROM User WHERE Id=:UserInfo.getUserId() ]; // and Email=:customsettingemail.Default_Change_request_Approval__c
        if(sys_adm[0].Email == customsettingemail.Default_Change_request_Approval__c && activity.Is_Read_Only__c == true && activity.requestForChangeRequest__c == true){
            //sys_adm.Id == UserInfo.getUserId() &&
            system.debug('activity.Is_Read_Only__c-->'+activity.Is_Read_Only__c);
            isUserValid=true; 
            isUserApprover=false; 
            system.debug(' isUser ==> '+isUserValid);
        }
        if(sys_adm[0].Email == customsettingemail.Default_Change_request_Approval__c && activity.IsPlannedActivity__c == true){
            //sys_adm.Id == UserInfo.getUserId() &&
            system.debug('activity.Is_Read_Only__c-->'+activity.Is_Read_Only__c);
            isPlannedActApprover=false; 
            isUserPlannedActApprover=true; 
        }
        //if(activity.Is_Read_Only__c != true && sys_adm.Id != UserInfo.getUserId()){
        if(activity.Is_Read_Only__c == false){    
            isUserApprover=true; 
        }
        if(activity.IsPlannedActivity__c == false){    
            isPlannedActApprover=true; 
        }
        changeRequestReason = activity.Change_Request_Reason__c;
        PlannedActchangeRequestReason=activity.Planned_Act_Change_Request_Reson__c;
    }
    public PageReference callApproved(){
        isUserApprover=true;
        isUserValid = false;
        Id id = apexpages.currentpage().getparameters().get('Id');
        list<Activity__c> activity1 = [SELECT id,Name,Is_Read_Only__c,requestForChangeRequest__c,OwnerId FROM Activity__c where id =:id];
        if(activity1.size()>0){
            system.debug('hello');
            if(activity1[0].Is_Read_Only__c == true ){
                activity1[0].Is_Read_Only__c=false;
                activity1[0].requestForChangeRequest__c=false;
                activity1[0].Due_Date__c=system.today().adddays(5);
                update activity1;
                
            }
            communitySportNz_URL_ForPartnerUser__c communityurl =[select id,URL_ForPartnerUser__c from communitySportNz_URL_ForPartnerUser__c];
            EmailTemplate et = [SELECT Id,HtmlValue,Subject,Body,Name FROM EmailTemplate WHERE Name =:'Confirmation of Approval'];
            User partner_user = [SELECT Id,Email,Name FROM User WHERE Id =:activity1[0].OwnerId]; 
            List<string> toAddress = new List<string>();
            //toAddress.add('rahul.ghaytadak@aressindia.net'); 
            toAddress.add(partner_user.Email); 
            String htmlBody = et.HTMLValue;
            system.debug('81===>'+htmlBody);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(et.Id);
            mail.setToAddresses(toAddress);
            mail.setSubject(String.ValueOf(et.Subject));
            
            //htmlBody = htmlBody.replace('<!ActivityName>',activity1[0].Name);
            // htmlBody = htmlBody.replace(' <!ActivityId>',activity1[0].id);
            htmlBody = htmlBody.replace('<enter-date-5-days-from-approval-date>',string.valueOf(system.today().adddays(5).format()));
            htmlBody = htmlBody.replace('<!UserName>',partner_user.Name);
            htmlBody = htmlBody.replace('<link>', String.valueOf(communityurl.URL_ForPartnerUser__c));
            
            mail.setHtmlBody(htmlBody);
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);
            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            allmsg.add(mail);
            try {
                Messaging.sendEmail(allmsg,false);
                return null;
            } catch (Exception e) {
                System.debug(e.getMessage());
            }
        } 
        return null;        
    }
    
    public PageReference callApprovedPlannedAct(){
        isPlannedActApprover=true; 
        isUserPlannedActApprover = false;
        Id id = apexpages.currentpage().getparameters().get('Id');
        list<Activity__c> activity1 = [SELECT id,Name,Is_Read_Only__c,Due_Date_For_Planned_Activities__c,IsPlannedActivity__c,OwnerId FROM Activity__c where id =:id];
        if(activity1.size()>0){
            system.debug('hello');
            if(activity1[0].IsPlannedActivity__c == true ){
                activity1[0].IsPlannedActivity__c=false;
                activity1[0].Due_Date_For_Planned_Activities__c=system.today().adddays(5);
                update activity1;
                
            }
            communitySportNz_URL_ForPartnerUser__c communityurl =[select id,URL_ForPartnerUser__c from communitySportNz_URL_ForPartnerUser__c];
            EmailTemplate et = [SELECT Id,HtmlValue,Subject,Body,Name FROM EmailTemplate WHERE Name =:'Confirmation of Approval'];
            User partner_user = [SELECT Id,Email,Name FROM User WHERE Id =:activity1[0].OwnerId]; 
            List<string> toAddress = new List<string>();
            //toAddress.add('rahul.ghaytadak@aressindia.net'); 
            toAddress.add(partner_user.Email); 
            String htmlBody = et.HTMLValue;
            system.debug('81===>'+htmlBody);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(et.Id);
            mail.setToAddresses(toAddress);
            mail.setSubject(String.ValueOf(et.Subject));
            
            //htmlBody = htmlBody.replace('<!ActivityName>',activity1[0].Name);
            // htmlBody = htmlBody.replace(' <!ActivityId>',activity1[0].id);
            htmlBody = htmlBody.replace('<enter-date-5-days-from-approval-date>',string.valueOf(system.today().adddays(5).format()));
            htmlBody = htmlBody.replace('<!UserName>',partner_user.Name);
            htmlBody = htmlBody.replace('<link>', String.valueOf(communityurl.URL_ForPartnerUser__c));
            
            mail.setHtmlBody(htmlBody);
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);
            List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
            allmsg.add(mail);
            try {
                Messaging.sendEmail(allmsg,false);
                return null;
            } catch (Exception e) {
                System.debug(e.getMessage());
            }
        } 
        return null;        
    }
}