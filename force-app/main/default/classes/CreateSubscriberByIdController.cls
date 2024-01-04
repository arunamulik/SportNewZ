/*--------------------------------------------------------------
Company:    Eternus Solutions
Description:VF page controller class
Test Class: CreateSubscriberByIdControllerTest   

History
04-10-2022      Aruna Mulik  Modified 
--------------------------------------------------------------*/
public class CreateSubscriberByIdController {
	 public Boolean firstNameEmpty {get;set;}
    public Boolean lastNameEmpty {get;set;}
    public Boolean emailEmpty {get;set;}
    public Boolean locationEmpty {get;set;}
    public Boolean roleEmpty {get;set;}
    public Boolean orgEmpty {get;set;}
    public Boolean youthEmpty {get;set;}
    public Boolean partnerEmpty {get; set;}
    public Boolean koWaiKoeEmpty {get;set;}
    public Boolean updateRec {get;set;}
    public Boolean disabled {get;set;}
    public Subscriber__c sub {get;set;}
    public boolean displayPopUp {get;set;}
    public boolean displayErrorPopUp {get;set;}
    public String email;
    Public Id subid;
    public boolean disabilitySectorNews {get;set;}
    public boolean kaupapaMaoriNews {get;set;}
    public boolean balanceisbetter {get;set;}
    public boolean activerecreation {get;set;}
    public boolean HighPerformanceSportNewZealand {get;set;}
    public boolean sectorUpdate {get;set;}
    public boolean duprec = false;
    
    public CreateSubscriberByIdController(ApexPages.StandardController controller) {
        
        displayPopUp = false;
        displayErrorPopUp = false;
        updateRec = false;
        
        disabilitySectorNews = false;
        kaupapaMaoriNews = false;
        HighPerformanceSportNewZealand = false;
        sectorUpdate = false;
        
        this.sub = (Subscriber__c)controller.getRecord();
        firstNameEmpty = false;
        system.debug('In Constructor');

        subid= System.currentPageReference().getParameters().get('subid');
		
        if(subid!= null)
        {
            System.debug('subid : '+subid);
            this.populateData();
            duprec = true;
        }
            
    }
    
    public void onLoad()
    {
         If(sub.Kaupapa_Maori_News__c == true) {
            kaupapaMaoriNews = true; 
        } 
        else{
            kaupapaMaoriNews = false;  
        }
        
        If(sub.Sector_Update__c == true) {
            sectorUpdate = true;          
        } 
        else{
            sectorUpdate = false;            
        }
        
        If(sub.Balance_is_Better__c == true) {
            balanceisbetter = true;          
        } 
        else{
            balanceisbetter = false;            
        }
        If(sub.Active_Recreation__c == true) {
            activerecreation = true;          
        } 
        else{
            activerecreation = false;            
        }
    }
    
    public void HighPerformanceSportNewZealandChecked(){
        If(HighPerformanceSportNewZealand == true) {
            HighPerformanceSportNewZealand = false; 
        } 
        else{
            HighPerformanceSportNewZealand = true;  
        }
        
    }
    
    public void balanceisbetterChecked(){
        If(balanceisbetter == true) {
            balanceisbetter = false; 
        } 
        else{
            balanceisbetter = true;  
        }
        
    }
    
    public void activerecreationChecked(){
        If(activerecreation == true) {
            activerecreation = false; 
        } 
        else{
            activerecreation = true;  
        }
        
    }
    
    public void kaupapaMaoriNewsChecked() {
        If(kaupapaMaoriNews == true) {
            kaupapaMaoriNews = false; 
        } 
        else{
            kaupapaMaoriNews = true;  
        }
    }
    
    /*public void disabilityChecked() {
        If(disabilitySectorNews == true) {
            disabilitySectorNews = false;          
        } 
        else{
            disabilitySectorNews = true;            
        }
    }*/
    
    public void sectorUpdateChecked() {
        If(sectorUpdate == true) {
            sectorUpdate = false;          
        } 
        else{
            sectorUpdate = true;            
        }
    }
    
    public boolean fieldsValidation() {
        
        if(sub.First_Name__c==null) {
            firstNameEmpty = true;
        }
        else {
            firstNameEmpty = false;
        }
        
        if(sub.Last_Name__c==null) {
            lastNameEmpty = true;
        }
        else {
            lastNameEmpty = false;
        }
        
        if(sub.Email_Address__c==null) {
            emailEmpty = true;
        }
        else {
            emailEmpty = false;
        }
        
        if(sub.Location__c==null) {
            locationEmpty = true;
        }
        else {
            locationEmpty = false;
        }
        
        if(sub.Role__c==null && kaupapaMaoriNews==false && balanceisbetter ==false){
            roleEmpty = true;
        }
        else {
            roleEmpty = false;
        }
        
        if(sub.Youth_sport_options__c==null && balanceisbetter==true) {
            youthEmpty = true;
        }
        else {
            youthEmpty = false;
        }
        
        if(sub.Organisation__c==null && sectorUpdate) {
            orgEmpty = true;
        }
        else {
            orgEmpty = false;
        }
        
        if(sub.Partner_Type__c==null && sectorUpdate) {
            partnerEmpty = true;
        }
        else {
            partnerEmpty = false;
        }
        
        if(sub.Ko_wai_koe__c==null && KaupapaMaoriNews) {
            koWaiKoeEmpty = true;
        }
        else {
            koWaiKoeEmpty = false;
        }
        
        if(!firstNameEmpty && !lastNameEmpty && !emailEmpty && !roleEmpty && !locationEmpty && !partnerEmpty && !orgEmpty && !koWaiKoeEmpty && !youthEmpty) {
            return true;
        }
        else {
            return false;
        }
    }
    
