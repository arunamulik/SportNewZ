/**
 * InitiativeSchedule Class is a controller used to fetch all the intiatives ,related Requirements,Measures and 
   Payments to and display in a PDF format 
 */

public class InitiativeSchedule{
    public Business_Case__c objBusinessCase {get;set;}
    public Payment__c oppInstance{get;set;}
    public Id recId;
    
    public List<Initiative__c> lstInitiative{get; set;}
    public List<Payment__c> lstPayment{get; set;}
    
    public Map<String,List<Requirement__c>> mapwithNameAndRequirement{get;set;}
    public Map<Id,Map<String,List<Requirement__c>>> mapwithInitiativeIdAndMapofRequirement{get;set;}
    public Map<String,List<Measure__c>> mapwithNameAndMeasure{get;set;}
    public Map<Id,Map<String,List<Measure__c>>> mapwithInitiativeIdAndMapofMeasure{get;set;}
    public Map<Date,Payment__c> mapwithPaymentDateandAmount{get;set;}
    public Map<String,Payment__c> mapwithPaymentFinancialyearDateandAmount{get;set;}
    public Map<String,Map<String,Payment__c>> mapwithInitiativeIdAndMapofFinancialyear{get;set;}
    public Map<Id,List<Payment__c>> mapwihtInsitativeIdAndpayment{get;set;}
    public Map<Id,String> mapwithInitiaticeIdandInitiativename{get;set;}
    
    public Set<String> setReqName;
    public Set<String> setReqDescription;
    public Set<String> setMeasureName;
    public Set<String> setMeasureDescription;
     
    public Decimal sumAmount {get;set;}
    public boolean blnApproved {get;set;}
    public boolean blnTnC {get;set;}

    public InitiativeSchedule(ApexPages.StandardController stdController) {
        this.objBusinessCase = (Business_Case__c)stdController.getRecord();
       /* recId = apexpages.currentpage().getparameters().get('id');*/
        blnApproved = false;
        blnTnC = false;
        this.objBusinessCase = [Select name,Organisation__r.Name,Total_Amount__c,T_Cs__c,
                                       Executive_Summary__c,Status__c,Actual_Approval_Date__c,
                                       Actual_Approver_Title__c,Actual_Approver_Name__c,
                                       Actual_Approver_Signature__c,Actual_Approver_Signature_URL__c,
                                       Commencement_Date__c,
                                       End_Date__c,
                                       Variation_Count__c 
                                From Business_Case__c
                                Where id =: this.objBusinessCase.id];
                                
        if(objBusinessCase.Status__c == 'Approved' || objBusinessCase.Status__c == 'Signed') {
            blnApproved = true;
        }
        
        if(String.isNotBlank(objBusinessCase.T_Cs__c)) {
            blnTnC = true;
        }
        oppInstance = new Payment__c();
        mapwithNameAndRequirement = new Map<String,List<Requirement__c>>();
        mapwithInitiativeIdAndMapofRequirement = new Map<Id,Map<String,List<Requirement__c>>>();
        mapwithNameAndMeasure = new  Map<String,List<Measure__c>>();
        mapwithInitiativeIdAndMapofMeasure = new Map<Id,Map<String,List<Measure__c>>>();
        mapwithPaymentDateandAmount = new Map<Date,Payment__c>();
        mapwithPaymentFinancialyearDateandAmount = new Map<String,Payment__c>();
        mapwithInitiativeIdAndMapofFinancialyear = new Map<String,Map<String,Payment__c>>();
        mapwihtInsitativeIdAndpayment = new Map<Id,List<Payment__c>>();
        mapwithInitiaticeIdandInitiativename = new Map<Id,String>();
        fetchInitiative();
        PageReference p = Apexpages.currentPage();
        p.getHeaders().put('content-disposition', 'inline; filename=' + Label.ReportName + ' '+ objBusinessCase.Name +'.pdf');
    }
    
