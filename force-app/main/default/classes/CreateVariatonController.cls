/**
     * @Author: Eternus Solutions
     * @Class: CreateVariatonController
     * @Description: This class is used to insert variations for specific Investment Schedule.
     * @Date: 31/05/2018
  **/

public with sharing class CreateVariatonController{

    public ID isID {get;set;}
    public String isNum {get;set;}
    public String isName {get;set;}
    public String purpose {get;set;}
    public String comments {get;set;}
	public Variation__c newVariation {get;set;}
    public String invShdlStrId;
    public Id invSchId;
    public String invShdlStatus {get;set;}

    public CreateVariatonController(ApexPages.StandardController stdController){

        newVariation =(Variation__c)stdController.getrecord();
		invShdlStrId = ApexPages.currentPage().getParameters().get('retURL');
		if(invShdlStrId !=NULL ){
            invShdlStrId = string.valueof(invShdlStrId).substringAfter('/');
        }
        else{
            invShdlStrId ='';
        }

        if(invShdlStrId.length() >=15 ) {
            invSchId = id.valueof(invShdlStrId);
        }

        newVariation = new Variation__c();

        // Check whethere request came from Investment Schedule Page or Investment Schedule Variation Page
        if(invShdlStrId.length() >=15 && Schema.Business_Case__c.SObjectType == invSchId.getSobjectType()) {
            newVariation.Investment_Schedule__c = invSchId;

            List<Business_Case__c> isList = [Select  Id,
                                                  Investment_Schedule_ID__c,
                                                  Name,
                                                  Status__c,
                                                  CreatedBy.Name
                                             From Business_Case__c
                                            Where Id =: invSchId
                                            Limit 1];
            isID = isList[0].Id;
            isNum = isList[0].Investment_Schedule_ID__c;
            isName = isList[0].Name;
            invShdlStatus = isList[0].Status__c;
            
            System.debug('Status VAlue:--'+invShdlStatus);

        }
        newVariation.Initiated_By__c = UserInfo.getUserId();
        newVariation.Variation_Initiation_Date__c = System.today();
    }
 //Insert the variation record.
    public PageReference insertVariation(){

        if(String.isNotBlank(comments)){
            //newVariation.what_is_the_purpose_of_this_variation__c = purpose;
            newVariation.Comments__c = comments;

            try{
                insert newVariation;
            }
            catch(Exception ex){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
            }

            PageReference newpage;
                if(invShdlStrId.length()>=15) {
                    newpage = new PageReference('/' + newVariation.Investment_Schedule__c);
                } else {
                    newpage = new PageReference('/' + newVariation.id);
                }
            newpage.setRedirect(true);
            return newpage;
        }
        else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please Select Mandatory Fields'));
        }

        return null;
    }

    // Cancel the variation creation.
    public PageReference cancelVariation(){

        PageReference newpage ;//= new PageReference();
        if(String.isNotBlank(invShdlStrId)){
            if(invShdlStrId.length() >=15 ) {
                newpage = new PageReference('/' + invSchId);
            } else {
                newpage = new PageReference('/' + invShdlStrId);
            }
        }
        else{
            Map<String, Schema.SObjectType> globalMap = Schema.getGlobalDescribe() ;
            Schema.SObjectType inShdlObj = globalMap.get('Business_Case__c') ;
            Schema.DescribeSObjectResult descResult = inShdlObj.getDescribe() ;
            String keyPrefix = descResult.getKeyPrefix();
            newpage = new PageReference('/'+keyPrefix);
        }
        newpage.setRedirect(true);
        return newpage;
    }
}