    public void populateData() {
    
        List<SObject> slist=new List<SObject>();
        List<Subscriber__c> matchingSubscriberList = new List<Subscriber__c>();
        matchingSubscriberList = [SELECT Id,Email_Address__c,First_Name__c,Last_Name__c,Balance_is_Better__c,  
                                    NZ_Coach__c, Healthy_Active_Learning__c, Sector_Update__c, Kaupapa_Maori_News__c,
                                    High_Performance_Sport_New_Zealand__c,Location__c, Role__c,Youth_sport_options__c,
                                    Organisation__c, Partner_Type__c, Ko_wai_koe__c, Do_you_identify_as_Maori__c,Active_Recreation__c
                                    FROM Subscriber__c
                                    WHERE Id = :subid
                                    AND RecordType.Name='Public'
                                    LIMIT 1];

        slist.addAll(matchingSubscriberList);

        for(SObject lstExa : slist) {
            
            sub.Balance_is_Better__c = (Boolean)lstExa.get('Balance_is_Better__c');
            sub.Active_Recreation__c= (Boolean)lstExa.get('Active_Recreation__c');
            //sub.NZ_Coach__c = (Boolean)lstExa.get('NZ_Coach__c');
            sub.Healthy_Active_Learning__c = (Boolean)lstExa.get('Healthy_Active_Learning__c');
            sub.Sector_Update__c = (Boolean)lstExa.get('Sector_Update__c');
            sub.Kaupapa_Maori_News__c = (Boolean)lstExa.get('Kaupapa_Maori_News__c');
            sub.High_Performance_Sport_New_Zealand__c = (Boolean)lstExa.get('High_Performance_Sport_New_Zealand__c');
            sub.First_Name__c  = (String)lstExa.get('First_Name__c');
            sub.Last_Name__c = (String)lstExa.get('Last_Name__c');
            sub.Email_Address__c = (String)lstExa.get('Email_Address__c');
            sub.Location__c = (String)lstExa.get('Location__c');
            sub.Role__c = (String)lstExa.get('Role__c');
            if(lstExa.get('Youth_sport_options__c')!=null)
            sub.Youth_sport_options__c = (String)lstExa.get('Youth_sport_options__c');
            if(lstExa.get('Organisation__c')!=null)
                sub.Organisation__c=(string)lstExa.get('Organisation__c');
            if(lstExa.get('Partner_Type__c')!=null)
                sub.Partner_Type__c=(string)lstExa.get('Partner_Type__c');
            if(lstExa.get('Ko_wai_koe__c')!=null)
                sub.Ko_wai_koe__c=(string)lstExa.get('Ko_wai_koe__c');
             if(lstExa.get('Do_you_identify_as_Maori__c')==true)
                sub.Do_you_identify_as_Maori__c=(Boolean)lstExa.get('Do_you_identify_as_Maori__c');
        }

    }
	
    public void saveRecord() {
           updateSubscriber();
           updateRec = false;
       }
    
    public void updateSubscriber() {
        
        if(fieldsValidation()) {
            
            Subscriber__c subscriberToUpdate = querySubscriberRecord();
            displayErrorPopUp = false;
            subscriberToUpdate.Balance_is_Better__c = sub.Balance_is_Better__c;
            subscriberToUpdate.Active_Recreation__c=sub.Active_Recreation__c;
            subscriberToUpdate.NZ_Coach__c = sub.NZ_Coach__c;
            subscriberToUpdate.Healthy_Active_Learning__c = sub.Healthy_Active_Learning__c;
            subscriberToUpdate.Sector_Update__c = sub.Sector_Update__c;
           // subscriberToUpdate.Disability_Sector_News__c = sub.Disability_Sector_News__c;
            subscriberToUpdate.First_Name__c = sub.First_Name__c;
            subscriberToUpdate.Last_Name__c = sub.Last_Name__c;
            subscriberToUpdate.Email_Address__c = sub.Email_Address__c;
            subscriberToUpdate.Location__c = sub.Location__c;
            subscriberToUpdate.Role__c = sub.Role__c;
            subscriberToUpdate.Youth_sport_options__c = sub.Youth_sport_options__c;
            subscriberToUpdate.Organisation__c = sub.Organisation__c;
            subscriberToUpdate.Partner_Type__c = sub.Partner_Type__c;
            subscriberToUpdate.Kaupapa_Maori_News__c = sub.Kaupapa_Maori_News__c;
            subscriberToUpdate.Ko_wai_koe__c = sub.Ko_wai_koe__c;
            subscriberToUpdate.Do_you_identify_as_Maori__c = sub.Do_you_identify_as_Maori__c;
           // subscriberToUpdate.High_Performance_Sport_New_Zealand__c = sub.High_Performance_Sport_New_Zealand__c;
            Update subscriberToUpdate;
            disabled = true;
            displayPopUp = true;
        }
    }
    public void closePopup() {
        displayPopUp = false;
    }
   
    public Subscriber__c querySubscriberRecord() {
        return [SELECT 	Id,Balance_is_Better__c,
                Active_Recreation__c,
                NZ_Coach__c, 
                Healthy_Active_Learning__c,
                Sector_Update__c, 
                Disability_Sector_News__c,
                First_Name__c, 
                Last_Name__c, 
                Email_Address__c,
                Organisation__c, 
                Partner_Type__c, 
                Location__c, 
                Kaupapa_Maori_News__c,
                Ko_wai_koe__c,
                Do_you_identify_as_Maori__c,
                Role__c,
				Youth_sport_options__c
                FROM 	Subscriber__c
                WHERE 	Id = :subid
                AND		RecordType.Name != 'High Performance Sport NZ'
                AND RecordType.Name='Public'
                Limit 	1];
    }
    
}