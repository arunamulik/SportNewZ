public class VfForSwiperCntroller {
    
    public static String currentRecordId {get;set;}
    public static Activity__c actTextArea{get; set;}
    public static String Raraunga_Kaunga_Question1 {get;set;}
    public static String Raraunga_Kaunga_Question2 {get;set;}
    public static String Raraunga_Kaunga_Question3 {get;set;}
    public static String Raraunga_Kaunga_Question4 {get;set;}
    public static String Raraunga_Kaunga_Question5 {get;set;}
    /* public static String selectScoreBy{get;set;}
public static String selectScoreFor{get;set;}
public static String selectScoreInOn{get;set;}
public static String selectScoreThrough{get;set;}
public static String selectScoreWith{get;set;}*/
    public static String EditorText{get;set;}
    public static String Editor1Text{get;set;}
    public static String Editor2Text{get;set;}
    public static String Editor3Text{get;set;}
    public static String Editor4Text{get;set;}
    
    public static String changeRequestReason{get;set;}
    public static string DiamensionByScore{get;set;}
    public static string DiamensionForScore{get;set;}
    public static string DiamensionInOnScore{get;set;}
    public static string DiamensionThroughScore{get;set;}
    public static string DiamensionWithScore{get;set;}
    public static string scoreType{get;set;}
    public static string score{get;set;} 
    public static string scoreReason{get;set;} 
    public static Activity__c activity{get;set;}
    public static boolean isUserValid{get;set;} 
    public static Boolean isDueDatePassed{get;set;}
    public Static id recId{get; set;} 
    public static list<User> sys_adm1{get; set;}
    public DateTime dueDate{get; set;}
    public static Boolean isSubmittedApproval{get;set;}
    public static Boolean isSaved{get;set;}
    public Account obj{get;set;}
    
    public static void setChangeRequest() {
        system.debug('31');
        string htmlBody;
        id recId = ApexPages.CurrentPage().getparameters().get('Id');
        Activity__c act = new Activity__c();
        
        system.debug('41-->'+recId+'-->'+changeRequestReason);
        act.Id = recId;
        act.Change_Request_Reason__c =changeRequestReason;
        act.requestForChangeRequest__c = true;
        update act;
        system.debug('45-->'+act);
        changeRequestReason = '';
        
        
        EmailTemplate et = [SELECT Id,name,HtmlValue,Subject,Body FROM EmailTemplate WHERE Name =:'Change request notification'];
        EmailTemplate emailTemp = [SELECT Id,name,HtmlValue,Subject,Body FROM EmailTemplate WHERE Name =:'Change request notification for non partner'];
        system.debug('et-->'+et.Body+'et Id -->'+et.Id);
        
        Activity__c changerequestapproval =[SELECT id,Name,Change_Request_Approval__c,Is_Read_Only__c,Change_Request_Reason__c,ownerId FROM Activity__c where  Id=:recId];//changerequestapproval[0].Change_Request_Approval__c
        system.debug('changerequestapproval-->'+changerequestapproval.Name);
        if(changerequestapproval.Change_Request_Reason__c == null) {
            changerequestapproval.Change_Request_Reason__c = '';
        }
        //User sys_adm = [SELECT id,Email,Name FROM User WHERE Id =:changerequestapproval.Change_Request_Approval__c];//activity[0].Change_Request_Approval__c
        
        communitySportNz_URL__c communityurl =[select id,communitySportNz_URLField__c from communitySportNz_URL__c];
        
        //RULconfigurations__c  customsettingemail =[select id,Default_Change_request_Approval__c,Name from RULconfigurations__c];
        //User sys_adm = [SELECT id,Email,Name FROM User WHERE Email=:customsettingemail.Default_Change_request_Approval__c];
        //RULconfigurations__c  customsettingemail =[select id,Default_Change_request_Approval__c from RULconfigurations__c];
        RULconfigurations__c  customsettingemail =[select id,Name,Default_Change_request_Approval__c from RULconfigurations__c where Name='Change Request approval setting'];
        //List<User> sys_adm = [SELECT Id,Email,Name FROM User WHERE Id=:UserInfo.getUserId() ]; 
        
        /*List<User> partner_users = [SELECT id,Email,Name,ContactId FROM User WHERE Id =:UserInfo.getUserId()];

if(partner_users.size() > 0) {
User partner_user = partner_users[0];
Contact AccountIds =  [select Id,AccountId from Contact where AccountId != null and Id =: partner_user.ContactId];//AccountId != null and
Account acc=[select Name,Partner_Logo__c from Account where Id =: AccountIds.AccountId];
}*/
        List<User> communityUser =[SELECT Username, Id, ProfileId, IsPortalEnabled FROM User where IsPortalEnabled =true And Id=:UserInfo.getUserId()];
        
        List<string> toAddress = new List<string>();
        //toAddress.add('rahul.ghaytadak@aressindia.net'); 
        //toAddress.add('harshal.kulkarni@aress.com'); 
        
        toAddress.add(customsettingemail.Default_Change_request_Approval__c); 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        User partner_user = [SELECT id,Email,Name,ContactId FROM User WHERE Id =:changerequestapproval.ownerId];
        if(communityUser.size() > 0){
            Contact AccountIds =  [select Id,AccountId from Contact where AccountId != null and Id =: partner_user.ContactId];//AccountId != null and
            Account acc=[select Name,Partner_Logo__c from Account where Id =: AccountIds.AccountId];
            htmlBody = et.HTMLValue;
            system.debug('81===>'+htmlBody);
            mail.setTemplateId(et.Id);
            mail.setToAddresses(toAddress);
            mail.setSubject(String.ValueOf(et.Subject));
            htmlBody = htmlBody.replace('<Organsiation_name>',acc.Name);
        }
        else{
            htmlBody = emailTemp.HTMLValue;
            mail.setTemplateId(emailTemp.Id);
            mail.setToAddresses(toAddress);
            mail.setSubject(String.ValueOf(emailTemp.Subject));
        }
        String date1=string.valueOf(system.today());
        htmlBody = htmlBody.replace('<!ActivityName>',changerequestapproval.Name);
        htmlBody = htmlBody.replace('<!ActivityId>',changerequestapproval.Id);
        htmlBody = htmlBody.replace('<!Partner User>',partner_user.Name);// <!Partner User>
        htmlBody = htmlBody.replace('<!Date>',string.valueOf(date1));
        htmlBody = htmlBody.replace('<Reason>', changerequestapproval.Change_Request_Reason__c);
        htmlBody = htmlBody.replace('<link>', String.valueOf(communityurl.communitySportNz_URLField__c+''+changerequestapproval.Id));
        mail.setHtmlBody(htmlBody);
        mail.setSaveAsActivity(false);
        mail.setUseSignature(false);
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        allmsg.add(mail);
        try {
            Messaging.sendEmail(allmsg,false);
            //changerequestapproval.Is_Read_Only__c= false;
            return;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
        
    }
    public static void sendChangeNotificationToPartner() {
        system.debug('31');
        id recId = ApexPages.CurrentPage().getparameters().get('Id');
        Activity__c act = new Activity__c();
        
        system.debug('41-->'+recId+'-->'+changeRequestReason);
        act.Id = recId;
        act.Change_Request_Reason__c =changeRequestReason;
        act.requestForChangeRequest__c = true;
        update act;
        system.debug('45-->'+act);
        changeRequestReason = '';
        
        
        EmailTemplate et = [SELECT Id,name,HtmlValue,Subject,Body FROM EmailTemplate WHERE Name =:'Change Request Notification to partner'];
        system.debug('et-->'+et.Body+'et Id -->'+et.Id);
        
        Activity__c changerequestapproval =[SELECT id,Name,Change_Request_Approval__c,OwnerId,Is_Read_Only__c,Change_Request_Reason__c FROM Activity__c where  Id=:recId];//changerequestapproval[0].Change_Request_Approval__c
        system.debug('changerequestapproval-->'+changerequestapproval.Name);
        if(changerequestapproval.Change_Request_Reason__c == null) {
            changerequestapproval.Change_Request_Reason__c = '';
        }
        
        User partner_user = [SELECT id,Email,Name,ContactId FROM User WHERE Id =:UserInfo.getUserId()];
        User partner_userEmail = [SELECT Id,Email,Name FROM User WHERE Id =:changerequestapproval.OwnerId]; 
        system.debug('partner_userEmail.Email==>'+partner_userEmail.Email);
        List<string> toAddress = new List<string>();
        //toAddress.add('rahul.ghaytadak@aressindia.net'); 
        //toAddress.add('harshal.kulkarni@aress.com'); 
        toAddress.add(partner_userEmail.Email); 
        String htmlBody = et.HTMLValue;
        system.debug('81===>'+htmlBody);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(et.Id);
        mail.setToAddresses(toAddress);
        mail.setSubject(String.ValueOf(et.Subject));
        String date1=string.valueOf(system.today());
        //String emailBody = tempID.HTMLValue;
        htmlBody = htmlBody.replace('<!ActivityName>',changerequestapproval.Name);
        htmlBody = htmlBody.replace('<First_Name>',partner_user.Name);// <!Partner User>
        htmlBody = htmlBody.replace('<!Date>',string.valueOf(date1));
        htmlBody = htmlBody.replace('<Reason>', changerequestapproval.Change_Request_Reason__c);
        
        mail.setHtmlBody(htmlBody);
        // mail.setPlainTextBody(String.ValueOf(et.Body));
        //mail.setHTMLBody(String.ValueOf(et.Body));
        mail.setSaveAsActivity(false);
        mail.setUseSignature(false);
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        allmsg.add(mail);
        try {
            Messaging.sendEmail(allmsg,false);
            //changerequestapproval.Is_Read_Only__c= false;
            return;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
        // }
    }
    
    public VfForSwiperCntroller() {
        
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('Id');
        activity = [SELECT id,Name,Is_Read_Only__c,Due_Date__c,OwnerId,Change_Request_Approval__c,requestForChangeRequest__c FROM Activity__c where id =:currentRecordId];
        
        dueDate =activity.Due_Date__c; 
        //sys_adm1 = [SELECT id,Email,Name FROM User WHERE Id =:UserInfo.getUserId()];
        // system.debug('UserInfo.getUserId()'+UserInfo.getUserId());
        //system.debug('Change_Request_Approval__c==>'+activity.Change_Request_Approval__c); 
        /* RULconfigurations__c  customsettingemail =[select id,Default_Change_request_Approval__c,Name from RULconfigurations__c];
User sys_adm = [SELECT id,Email,Name FROM User WHERE Email=:customsettingemail.Default_Change_request_Approval__c];
if(activity.Is_Read_Only__c == true && activity.requestForChangeRequest__c == true){
//sys_adm.Id == UserInfo.getUserId() &&
//activity.Change_Request_Approval__c == UserInfo.getUserId() &&
system.debug('activity.Is_Read_Only__c-->'+activity.Is_Read_Only__c);
isUserValid=true; 
system.debug(' isUser ==> '+isUserValid);
}*/
        String input  = ApexPages.CurrentPage().getparameters().get('content');
        system.debug('27==>'+currentRecordId);
        actTextArea = [SELECT Id,Name,ownerId, /*Raraunga_Kaunga_Question1__c, Raraunga_Kaunga_Question2__c, Raraunga_Kaunga_Question3__c, Due_Date__c,
                       Raraunga_Kaunga_Question4__c, Raraunga_Kaunga_Question5__c,*/Diamension_By_Score__c,Diamension_For_Score__c,
                       Diamension_InOn_Score__c,Diamension_Thorugh_Score__c,Diamension_With_Score__c,Is_Read_Only__c,
                       reason_for_dimension_by__c,reason_for_dimension_for__c,reason_for_dimension_inon__c,reason_for_dimension_through__c,
                       reason_for_dimension_with__c,requestForChangeRequest__c,Due_Date__c FROM Activity__c where Id =: currentRecordId];
        system.debug('33==>'+actTextArea);
        
        list<Activity_Report__c> actReport=[SELECT Id,Name,Reporting_date__c, Raraunga_Kaunga_Question1__c, Raraunga_Kaunga_Question2__c, Raraunga_Kaunga_Question3__c, 
                                            Raraunga_Kaunga_Question4__c, Raraunga_Kaunga_Question5__c,Activity_Name__c FROM Activity_Report__c where Activity_Name__c =:actTextArea.Id Order by LastModifiedDate DESC];
        
        // system.debug('actReport[0].Raraunga_Kaunga_Question1__c.stripHtmlTags()==>'+actReport[0].Raraunga_Kaunga_Question1__c.stripHtmlTags());
        /*if(actTextArea.requestForChangeRequest__c == true && actTextArea.Is_Read_Only__c == false ){
isSubmittedApproval = true;
}else{
isSubmittedApproval = false;
}*/
        if(actTextArea.Is_Read_Only__c == true && actTextArea.requestForChangeRequest__c == true ){
            isSubmittedApproval = true;
        }
        if(actTextArea.Is_Read_Only__c == true && actTextArea.requestForChangeRequest__c == false){
            isSaved= true;
        }else{
            isSaved= false;
        }
        
        if(actTextArea.Due_Date__c < system.today()){
            isDueDatePassed = false;
        }else{
            isDueDatePassed = true; 
        }
        
        if(actReport.size() >0){
            if(actReport[0].Raraunga_Kaunga_Question1__c != null){
                //Raraunga_Kaunga_Question1 = actReport[0].Raraunga_Kaunga_Question1__c.stripHtmlTags();
                Raraunga_Kaunga_Question1 = actReport[0].Raraunga_Kaunga_Question1__c;
            }else{
                Raraunga_Kaunga_Question1 = '';
            }
            if(actReport[0].Raraunga_Kaunga_Question2__c != null){
                //Raraunga_Kaunga_Question2 = actReport[0].Raraunga_Kaunga_Question2__c.stripHtmlTags();
                Raraunga_Kaunga_Question2 = actReport[0].Raraunga_Kaunga_Question2__c;
            }else{
                Raraunga_Kaunga_Question2 = '';
            }
            if(actReport[0].Raraunga_Kaunga_Question3__c != null){
                //Raraunga_Kaunga_Question3 = actReport[0].Raraunga_Kaunga_Question3__c.stripHtmlTags();
                Raraunga_Kaunga_Question3 = actReport[0].Raraunga_Kaunga_Question3__c;
            }else{
                Raraunga_Kaunga_Question3 = '';
            }
            if(actReport[0].Raraunga_Kaunga_Question4__c != null){
                //Raraunga_Kaunga_Question4 = actReport[0].Raraunga_Kaunga_Question4__c.stripHtmlTags();
                Raraunga_Kaunga_Question4 = actReport[0].Raraunga_Kaunga_Question4__c;
            }else{
                Raraunga_Kaunga_Question4 = '';
            }
            if(actReport[0].Raraunga_Kaunga_Question5__c != null){
                //Raraunga_Kaunga_Question5 = actReport[0].Raraunga_Kaunga_Question5__c.stripHtmlTags();
                Raraunga_Kaunga_Question5 = actReport[0].Raraunga_Kaunga_Question5__c;
            }else{
                Raraunga_Kaunga_Question5 = '';
            }
            
        }
        else{
            
            Raraunga_Kaunga_Question1 = '';
            
            Raraunga_Kaunga_Question2 = '';
            
            Raraunga_Kaunga_Question3 = '';
            
            Raraunga_Kaunga_Question4 = '';
            
            Raraunga_Kaunga_Question5 = '';
            
        }
        
        
        if(actTextArea.Diamension_By_Score__c != null){
            DiamensionByScore = actTextArea.Diamension_By_Score__c;
        }else{
            DiamensionByScore = '';
        }
        
        if(actTextArea.Diamension_For_Score__c != null){
            DiamensionForScore = actTextArea.Diamension_For_Score__c;
        }else{
            DiamensionForScore = '';
        }
        
        if(actTextArea.Diamension_InOn_Score__c != null){
            DiamensionInOnScore = actTextArea.Diamension_InOn_Score__c;
        }else{
            DiamensionInOnScore = '';
        }
        
        
        if(actTextArea.Diamension_Thorugh_Score__c != null){
            DiamensionThroughScore = actTextArea.Diamension_Thorugh_Score__c;
        }else{
            DiamensionThroughScore = '';
        }
        
        if(actTextArea.Diamension_With_Score__c != null){
            DiamensionWithScore = actTextArea.Diamension_With_Score__c;
        }else{
            DiamensionWithScore = '';
        } 
        //Score1value = actTextArea.Diamension_By_Score__c;
        List<User> communityUser =[SELECT Username, Id, ProfileId, IsPortalEnabled FROM User where IsPortalEnabled =true And Id=:UserInfo.getUserId()];
        if(communityUser.size() > 0){
            User  contactIds = [select Id,ContactId	 from User where ContactId != null and  Id =: userInfo.getUserId()];//ContactId !=: null and
            system.debug('contactId==>'+contactIds.ContactId);
            Contact AccountIds =  [select Id,AccountId from Contact where AccountId != null and Id =: contactIds.ContactId];//AccountId != null and
            system.debug('AccountIds==>'+AccountIds);
            obj = [select Partner_Logo__c from Account where Id =: AccountIds.AccountId];
        }
    }
    
    public static void setScore() {
        id recId = ApexPages.CurrentPage().getparameters().get('Id');
        
        
        Activity__c act = new Activity__c();
        
        if(scoreType == 'with'){
            act.Diamension_With_Score__c = score;
            act.reason_for_dimension_with__c = scoreReason;
        }
        
        if(scoreType == 'by'){
            act.Diamension_By_Score__c = score;
            act.reason_for_dimension_by__c = scoreReason;
        }
        
        if(scoreType == 'for'){
            act.Diamension_For_Score__c = score;
            act.reason_for_dimension_for__c = scoreReason;
        }
        
        if(scoreType == 'through'){
            act.Diamension_Thorugh_Score__c = score;
            act.reason_for_dimension_through__c = scoreReason;
        }
        
        if(scoreType == 'inon'){
            act.Diamension_InOn_Score__c = score;
            act.reason_for_dimension_inon__c = scoreReason;
        }
        
        
        act.Id = recId;
        
        update act; 
    }
    
    public List<SelectOption> getScores(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Activity__c.Diamension_By_Score__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    
    public static void completeActivity() {
        
        id recId = ApexPages.CurrentPage().getparameters().get('Id');
        Activity__c act = new Activity__c();
        act.Id = recId;
        act.Is_Read_Only__c = true;
        // act.requestForChangeRequest__c=true;
        update act; 
    }
    //public String Score1value {get;set;}
    
    public static void saveTextEditorData() {
        system.debug('hello');
        id recId = ApexPages.CurrentPage().getparameters().get('id');
        Activity__c activityName =[SELECT id,Name,Change_Request_Approval__c,OwnerId,Is_Read_Only__c,Change_Request_Reason__c FROM Activity__c where  Id=:recId];
        Activity_Report__c act = new Activity_Report__c(); 
        /*list<Activity_Report__c> actReport=[SELECT Id,Name,Reporting_date__c, Raraunga_Kaunga_Question1__c, Raraunga_Kaunga_Question2__c, Raraunga_Kaunga_Question3__c, 
Raraunga_Kaunga_Question4__c, Raraunga_Kaunga_Question5__c,Activity_Name__c FROM Activity_Report__c where Reporting_date__c =: system.today() AND Activity_Name__c =:activityName.Id];

if( actReport.size()>0){
actReport[0].Raraunga_Kaunga_Question1__c = EditorText;        
actReport[0].Raraunga_Kaunga_Question2__c = Editor1Text;
actReport[0].Raraunga_Kaunga_Question3__c = Editor2Text;
actReport[0].Raraunga_Kaunga_Question4__c = Editor3Text;
actReport[0].Raraunga_Kaunga_Question5__c = Editor4Text;
actReport[0].Reporting_date__c= system.today();
actReport[0].Partner_User__c=activityName.OwnerId;
actReport[0].Activity_Name__c=activityName.Id;
act.Id = recId;
system.debug('173-->'+actReport);
update actReport;
}
else{*/
        act.Raraunga_Kaunga_Question1__c = EditorText; 
        system.debug('act.Raraunga_Kaunga_Question1__c'+EditorText);
        act.Raraunga_Kaunga_Question2__c = Editor1Text;
        act.Raraunga_Kaunga_Question3__c = Editor2Text;
        act.Raraunga_Kaunga_Question4__c = Editor3Text;
        act.Raraunga_Kaunga_Question5__c = Editor4Text;
        act.Reporting_date__c= system.today();
        act.Partner_User__c=activityName.OwnerId;
        act.Activity_Name__c=activityName.Id;
        //act.Id = recId;
        system.debug('173-->'+act);
        insert act;
        // }
        
        
        
        
        
        /*
id recId = ApexPages.CurrentPage().getparameters().get('id');
String input  = Apexpages.currentPage().getParameters().get('selectScoreBy');
system.debug('54==>'+selectScoreBy);
system.debug('55==>'+selectScoreFor);
system.debug('56==>'+selectScoreInOn);
system.debug('57==>'+selectScoreThrough);
system.debug('58==>'+selectScoreWith); 

system.debug('59==>'+EditorText);
system.debug('60==>'+Editor1Text);
system.debug('61==>'+Editor2Text);
system.debug('62==>'+Editor3Text);
system.debug('63==>'+Editor4Text);
//actTextArea.Diamension_By_Score__c = selectScoreBy;
actTextArea.Raraunga_Kaunga_Question1__c = EditorText;
//actTextArea.Diamension_For_Score__c = selectScoreFor;
actTextArea.Raraunga_Kaunga_Question2__c = Editor1Text;
//actTextArea.Diamension_InOn_Score__c = selectScoreInOn;
actTextArea.Raraunga_Kaunga_Question3__c = Editor2Text;
//actTextArea.Diamension_Thorugh_Score__c = selectScoreThrough;
actTextArea.Raraunga_Kaunga_Question4__c = Editor3Text;
//actTextArea.Diamension_With_Score__c = selectScoreWith;
actTextArea.Raraunga_Kaunga_Question5__c = Editor4Text;
update actTextArea;*/
        
    }
    
    
    /*  public PageReference callApproved(){
isUserValid = false;
Id id = apexpages.currentpage().getparameters().get('Id');
list<Activity__c> activity1 = [SELECT id,Name,Is_Read_Only__c,requestForChangeRequest__c,OwnerId FROM Activity__c where id =:id];
if(activity1.size()>0){
system.debug('hello');
if(activity1[0].Is_Read_Only__c == true ){
activity1[0].Is_Read_Only__c=false;
activity1[0].requestForChangeRequest__c=false;
update activity1;

}
communitySportNz_URL_ForPartnerUser__c communityurl =[select id,URL_ForPartnerUser__c from communitySportNz_URL_ForPartnerUser__c];
EmailTemplate et = [SELECT Id,name,HtmlValue,Subject,Body FROM EmailTemplate WHERE Name =:'Confirmation of Approval'];
User partner_user = [SELECT id,Email,Name FROM User WHERE Id =:activity1[0].OwnerId]; 
List<string> toAddress = new List<string>();
toAddress.add('apurv.gunjal@aressindia.net'); 
//toAddress.add('harshal.kulkarni@aress.com'); 
//toAddress.add(partner_user.Email); 
String htmlBody = et.HTMLValue;
system.debug('81===>'+htmlBody);

Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setTemplateId(et.Id);
mail.setToAddresses(toAddress);
mail.setSubject(String.ValueOf(et.Subject));

htmlBody = htmlBody.replace('<!ActivityName>',activity1[0].Name);
htmlBody = htmlBody.replace(' <!ActivityId>',activity1[0].id);
htmlBody = htmlBody.replace('<!Date>',string.valueOf(system.today()));
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
}  */
    
    
}