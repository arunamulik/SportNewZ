public class ActivityLandingVfPageController {
    
    public static String changeRequestReason{get;set;}
    public String currentRecordId {get;set;}
    public Activity__c actTextArea{get; set;}
    public String diamensionRichText_By {get;set;}
    public String diamensionRichText_For {get;set;}
    public String diamensionRichText_InOn {get;set;}
    public String diamensionRichText_Through {get;set;}
    public String diamensionRichText_With {get;set;}
    public String selectScoreBy{get;set;}
    public String selectScoreFor{get;set;}
    public String selectScoreInOn{get;set;}
    public String selectScoreThrough{get;set;}
    public String selectScoreWith{get;set;}
    public String EditorText{get;set;}
    public String Editor1Text{get;set;}
    public String Editor2Text{get;set;}
    public String Editor3Text{get;set;}
    public String Editor4Text{get;set;}
    public String imageReader{get;set;}
    public String Filename{get;set;}
    List<String> lstImageNames = new List<String>();
    List<String> lstImageNames2 = new List<String>();
    Map<String, String> mapNameImage= new Map<String, String>();
    public Account obj{get;set;}
    public static Boolean editMode{get;set;}
    public static Boolean isDueDatePassed{get;set;}
    public DateTime dueDate{get; set;}
    //public String Score1value {get;set;}
    public static Boolean isSubmittedApproval{get;set;}
    
    public static void setChangeRequest() {
        system.debug('31');
        string htmlBody;
        id recId = ApexPages.CurrentPage().getparameters().get('Id');
        Activity__c act = new Activity__c();
        
        system.debug('41-->'+recId+'-->'+changeRequestReason);
        act.Id = recId;
        act.Planned_Act_Change_Request_Reson__c =changeRequestReason;
        act.requestForChangeRequest__c = true;
        update act;
        system.debug('45-->'+act);
        changeRequestReason = '';
        
        
        EmailTemplate et = [SELECT Id,name,HtmlValue,Subject,Body FROM EmailTemplate WHERE Name =:'Change request notification'];
        EmailTemplate emailTemp = [SELECT Id,name,HtmlValue,Subject,Body FROM EmailTemplate WHERE Name =:'Change request notification for non partner'];
        system.debug('et-->'+et.Body+'et Id -->'+et.Id);
        
        Activity__c changerequestapproval =[SELECT id,Name,Change_Request_Approval__c,Is_Read_Only__c,Planned_Act_Change_Request_Reson__c,ownerId FROM Activity__c where  Id=:recId];//changerequestapproval[0].Change_Request_Approval__c
        system.debug('changerequestapproval-->'+changerequestapproval.Name);
        if(changerequestapproval.Planned_Act_Change_Request_Reson__c == null) {
            changerequestapproval.Planned_Act_Change_Request_Reson__c = '';
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
        htmlBody = htmlBody.replace('<Reason>', changerequestapproval.Planned_Act_Change_Request_Reson__c);
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
        act.Planned_Act_Change_Request_Reson__c =changeRequestReason;
        act.IsPlannedActivity__c = true;
        update act;
        system.debug('45-->'+act);
        changeRequestReason = '';
        
        
        EmailTemplate et = [SELECT Id,name,HtmlValue,Subject,Body FROM EmailTemplate WHERE Name =:'Change Request Notification to partner'];
        system.debug('et-->'+et.Body+'et Id -->'+et.Id);
        
        Activity__c changerequestapproval =[SELECT id,Name,Change_Request_Approval__c,OwnerId,Is_Read_Only__c,Planned_Act_Change_Request_Reson__c FROM Activity__c where  Id=:recId];//changerequestapproval[0].Change_Request_Approval__c
        system.debug('changerequestapproval-->'+changerequestapproval.Name);
        if(changerequestapproval.Planned_Act_Change_Request_Reson__c == null) {
            changerequestapproval.Planned_Act_Change_Request_Reson__c = '';
        }
        
        User partner_user = [SELECT id,Email,Name,ContactId FROM User WHERE Id =:UserInfo.getUserId()];
        User partner_userEmail = [SELECT Id,Email,Name FROM User WHERE Id =:changerequestapproval.OwnerId]; 
        system.debug('partner_userEmail.Email==>'+partner_userEmail.Email);
        List<string> toAddress = new List<string>();
        //toAddress.add('muskan.shaikh@aressindia.net'); 
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
        //  String emailBody = tempID.HTMLValue;
        htmlBody = htmlBody.replace('<!ActivityName>',changerequestapproval.Name);
        htmlBody = htmlBody.replace('<First_Name>',partner_user.Name);// <!Partner User>
        htmlBody = htmlBody.replace('<!Date>',string.valueOf(date1));
        htmlBody = htmlBody.replace('<Reason>', changerequestapproval.Planned_Act_Change_Request_Reson__c);
        
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
    
    
    public ActivityLandingVfPageController() {
        //isDueDatePassed = true;
        editMode = false;
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        String input  = ApexPages.CurrentPage().getparameters().get('content');
        system.debug('27==>'+currentRecordId);
        actTextArea = [SELECT Id, DiamensionBy_DescRichText__c, DiamensionFor_DescRichText__c, IsPlannedActivity__c,requestForChangeRequest__c,
                       DiamensionInOn_DescRichText__c, DiamensionThrough_DescRichText__c, DiamensionWith_DescRichText__c, 
                       Diamension_By_Score__c , Diamension_For_Score__c, Diamension_InOn_Score__c, Diamension_Thorugh_Score__c,
                       Diamension_With_Score__c,Is_Read_Only__c,Due_Date_For_Planned_Activities__c
                       FROM Activity__c where Id =: currentRecordId];
        dueDate =actTextArea.Due_Date_For_Planned_Activities__c; 
        system.debug('33==>'+actTextArea.Is_Read_Only__c);
        system.debug('33==>'+actTextArea.DiamensionWith_DescRichText__c);
        if(actTextArea.IsPlannedActivity__c == true && actTextArea.requestForChangeRequest__c == true ){
            isSubmittedApproval = true;
        }
        if(actTextArea.Due_Date_For_Planned_Activities__c < system.today()){
            isDueDatePassed = true;
        }
        else{
            isDueDatePassed = false;
        }
        if(actTextArea.DiamensionBy_DescRichText__c != null){
            diamensionRichText_By = actTextArea.DiamensionBy_DescRichText__c;
        }else{
            diamensionRichText_By = '';
        }
        if(actTextArea.DiamensionFor_DescRichText__c != null){
            diamensionRichText_For = actTextArea.DiamensionFor_DescRichText__c;
        }else{
            diamensionRichText_For = '';
        }
        if(actTextArea.DiamensionInOn_DescRichText__c != null){
            diamensionRichText_InOn = actTextArea.DiamensionInOn_DescRichText__c;
        }else{
            diamensionRichText_InOn = '';
        }
        if(actTextArea.DiamensionThrough_DescRichText__c != null){
            diamensionRichText_Through = actTextArea.DiamensionThrough_DescRichText__c;
        }else{
            diamensionRichText_Through = '';
        }
        if(actTextArea.DiamensionThrough_DescRichText__c != null){
            diamensionRichText_With = actTextArea.DiamensionWith_DescRichText__c;
        }else{
            diamensionRichText_With = '';
        }
        lstImageNames = diamensionRichText_InOn.split(' ');
        /*for(String lst : lstImageNames){
if(lst.contains('PNG') || lst.contains('png'))
lstImageNames2.add(lst);
}
List<Attachment> lstImageAttachments = [SELECT Id, Body, Name FROM Attachment WHERE Name in: lstImageNames2 and ParentId =: currentRecordId ];
for(Attachment lst : lstImageAttachments){
String payload = lst.Body.toString();
mapNameImage.put(lst.name,payload);
}
system.debug('mapNameImage'+mapNameImage);*/
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
    public List<SelectOption> getScores(){
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Activity__c.Diamension_By_Score__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    
    public void saveTextEditorData() {
        system.debug('u r in saveTextEditorData');
        editMode = false;
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
        actTextArea.Id=recId;
        actTextArea.Diamension_By_Score__c = selectScoreBy;
        actTextArea.DiamensionBy_DescRichText__c = EditorText;
        actTextArea.Diamension_For_Score__c = selectScoreFor;
        actTextArea.DiamensionFor_DescRichText__c = Editor1Text;
        actTextArea.Diamension_InOn_Score__c = selectScoreInOn;
        actTextArea.DiamensionInOn_DescRichText__c = Editor2Text;
        actTextArea.Diamension_Thorugh_Score__c = selectScoreThrough;
        actTextArea.DiamensionThrough_DescRichText__c = Editor3Text;
        actTextArea.Diamension_With_Score__c = selectScoreWith;
        actTextArea.DiamensionWith_DescRichText__c = Editor4Text;
        update actTextArea;
        system.debug('editMode'+editMode);
        // ActivityLandingVfPageController act= new ActivityLandingVfPageController();
        /*PageReference tempPage = ApexPages.currentPage();                    
tempPage.setRedirect(true);        
return tempPage;*/
    }
    public void insertImageAsFile(){
        Attachment attRecord = new Attachment();
        attRecord.Body=Blob.valueOf(imageReader);
        attRecord.Name= Filename;
        attRecord.parentId = currentRecordId;
        // insert attRecord;
        system.debug('Inside attRecord  '+attRecord.id);
        system.debug('lstImageNames  '+lstImageNames);
    }
    public static void Dimension(){
        editMode=true;
    }
    public static void gotoReadonlyMode(){
        editMode=false;
        system.debug('gotoReadonlyMode');
    }
    public PageReference refreshPage() {
        PageReference tempPage = ApexPages.currentPage();                    
        tempPage.setRedirect(true);        
        return tempPage;
    }
    
}