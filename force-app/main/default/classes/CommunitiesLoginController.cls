global without sharing class CommunitiesLoginController {
    public String password { get; set; }
    public String username { get; set;}
    public List<Landing_Page_Image_Video__c> obj{get;set;}
    
    global CommunitiesLoginController () {
        obj=[SELECT Id,Name, Embed_Video__c, Background_Image__c FROM Landing_Page_Image_Video__c limit 1];
        for(Landing_Page_Image_Video__c o : obj) {
            System.debug('obj.Embed_Video__c####'+o.Embed_Video__c);
            System.debug('obj.Background_Image__c###'+o.Background_Image__c);
        }
    }
    global PageReference forwardToAuthPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        String displayType = System.currentPageReference().getParameters().get('display');
        return Network.forwardToAuthPage(startUrl, displayType);
    }
    global PageReference RedirectToLogin()
    {
        return new PageReference( '/apex/commonLoginPage');
        
    }
    public PageReference loginUser()
    {
        if(UserInfo.getUserId() != null  ){  //&& UserInfo.getUserType() != 'Guest'
            /* List<Activity__c> activity = [SELECT id,Name,OwnerId FROM Activity__c WHERE OwnerId =: UserInfo.getUserId()];
            if(activity.size() > 0){ 				            
                return Site.login(username, password,'/s/activity-landing-page');
            } 
            else{
                return Site.login(username, password, '/s/showactivitypopup');
            } */
            return Site.login(username, password, '/s/showactivitypopup');
           // return Site.login(username, password, '/s/takeusertopartnerportal');
        }
        else{
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.');
            ApexPages.addMessage(myMsg);
            return new PageReference( '/apex/ActivityLoginPage');
        }
    }
    public PageReference loginPatnerUser()
    {
        if(UserInfo.getUserId() != null  ){  //&& UserInfo.getUserType() != 'Guest'
            /* List<Activity__c> activity = [SELECT id,Name,OwnerId FROM Activity__c WHERE OwnerId =: UserInfo.getUserId()];
            if(activity.size() > 0){ 				            
                return Site.login(username, password,'/s/activity-landing-page');
            } 
            else{
                return Site.login(username, password, '/s/showactivitypopup');
            } */
            //return Site.login(username, password, '/s/checkuseraccess');
            return Site.login(username, password, '/s');
        }
        else{
            /*ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.');
            ApexPages.addMessage(myMsg);*/
            return new PageReference( '/apex/partnerLogin');
        }
    }
    public PageReference checkCommonLoginAccess()
    {
        if(UserInfo.getUserId() != null  ){  //&& UserInfo.getUserType() != 'Guest'
            /* List<Activity__c> activity = [SELECT id,Name,OwnerId FROM Activity__c WHERE OwnerId =: UserInfo.getUserId()];
            if(activity.size() > 0){ 				            
                return Site.login(username, password,'/s/activity-landing-page');
            } 
            else{
                return Site.login(username, password, '/s/showactivitypopup');
            } */
            return Site.login(username, password, '/s/checkuseraccess');
        }
        else{
            /*ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.');
            ApexPages.addMessage(myMsg);*/
            return new PageReference( '/apex/commonLoginPage');
        }
    }
    
}