  /**
   * Fetch Initiative is used to fetch all the inititatives, related Requirements,Measures and payments
   */
    public void fetchInitiative() {
        
        
        lstPayment = new List<Payment__c>();
        sumAmount = 0;
        
        lstInitiative = [Select Business_Case__r.name,
                                Business_Case__r.Executive_Summary__c,
                                Business_Case__r.Commencement_Date__c,
                                Business_Case__r.End_Date__c,
                                Name,
                                Description__c,
                                Start_Date__c,
                                End_Date__c,
                                Type__c,
                                Details__c,Planned__c,
                                (Select Name,
                                        Description__c,
                                        Due_Date__c,
                                        Status__c
                                 From Requirements__r
                                 Where Status__c != 'Cancelled'
                                 AND Status__c != 'Completed'
                                 order by name,Due_Date__c),
                                
                                (Select Name,
                                        Description__c,
                                        Baseline_Formula__c,
                                        Target_Formula__c,
                                        Target_Date__c,
                                 		Status__c
                                 From Measures__r
                                 Where Status__c != 'Cancelled'
                                 AND Status__c != 'Met'
                                 AND Status__c != 'Partially Met'	
                                 order by name,Target_Date__c)
                         From Initiative__c
                         Where Business_Case__r.Id =: this.objBusinessCase.id];
                         
        lstPayment = [Select Initiative__r.Id,
                             Initiative__r.name, 
                             Date__c, 
                             Amount__c ,
                             Financial_Year__c
                      From Payment__c
                      Where Initiative__r.Business_Case__c =:this.objBusinessCase.id 
                      	   AND Status__c != 'Cancelled'
                      order by  Date__c ASC];
        
        // Callculate sum amount              
        for(Payment__c objPayment : lstPayment) {
            
            Payment__c oppAmount = new Payment__c();
            if(objPayment.Date__c != null) {
                        
                if(mapwithPaymentDateandAmount.containskey(objPayment.Date__c)){
                    
                    oppAmount = mapwithPaymentDateandAmount.get(objPayment.Date__c);
                    
                    if(objPayment.Amount__c != null)
                    oppAmount.Amount__c =  oppAmount.Amount__c + objPayment.Amount__c;
                    
                    mapwithPaymentDateandAmount.put(objPayment.Date__c,oppAmount);
                }            
                else {
                    if(objPayment.Amount__c != null)
                    oppAmount.Amount__c = objPayment.Amount__c;
                    
                    mapwithPaymentDateandAmount.put(objPayment.Date__c,oppAmount);
                }   
            }
            
            if(objPayment.Initiative__r.Id != null) {
                if(mapwihtInsitativeIdAndpayment.containskey(objPayment.Initiative__r.Id)) {
                    mapwihtInsitativeIdAndpayment.get(objPayment.Initiative__r.Id).add(objPayment);
                }
                else {
                    mapwihtInsitativeIdAndpayment.put(objPayment.Initiative__r.Id,new List<Payment__c>{objPayment});
                }
            }
            
            if(objPayment.Amount__c != null)
            sumAmount = sumAmount + objPayment.Amount__c;
        }
        
        
        oppInstance.Amount__c = sumAmount;
                        
        for(Initiative__c objInitiative : lstInitiative) {
            setReqDescription = new Set<String>();
            setMeasureDescription = new Set<String>();
            Payment__c oppAmount = new Payment__c();
            mapwithNameAndRequirement = new Map<String,List<Requirement__c>>();
            mapwithNameAndMeasure = new  Map<String,List<Measure__c>>();
            mapwithPaymentFinancialyearDateandAmount = new Map<String,Payment__c>();
            
            
            // Map for Initiative id and name usefull for displaying name in payments
            
            mapwithInitiaticeIdandInitiativename.put(objInitiative.Id,objInitiative.Name);
            
            // Insert values in Map for Requirements
            for(Requirement__c objRequirement : objInitiative .Requirements__r) {
                //if(objRequirement.Status__c != 'Cancelled'){
                    string tempreq = objRequirement.Name.trim();
                    
                    if(objRequirement.Description__c != null) {
                        tempreq = tempreq + objRequirement.Description__c.trim();
                    }
                    else {
                        tempreq = tempreq + objRequirement.Description__c;
                    }
                    if(setReqDescription.contains(tempreq.trim())) {
                        objRequirement.Description__c = null;
                    }
                    else {
                        if(!String.isBlank(objRequirement.Description__c))
                        setReqDescription.add(tempreq.trim());
                    }
                    if(mapwithNameAndRequirement.containskey(objRequirement.Name)){
                        
                        mapwithNameAndRequirement.get(objRequirement.Name).add(objRequirement);
                    }            
                    else {
                        mapwithNameAndRequirement.put(
                            objRequirement.Name,new List<Requirement__c>{objRequirement});
                    }
                }
            //}
            
            if(mapwithInitiativeidAndMapofRequirement.containskey(objInitiative.Id)) {
                mapwithInitiativeidAndMapofRequirement.put(objInitiative.Id,mapwithNameAndRequirement);             
            }
            else {
                mapwithInitiativeidAndMapofRequirement.put(objInitiative.Id,mapwithNameAndRequirement);
            }
        
            // Insert values in Map for Measures
            
            for(Measure__c objMeasure : objInitiative .Measures__r) {
                //if(objMeasure.Status__c != 'Cancelled'){
                    String temp = objMeasure.Name.trim();
                    
                    if(objMeasure.Description__c != null) {
                        temp = temp + objMeasure.Description__c.trim();
                    }
                    else {
                        temp = temp + objMeasure.Description__c;
                    }
                    
                    if(setMeasureDescription.contains(temp.trim())) {
                        objMeasure.Description__c = null;
                    }
                    else {
                        if(!String.isBlank(objMeasure.Description__c))
                            setMeasureDescription.add(temp.trim());
                    }
                    if(mapwithNameAndMeasure.containskey(objMeasure.Name)) {
                        mapwithNameAndMeasure.get(objMeasure.Name).add(objMeasure);
                    }            
                    else {
                        mapwithNameAndMeasure.put(objMeasure.Name,new List<Measure__c>{objMeasure});
                    }
                }
           // }
            
            if(mapwithInitiativeIdAndMapofMeasure.containskey(objInitiative.Id)) {
                mapwithInitiativeIdAndMapofMeasure.put(objInitiative.Id,mapwithNameAndMeasure);             
            }
            else{
                mapwithInitiativeIdAndMapofMeasure.put(objInitiative.Id,mapwithNameAndMeasure);
            }
            
            if(mapwihtInsitativeIdAndpayment.containskey(objInitiative.Id)) {
                for(Payment__c objPayment : mapwihtInsitativeIdAndpayment.get(objInitiative.Id)) {
                    if(objPayment.Financial_Year__c != null) {
                        oppAmount = new Payment__c();
                        if(mapwithPaymentFinancialyearDateandAmount.containskey(objPayment.Financial_Year__c)) {
                    
                            oppAmount = mapwithPaymentFinancialyearDateandAmount.get(objPayment.Financial_Year__c);
                            oppAmount.Amount__c =  oppAmount.Amount__c + objPayment.Amount__c;
                            mapwithPaymentFinancialyearDateandAmount.put(objPayment.Financial_Year__c,oppAmount);
                        }            
                        else {
                            oppAmount.Amount__c = objPayment.Amount__c;
                            mapwithPaymentFinancialyearDateandAmount.put(
                            objPayment.Financial_Year__c,oppAmount);
                        }
                
                
                    }
            
                    if(objPayment.Initiative__r.name != null) {
                        if(mapwithInitiativeIdAndMapofFinancialyear.containskey(objPayment.Initiative__c)) {
                            mapwithInitiativeIdAndMapofFinancialyear.put(objPayment.Initiative__c,mapwithPaymentFinancialyearDateandAmount);           
                        }
                        else {
                            mapwithInitiativeIdAndMapofFinancialyear.put(objPayment.Initiative__c,mapwithPaymentFinancialyearDateandAmount);
                        }
                    }
                }
            }
        }
   }
}