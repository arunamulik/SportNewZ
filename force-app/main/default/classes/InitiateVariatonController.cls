/**
* @Author: Eternus Solutions
* @Class: InitiateVariatonController
* @Description: This class is used to insert variations for specific Investment Schedule.
* @Date: 24/05/2018
**/

public with sharing class InitiateVariatonController{
    
    public String isID {get;set;}
    public String isNum {get;set;}
    public String isName {get;set;}
    public Date initiationDate {get;set;}
    public String initiatedBy {get;set;}
    public String purpose {get;set;}
    public String comments {get;set;}
    public boolean showVariation{get;set;}
    public boolean showMessage{get;set;}
    public boolean showContinue{get;set;}
    public variation__c objVar{get;set;}
    
    public InitiateVariatonController(ApexPages.StandardController stdController){
        showContinue = false;
        showMessage = false;
        isID = apexpages.currentpage().getparameters().get('id');
        
        system.debug('#InitiateVariatonController##isID-->>'+isID);
        
        if(String.isNotBlank(isID)){
            List<Business_Case__c> isList = [Select  Id,
                                             Investment_Schedule_ID__c,
                                             Name,
                                             CreatedBy.Name,
                                             Status__c
                                             From Business_Case__c
                                             Where Id =: isID
                                             Limit 1];
            if(isList[0].status__c == 'Approved' ||isList[0].status__c == 'Signed' || isList[0].status__c == 'Closed' ){
                 showVariation = true;
                 
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.info,System.Label.VariationWarning));
            }
            else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,System.Label.VariationCannotBeCreated));
            }
            
            isNum = isList[0].Investment_Schedule_ID__c;
            isName = isList[0].Name;
            initiationDate = System.today();
            initiatedBy = UserInfo.getName();
        }
        else{
            isID ='';
        }
        
    }
    
   public  void  NextButtonMethod(){
        showMessage = true;
        showVariation = false;
    }
    public PageReference insertVariation(){
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        String MyProflieName = PROFILE[0].Name;
        if(MyProflieName == 'Kahiwi' || MyProflieName == 'System Administrator'){
            RecursionHandler.TrgVariationBypass = true;
        }
        if( String.isNotBlank(comments)){
            
            Variation__c varRec = new Variation__c();
            varRec.Comments__c = comments;
            varRec.Initiated_By__c = UserInfo.getUserId();
            varRec.Variation_Initiation_Date__c = System.today();
            varRec.Investment_Schedule__c = isID;
            varRec.Is_Active__c = true;
            try{
                if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                    insert varRec;
                 }else{
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'CPU Limit Exceeding!! Current CPU Time is '+Limits.getCpuTime()));
                }
                PageReference pgRef = new PageReference('/'+isID);
                updateCustomSettingKahiwi();
                return pgRef;
            }
            catch(Exception ex){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
            }
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select Mandatory Fields'));
        }
        return null;
    }
    
    public PageReference cancelVariation(){
        system.debug('@InitiateVariatonController@isID-->>'+isID);
        
        PageReference pgRef;
        if(String.isNotBlank(isID)){
            pgRef = new PageReference('/'+isID);
        }
        else{
            Map<String, Schema.SObjectType> globalMap  = Schema.getGlobalDescribe() ;
            Schema.SObjectType inShdlObj = globalMap.get('Business_Case__c') ;
            Schema.DescribeSObjectResult descResult = inShdlObj.getDescribe() ;
            String keyPrefix = descResult.getKeyPrefix();
            pgRef = new PageReference('/'+keyPrefix);
        }
        pgRef.setRedirect(true);
        updateCustomSettingKahiwi();
        return pgRef;
    }
    
    
    private static void updateCustomSettingKahiwi(){
        RecursionHandler.TrgVariationBypass = false;
    }
}