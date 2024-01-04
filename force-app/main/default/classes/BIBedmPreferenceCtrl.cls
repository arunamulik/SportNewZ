public class BIBedmPreferenceCtrl {
    
    
    public Subscriber__c sub {get;set;}
    Public Boolean unsubscribe{get;set;}
    Public Boolean isWeek{get;set;}
    Public Boolean isMonth{get;set;}
    public boolean displayPopUp {get;set;}
    Public Id subid;
    
    public BIBedmPreferenceCtrl(ApexPages.StandardController controller) {
        //unsubscribe=false; 
        isWeek =false;
        isMonth =false;
        
        this.sub = (Subscriber__c)controller.getRecord();
        subid= System.currentPageReference().getParameters().get('subid');
        
        if(subid!= null)
        {
            System.debug('subid : '+subid);
            this.populateData();
            
        }
        
    }
    
    public void makeUnsubscribe(){
        
        System.debug('Weekly : '+sub.Weekly__c);
        System.debug('Monthly : '+sub.Monthly__c);
        if(sub.Weekly__c == true || sub.Monthly__c == true)
        {
            if(unsubscribe==true)
                unsubscribe = false;
        }
        
        if(sub.Weekly__c == false && sub.Monthly__c == false)
        {
            if(unsubscribe==false)
            {
                unsubscribe = true;
                sub.Balance_is_Better__c = false;
            }
        }
        
        
        
        
    }
    
    
    public void balanceisbetterChecked(){
        if(unsubscribe==true){
            
            System.debug('Value :  '+unsubscribe);
            sub.Balance_is_Better__c = false;
            sub.Weekly__c = false;
            sub.Monthly__c = false;
        }
        
    }
    
    public void populateData() {
        
        List<SObject> slist=new List<SObject>();
        List<Subscriber__c> matchingSubscriberList = new List<Subscriber__c>();
        matchingSubscriberList = [SELECT Id,Balance_is_Better__c, Monthly__c, Weekly__c
                                  FROM Subscriber__c
                                  WHERE Id = :subid
                                  AND RecordType.Name='Public'
                                  LIMIT 1];
        
        slist.addAll(matchingSubscriberList);
        system.debug('***slist : '+slist);
        
        for(SObject lstExa : slist) {
            
            sub.Monthly__c = (Boolean)lstExa.get('Monthly__c');
            sub.Weekly__c = (Boolean)lstExa.get('Weekly__c');
            
        }
        
    }
    
    public void saveRecord() {
        updateSubscriber();
        
    }
    
    public void updateSubscriber() {
        Subscriber__c subscriberToUpdate = querySubscriberRecord();
        system.debug('subscriberToUpdate : '+subscriberToUpdate);
        if(unsubscribe==true){
            subscriberToUpdate.Balance_is_Better__c = FALSE;
        }else{
            subscriberToUpdate.Balance_is_Better__c = TRUE;
        }
        subscriberToUpdate.Monthly__c = sub.Monthly__c;
        subscriberToUpdate.Weekly__c = sub.Weekly__c;            
        
        Update subscriberToUpdate;
        
        displayPopUp = true;
        
        
    }
    
    public void closePopup() {
        displayPopUp = false;
        //displayErrorPopUp = false;
    }
    
    public Subscriber__c querySubscriberRecord() {
        return [SELECT 	Id,Balance_is_Better__c, 
                Monthly__c,Weekly__c
                FROM 	Subscriber__c
                WHERE 	Id = :subid
                AND		RecordType.Name != 'High Performance Sport NZ'
                AND RecordType.Name='Public'
                Limit 	1];
    }
    public void onLoad()
    {
        if(sub.Monthly__c == false && sub.Weekly__c== false)
            unsubscribe = true;
        If(sub.Balance_is_Better__c == true) {
            unsubscribe = false;          
        } 
        /*else{
unsubscribe = true;            
}*/
        If(sub.Monthly__c == true) {
            sub.Monthly__c = true;          
        } 
        else{
            sub.Monthly__c = false;            
        }
        If(sub.Weekly__c == true) {
            sub.Weekly__c = true;          
        } 
        else{
            sub.Weekly__c = false;            
        }
        
    }
}