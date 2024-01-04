public with sharing class PaymentTriggerhandler {
    public static Boolean getCatch = false;
    // Added by JTan 19/06/2017 begins
    public static void validatePayments(List<Payment__c> payments) {
        system.debug('Inside PaymentTriggerhandler validatePayments() method');
        
        Map<Id, List<Payment__c>> mapOfPayInvestAllocation = new Map<Id, List<Payment__c>>();
        List<Payment__c> paymentLst = new List<Payment__c>();
        Set<Id> investmentAreaAllocIds = new Set<Id>();
        Set<Id> updatedPaymentIds = new Set<Id>();
        Set<Id> initiativeIds = new Set<Id>();
        
        // Get the list of Payments that have valid status and are associated with IAAs and Investment Schedules
        for(Payment__c pay : payments) {
            if(pay.Initiative__c <> NULL) {
                initiativeIds.add(pay.Initiative__c);
            }
        }
        Map<Id, Initiative__c> initiativeMap = new Map<Id, Initiative__c>([SELECT Id, Business_Case__c FROM Initiative__c WHERE Id IN :initiativeIds]);
        for(Payment__c pay : payments) {
            if(pay.Status__c != 'Cancelled' &&
               pay.Investment_Area_Allocation__c != NULL &&
               initiativeMap.containsKey(pay.Initiative__c) &&
               initiativeMap.get(pay.Initiative__c).Business_Case__c != NULL) {
                paymentLst.add(pay);
            }
        }
        
        for(Payment__c pay : paymentLst) {
            // Get associated IAA Ids
            if(pay.Investment_Area_Allocation__c <> NULL) {
                investmentAreaAllocIds.add(pay.Investment_Area_Allocation__c);
            }
            // Get updated Payment Ids for comparison later
            if(pay.Id <> NULL) {
                updatedPaymentIds.add(pay.Id);
            }
        }
        
        // Get all the Payments in the associated IAAs excluding the Payments on trigger
        List<Payment__c> allPaymentLst = [SELECT Amount__c, Date__c, Investment_Area_Allocation__c, Status__c, Initiative__c
                                          FROM Payment__c
                                          WHERE Investment_Area_Allocation__c in :investmentAreaAllocIds AND Initiative__r.Business_Case__c != NULL
                                          AND Status__c != 'Cancelled' AND Id NOT IN :paymentLst];
        // Add the Payments on trigger
        allPaymentLst.addAll(paymentLst);
        
        // Initialise mapOfPayInvestAllocation
        if(!allPaymentLst.isEmpty()) {
            for(Payment__c pay : allPaymentLst) {
                if(pay.Investment_Area_Allocation__c <> NULL) {
                    if(!mapOfPayInvestAllocation.containsKey(pay.Investment_Area_Allocation__c)) {
                        mapOfPayInvestAllocation.put(pay.Investment_Area_Allocation__c, new List<Payment__c>());
                    }
                    mapOfPayInvestAllocation.get(pay.Investment_Area_Allocation__c).add(pay);
                }
            }
        }
        
        // Compare the Payment amounts
        if(!mapOfPayInvestAllocation.isEmpty()) {
            Map<Id, Investment_Area_Allocation__c> invAreaAllocation = new Map<Id, Investment_Area_Allocation__c>(
                [SELECT Id, Investment_Area__c, Amount__c, Funding_Allocation_End_Date__c, Funding_Allocation_Start_Date__c
                 FROM Investment_Area_Allocation__c WHERE Id IN :mapOfPayInvestAllocation.keySet()]);
            
            for(Id iAllocation : mapOfPayInvestAllocation.keySet()) {
                Double totalPaymentAmt = 0;
                for(Payment__c pay : mapOfPayInvestAllocation.get(iAllocation)) {
                    Date startDate = Date.newInstance(invAreaAllocation.get(iAllocation).Funding_Allocation_Start_Date__c.year(),invAreaAllocation.get(iAllocation).Funding_Allocation_Start_Date__c.month(),invAreaAllocation.get(iAllocation).Funding_Allocation_Start_Date__c.day());
                    Date endDate = Date.newInstance(invAreaAllocation.get(iAllocation).Funding_Allocation_End_Date__c.year(),invAreaAllocation.get(iAllocation).Funding_Allocation_End_Date__c.month(),invAreaAllocation.get(iAllocation).Funding_Allocation_End_Date__c.day());
                    Date payDate = Date.newInstance(pay.Date__c.year(),pay.Date__c.month(),pay.Date__c.day());
                    
                    if(payDate >= startDate && payDate <= endDate) {
                        totalPaymentAmt += pay.Amount__c;
                    }
                }
                if(totalPaymentAmt > invAreaAllocation.get(iAllocation).Amount__c) {                  
                  for(Payment__c pay : mapOfPayInvestAllocation.get(iAllocation)) {
                        if(pay.Id == NULL || (pay.Id <> NULL && updatedPaymentIds.contains(pay.Id))) {
                            pay.addError('The sum of payments exceeds the funding available in the Investment Area Allocation by financial year.');
                        }
                    }
                }
            }
        }
    }
    // Added by JTan 19/06/2017 ends
    
    //after insert/after update
    public static void updatePartner(List<Payment__c> paymentList){
         system.debug('Inside PaymentTriggerhandler updatePartner() method');
        //get the partner field 
         set<id> InitiativeIdSet = new set<Id>();
        
         for (Payment__c pay : paymentList ){
            InitiativeIdSet.add(pay.Initiative__c);
         }
        
         map<id, Initiative__c> mapinitiative = new map<id,Initiative__c>([SELECT ID, Partner__c, Plan__c
                                                                           FROM Initiative__c
                                                                           WHERE id =:InitiativeIdSet]);
         if (mapinitiative.size() > 0){                                                                  
            for (Payment__c item : paymentList){
                item.Partner__c = mapinitiative.get(item.Initiative__c).Partner__c;
                item.Plan__c = mapinitiative.get(item.Initiative__c).Plan__c;
            }
         }
         
    }
    
    public static void processPayments(List<Payment__c> paymentList) {
         system.debug('Inside PaymentTriggerhandler processPayments() method');
        //Updated by RUL 15/11/2018 to update payments only to associated Initiaitve
        //Set<Id> partnerIdSet = new Set<Id>();
        Set<Id> InitiativeSet = new Set<Id>();// Added by RUL 15/11/2018
        Set<Id> paymentIdSet = new Set<Id>();
        Set<Id> iaaIdSet = new Set<Id>();// Added by JTan 19/06/2017
        for(Payment__c pay : paymentList){
            InitiativeSet.add(pay.Initiative__c);
            paymentIdSet.add(pay.Id);
            // Added by JTan 19/06/2017 begins
            if(String.isNotBlank(pay.Investment_Area_Allocation__c))              
              iaaIdSet.add(pay.Investment_Area_Allocation__c);
            // Added by JTan 19/06/2017 ends
        }
        checkRequirements(InitiativeSet, paymentIdSet);
        // Added by JTan 19/06/2017 begins
        if(!iaaIdSet.isEmpty())            rollupPaymentsOnIAA(iaaIdSet);
        // Added by JTan 19/06/2017 ends
    }

    public static void updatedPayments(Map<Id, Payment__c> oldMap, List<Payment__c> paymentList) {
                system.debug('Inside PaymentTriggerhandler updatedPayments() method');

        //Updated by RUL 15/11/2018 to update payments only for associated Initiative instead of organisation as per SNIS-58
        //Set<Id> partnerIdSet = new Set<Id>();
        Set<Id> InitiativeSet = new Set<Id>();//Added bu RUL 15/11/2018
        Set<Id> paymentIdSet = new Set<Id>();
        Set<Id> iaaIdSet = new Set<Id>();// Added by JTan 19/06/2017
        for(Payment__c pay : paymentList) {
            if(pay.Date__c != oldMap.get(pay.Id).Date__c || pay.Initiative__c != oldMap.get(pay.Id).Initiative__c) {     
              InitiativeSet.add(pay.Initiative__c);//Added by RUL 15/11/2018        
              paymentIdSet.add(pay.Id);
            }
            // Added by JTan 19/07/2017 begins
            if(pay.Amount__c != oldMap.get(pay.Id).Amount__c ||
               pay.Status__c != oldMap.get(pay.Id).Status__c ||
               pay.Investment_Area_Allocation__c != oldMap.get(pay.Id).Investment_Area_Allocation__c) {
                   if(String.isNotBlank(pay.Investment_Area_Allocation__c))
                       iaaIdSet.add(pay.Investment_Area_Allocation__c);
                   if(String.isNotBlank(oldMap.get(pay.Id).Investment_Area_Allocation__c))                      
                    iaaIdSet.add(oldMap.get(pay.Id).Investment_Area_Allocation__c);
            }
            // Added by JTan 19/07/2017 ends
        }
        checkRequirements(InitiativeSet, paymentIdSet);//Updated by RUL 15/11/2018
        // Added by JTan 19/06/2017 begins
        if(!iaaIdSet.isEmpty())
            rollupPaymentsOnIAA(iaaIdSet);
        // Added by JTan 19/06/2017 ends
    }
    
    // Added by JTan 19/07/2017 begins
    public static void rollupPaymentsOnIAA(Set<Id> iaaIDs) {
        system.debug('Inside PaymentTriggerhandler rollupPaymentsOnIAA() method');

        List<Investment_Area_Allocation__c> iaaToUpdate = new List<Investment_Area_Allocation__c>();
        
        Map<Id, Investment_Area_Allocation__c> iaaMap = new Map<Id, Investment_Area_Allocation__c>([SELECT Id, Payments__c
                                                                                                    FROM Investment_Area_Allocation__c WHERE Id IN :iaaIDs]);
        
        AggregateResult[] aggregateResults = [SELECT SUM(Amount__c) AMOUNT, Investment_Area_Allocation__c FROM Payment__c
                                              WHERE Investment_Area_Allocation__c IN :iaaIDs AND Amount__c != null
                                              AND Status__c != 'Cancelled' GROUP BY Investment_Area_Allocation__c];
        
        for(AggregateResult ar : aggregateResults) {
            if(iaaMap.containsKey( (Id) ar.get('Investment_Area_Allocation__c') )) {
                Investment_Area_Allocation__c iaa = iaaMap.get( (Id) ar.get('Investment_Area_Allocation__c') );
                if(iaa.Payments__c != (Decimal) ar.get('AMOUNT')) {
                    iaa.Payments__c = (Decimal) ar.get('AMOUNT');
                    iaaToUpdate.add(iaa);
                }
            }
        }
        
        if(!iaaToUpdate.isEmpty()){
             if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                 update iaaToUpdate;
             }
        }
           
    }
    // Added by JTan 19/07/2017 ends
    
    public static void checkRequirements(Set<Id> InitiativeSet, Set<Id> paymentIdSet) {
                 system.debug('Inside PaymentTriggerhandler checkRequirements() method');

      /*
      // Kahiwi Fixes - commented out code related to 'Organisation Requirement' record type
        Id orgRecordTypeId = Schema.SObjectType.Requirement__c.getRecordTypeInfosByName().get('Organisation Requirement').getRecordTypeId();
        */
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            Id initRecorTypeId = Schema.SObjectType.Requirement__c.getRecordTypeInfosByName().get('Initiative Requirement').getRecordTypeId();
            //Added by RUL on 20/03/2019 for read only record type as per PORT-144
            Id readOnlyRecorTypeId = Schema.SObjectType.Requirement__c.getRecordTypeInfosByName().get('Initiative Requirement Read Only').getRecordTypeId();
            List<Payment__c> updatePaymentList = new List<Payment__c>();        
            Boolean pendingRequirements;
            Boolean overdueRequirements;
           //Updated by RUL 15/11/2018 to fetch Payments and Requirements to associated initiaitves Only as per SNIS-58
            List<Initiative__c> initiativeList = [Select Id, 
                                    (Select Id, Status__c, Date__c, Initiative__r.Investment_Area__c, Pending_Requirements__c, Overdue_Requirements__c from Payments__r where (Status__c != 'Paid' or Status__c != 'Processed' or Status__c != 'Cancelled')),
                                    (Select Id, Hold_Payments__c, RecordTypeId, Due_Date__c, Initiative__r.Investment_Area__c, Status__c FROM Requirements__r WHERE (Status__c = 'Pending' or Status__c = 'Overdue')) 
                                    From Initiative__c where Id in : InitiativeSet];
            if(initiativeList.size() > 0) {
                List<Payment__c> payList = initiativeList.get(0).Payments__r; //Updated by RUL 15/11/2018
                List<Requirement__c> reqList = initiativeList.get(0).Requirements__r; //Updated by RUL 15/11/2018
                if(payList.size() > 0) {
                    for(Payment__c p: payList){ //all payments related to accounts
                        if(paymentIdSet.contains(p.Id)) { // only payments related to initiative
                            //todo check status of payment
                            if(p.Status__c != 'Paid' || p.Status__c != 'Processed' || p.Status__c != 'Cancelled') {
                                pendingRequirements = false;
                                overdueRequirements = false;   
                                //!! todo lessen cpu limit-                  
                                for(Requirement__c req : reqList){
                                    //(org req || init rec && initiative investment area)
                                    //if((req.RecordTypeId == orgrecordtypeid || (req.RecordTypeId == initrecortypeid && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c))){
                                    //updated by RUL on 20/03/2019 to add read only record type check
                                    if((req.RecordTypeId == initrecortypeid || req.RecordTypeId == readOnlyRecorTypeId) && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c){
                                        //req due date is less than payment date
                                        if(req.Hold_Payments__c == true && (req.Status__c == 'Pending' && req.Due_Date__c < p.Date__c)) {
                                            pendingRequirements = true;                                
                                            break; //stops loops as soon as condition is met
                                        }
                                    }
                                }
                                for(Requirement__c req : reqList){
                                    //(org req || init rec && initiative investment area)
                                    //if(req.Hold_Payments__c == true && (req.RecordTypeId == orgrecordtypeid || (req.RecordTypeId == initrecortypeid && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c))){
                                     //updated by RUL on 20/03/2019 to add read only record type check
                                    if(req.Hold_Payments__c == true && (((req.RecordTypeId == initrecortypeid || req.RecordTypeId == readOnlyRecorTypeId) && req.Initiative__r.Investment_Area__c == p.Initiative__r.Investment_Area__c))){
                                        if(req.Status__c == 'Overdue') {
                                            //updated by RUL on 20/03/2019 to add read only record type check
                                            if(req.RecordTypeId == initrecortypeid || req.RecordTypeId == readOnlyRecorTypeId) {
                                                if(p.Initiative__c == req.Initiative__c) {
                                                    overdueRequirements = true;
                                                    break; //stops loops as soon as condition is met
                                                }
                                            } else {
                                                overdueRequirements = true;
                                                break; //stops loops as soon as condition is met                                        
                                            }
                                        }
                                    }
                                }
    
                                if(pendingRequirements <> p.pending_Requirements__c || overdueRequirements <> p.overdue_requirements__c){                       
                                    Payment__c updatedPayment = new Payment__c(Id = p.Id); 
                                    updatedPayment.Pending_Requirements__c = pendingRequirements;
                                    updatedPayment.Overdue_Requirements__c = overdueRequirements;                       
                                    updatePaymentList.add(updatedPayment);                      
                                }                                                          
    
                            }
                        }
                    }
                    if(updatePaymentList.size() > 0)            
                        update updatePaymentList;                                     
                }             
            }
        }
    }

   /*
   * @ Author :- Navneet Rajput
   * @ Description :- Method will inforce to enter initiative fields like Planned amount, expense code, cost center when payment status change to schedule
   * @ Date :- 1st July 2015
   **/
   
   public static void onPaymentStatusChanedToSchedule(Map<Id,Payment__c> newMap,Map<Id,Payment__c> oldMap){
       system.debug('Inside PaymentTriggerhandler onPaymentStatusChanedToSchedule() method');

       set<Id> setOfInitiative = new set<Id>();
       List<Initiative__c> lstOfInitiatives;
       
       if (oldMap<>NULL){
         for (payment__c pay : newMap.values()){
           if (pay.Initiative__c<>NULL){
             setOfInitiative.add(pay.Initiative__c);
           }
         }
         if (setOfInitiative<>NULL && !setOfInitiative.isEmpty()){
           lstOfInitiatives = [SELECT Id,Name,Status__c,Schedule_Payments_Check__c,Security_Schedule_Payments__c,Payments_Scheduled__c,
                          Expense_Code__c,Planned__c,Cost_Centre__c  
                   FROM Initiative__c
                   WHERE Id = : setOfInitiative];
         }          
         
         for (Id key : oldMap.keySet()){
           if (oldMap.get(key).Status__c <>'Scheduled' && newMap.get(key).Status__c =='Scheduled'){
             if(lstOfInitiatives<>NULL && !lstOfInitiatives.isEmpty()){
               //validateInitiativeMandatoryfields(lstOfInitiatives);
               if (lstOfInitiatives<>NULL && !lstOfInitiatives.isEmpty()){
                 for (Initiative__c initiativeObj : lstOfInitiatives){
                   if (initiativeObj.Expense_Code__c<>NULL && initiativeObj.Planned__c<>NULL && initiativeObj.Cost_Centre__c<>NULL){
                     // do nothing
                   } else {
                     //newMap.get(key).addError('Please enter expense code,planned amount and cost center to schedule selected payment for Initiative '+initiativeObj.Name);
                     // Modified Message text on 11 June 2018.
                     newMap.get(key).addError('Please enter expense code,planned amount and cost center on Initiative '+initiativeObj.Name+' to schedule selected payment.');
                     break;
                   }
                 }
               }  
             }
           }
         }
       }
   }

   /*
   * @ Author :- Navneet Rajput
   * @ Description :- Method will inforce to enter status field of payment to Scheduled and send for payment to true
   * @ Date :- 7th July 2015
   **/

   public static void validateStatusToScheduled(Map<Id,Payment__c> newMap){
        system.debug('Inside PaymentTriggerhandler validateStatusToScheduled() method');

        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            List<Payment__c> lstOfPayment = new List<Payment__c>();
            List<Payment__c> tempLstOfPayment = new List<Payment__c>();
    
            if (newMap.keySet()<>NULL && !newMap.isEmpty()){
                lstOfPayment = [SELECT Id,Name,Initiative__r.Business_Case__r.Status__c,Status__c,Initiative__r.Type__c,
                                        Initiative__r.Partner__r.Type,Supplier_Invoice_Date__c,Supplier_Invoice_Number__c 
                                FROM    Payment__c
                                WHERE Id IN :newMap.keySet()];
            }
           // system.debug('--lstOfPayment-->>>'+lstOfPayment);
            if (lstOfPayment<>NULL && !lstOfPayment.isEmpty()){
                for (Payment__c payment : lstOfPayment){
                    if (payment.Initiative__r.Business_Case__r<>NULL &&
                        payment.Initiative__r.Business_Case__r.Status__c =='Signed' && payment.Initiative__r.Type__c != 'Paid to Third Party'
                        && payment.Initiative__r.Partner__r.Type!='Supplier'){
                        if (payment.Status__c=='Draft'){
                            payment.Status__c = 'Scheduled';
                            tempLstOfPayment.add(payment);
                        }
                        // Below code handle scenarios of supplier
                    } else {
                        if(payment.Initiative__r.Business_Case__r<>NULL && 
                            (payment.Initiative__r.Business_Case__r.Status__c =='Approved' || payment.Initiative__r.Business_Case__r.Status__c =='Signed')
                               && payment.Initiative__r.Type__c == 'Paid to Third Party'){
                               
                            if (payment.Status__c=='Draft' && payment.Supplier_Invoice_Date__c<>NULL && 
                              payment.Supplier_Invoice_Number__c<>NULL && !String.isBlank(payment.Supplier_Invoice_Number__c)){
                                payment.Status__c = 'Scheduled';
                                tempLstOfPayment.add(payment);
                            }
                        } else  if(payment.Initiative__r.Business_Case__r<>NULL && 
                                (payment.Initiative__r.Business_Case__r.Status__c =='Approved' || payment.Initiative__r.Business_Case__r.Status__c =='Signed')
                                   && payment.Initiative__r.Type__c == 'Paid Direct' && payment.Initiative__r.Partner__r.Type=='Supplier'){
    
                                if (payment.Status__c=='Draft' && payment.Supplier_Invoice_Date__c<>NULL && 
                                    payment.Supplier_Invoice_Number__c<>NULL && !String.isBlank(payment.Supplier_Invoice_Number__c)){
                                        payment.Status__c = 'Scheduled';
                                        tempLstOfPayment.add(payment);
                                }
                        } /*else if (payment.Initiative__r.Type__c != 'Paid Direct' && payment.Initiative__r.Partner__r.Type!='Supplier' && 
                                (payment.Supplier_Invoice_Date__c<>NULL || (payment.Supplier_Invoice_Number__c<>NULL && !String.isBlank(payment.Supplier_Invoice_Number__c)))){
                                newMap.get(payment.Id).addError('Suppplier Invoice number and Invoice date should not be populated because organization type of initiative is not supplier or Initiative is not paid to third party or status of investment schedule is not approved.');
                        }*/
                    }
                }// end of for loop
                if (tempLstOfPayment<>NULL && !tempLstOfPayment.isEmpty()){
                    try{
                       // system.debug('###tempLstOfPayment--->>>'+tempLstOfPayment);
                        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                            update tempLstOfPayment;
                        }
                    }
                    catch(Exception ex){
                        system.debug('### Exception-->'+ex.getMessage());
                        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
                    }
                }
            }   // end of first if 
        }//End of cpu limit condition
    }

  public static void validateInitiativePlannedAmt(Map<Id,Payment__c> newMap,Map<Id,Payment__c> oldMap){
       system.debug('Inside PaymentTriggerhandler validateInitiativePlannedAmt() method');
    Initiative__c initiative = [SELECT Id,Name,Planned__c,SUM_Payments__c 
                  FROM Initiative__c WHERE Id = :newMap.values()[0].Initiative__c limit 1];
    double totalAmount = 0;              
    //system.debug('initiative >>>>>>>>>>>>>>> '+initiative);
    //system.debug('current payment amount >>>>>>>>>>>'+newMap.values()[0].Amount__c);
   // system.debug('current Planned__c amount >>>>>>>>>>>'+initiative.Planned__c);
   // system.debug('initiative.SUM_Payments__c ########### '+initiative.SUM_Payments__c);
    
    if(oldMap==NULL){
      totalAmount = initiative.SUM_Payments__c+newMap.values()[0].Amount__c;
    } else if (newMap.values()[0].Amount__c != oldMap.values()[0].Amount__c){
      totalAmount = (initiative.SUM_Payments__c-oldMap.values()[0].Amount__c)+newMap.values()[0].Amount__c;
    } else {
      totalAmount = initiative.SUM_Payments__c;
    } 
    if (totalAmount > initiative.Planned__c){
      newMap.values()[0].addError('Its not allowed to add or update payment, because sum of total payment for this initiative is more than planned amount of Initiative.');
    }  
  }
    
    //Changes for Port 112
    public static List<Payment__c> filterPaymentPlan(Map<Id,Payment__c> newMap,Map<Id,Payment__c> oldMap){
        List<Payment__c> paymentlst= new List<Payment__c>();
        for(ID paymentid: newMap.keySet()){
            if(newMap.get(paymentid).status__c != oldMap.get(paymentid).status__c){
                paymentlst.add(newMap.get(paymentid));
            }
        }
        
        return paymentlst;
    }
    //Changes for Port 112   
    public static void updateInvestmentSchedule(List<Payment__c> paymentLst){
         system.debug('Inside PaymentTriggerhandler updateInvestmentSchedule() method');
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            Set<Id> paymentIdSet = new set<Id>();
            Map<Id,List<Payment__c>> investmentAreaId_paymentlst = new Map<Id,List<Payment__c>>();
            List<Business_Case__c> investmentScheduleLst = new List<Business_Case__c>();
            for(Payment__c paymentobj : paymentLst){
                paymentIdSet.add(paymentobj.id);
            }
            for(Payment__c obj : [Select  Id,
                                          Status__c,
                                          Initiative__r.Business_Case__c,
                                          Initiative__r.Business_Case__r.Payment_Status__c
                                  FROM Payment__c
                                  WHERE id IN :paymentIdSet
                                  ]){
                //System.debug('@@@' + obj.Initiative__r.Business_Case__c);
                if(!investmentAreaId_paymentlst.containsKey(obj.Initiative__r.Business_Case__c)){
                   investmentAreaId_paymentlst.put(obj.Initiative__r.Business_Case__c,new List<Payment__c>{obj});
                }else{
                   investmentAreaId_paymentlst.get(obj.Initiative__r.Business_Case__c).add(obj); 
                }
            }
    
            for(Payment__c obj : [Select  Id,
                                          Status__c,
                                          Initiative__r.Business_Case__c,
                                          Initiative__r.Business_Case__r.Payment_Status__c
                                  FROM Payment__c
                                  WHERE Initiative__r.Business_Case__c IN :investmentAreaId_paymentlst.keySet()
                                  AND Id NOT IN :paymentIdSet         
                                  ]){
                investmentAreaId_paymentlst.get(obj.Initiative__r.Business_Case__c).add(obj);
            }
    
            //System.debug('@@@-------' + investmentAreaId_paymentlst.values());
    
            for(Id invareaid: investmentAreaId_paymentlst.keySet()){
                integer paid =0;
                integer partialpaid =0;
    
                List<Payment__c> paymenttemplst = investmentAreaId_paymentlst.get(invareaid);
                for(Payment__c paymentobj: paymenttemplst){
                    //System.debug('paymentstatus @@'+ paymentobj.status__c);
                    if(String.isNotBlank(paymentobj.Status__c) &&  paymentobj.Status__c.equalsIgnoreCase('Paid')){
                       // System.debug('isnide paid');
                        paid = 1;
                    }
                    if(String.isNotBlank(paymentobj.Status__c) &&  !paymentobj.Status__c.equalsIgnoreCase('Paid')){
                        partialpaid = 1;
                    }
                }
               // System.debug(' @paid@ ' + paid + ' @partiatlpaid@ '+partialpaid);
                if(paid == 1 && partialpaid == 0){
                   Business_Case__c obj = new Business_Case__c(id = invareaid);
                   obj.Payment_Status__c = 'Paid';
                   investmentScheduleLst.add(obj); 
                }
                if(paid == 1 && partialpaid == 1){
                   Business_Case__c obj = new Business_Case__c(id = invareaid);
                   obj.Payment_Status__c = 'Partially Paid';
                   investmentScheduleLst.add(obj); 
                }
                if(paid == 0){
                   Business_Case__c obj = new Business_Case__c(id = invareaid);
                   obj.Payment_Status__c = 'Not Paid';
                   investmentScheduleLst.add(obj); 
                }
            }
            if(!investmentScheduleLst.isEmpty()){
                try{
                    if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
                        update investmentScheduleLst;
                    }
                }
                catch(Exception ex){
                    system.debug(' @Payment Exception@ '+ex);
                }
            }
        }
    }
    //Variation related changes
    public static void updateVariation(Map<Id,Payment__c> newPayments, Map<Id,Payment__c> oldPayments){
         system.debug('Inside PaymentTriggerhandler updateVariation() method');
        Set<Id> initiative = new Set<Id>();
        //system.debug('newPayments----------------------'+newPayments.keySet());
        
        for(String paymentId :newPayments.keySet()){
            
            if(((newPayments.get(paymentId).Initiative__c != oldPayments.get(paymentId).Initiative__c) || 
                (newPayments.get(paymentId).Manual_Hold_Reason__c != oldPayments.get(paymentId).Manual_Hold_Reason__c) || 
                (newPayments.get(paymentId).Vendor__c != oldPayments.get(paymentId).Vendor__c) || 
                (newPayments.get(paymentId).Who_did_the_work__c != oldPayments.get(paymentId).Who_did_the_work__c) || 
                (newPayments.get(paymentId).Description__c != oldPayments.get(paymentId).Description__c) || 
                (newPayments.get(paymentId).Date__c != oldPayments.get(paymentId).Date__c) || 
                (newPayments.get(paymentId).Amount__c != oldPayments.get(paymentId).Amount__c) || 
                (newPayments.get(paymentId).GST_Applicable__c != oldPayments.get(paymentId).GST_Applicable__c) || 
                (newPayments.get(paymentId).Supplier_Invoice_Number__c != oldPayments.get(paymentId).Supplier_Invoice_Number__c) || 
                (newPayments.get(paymentId).Supplier_Invoice_Date__c != oldPayments.get(paymentId).Supplier_Invoice_Date__c) || 
                (newPayments.get(paymentId).Overdue_Requirements__c != oldPayments.get(paymentId).Overdue_Requirements__c))){
                //system.debug('Payment changed --------------------');
                if(String.isNotBlank(newPayments.get(paymentId).Initiative__c)){
                    initiative.add(newPayments.get(paymentId).Initiative__c);
                }
            }
        }
        //system.debug('Changed Payments ------------------'+initiative);
        
        if(!initiative.isEmpty()){
            List<Initiative__c> relatedInitiatives = [SELECT Id, 
                                                             Investment_Schedule_Variation__c, 
                                                             Investment_Schedule_Variation__r.Is_Active__c
                                                      FROM   Initiative__c 
                                                      WHERE  Id IN: initiative
                                                     ];
            //system.debug('Related Initiatives ------------------'+relatedInitiatives);
            if(!relatedInitiatives.isEmpty()){
                Set<Variation__c> updateVariation = new Set<Variation__c>();
                for(Initiative__c objInitiative: relatedInitiatives){
                    if(String.isNotBlank(objInitiative.Investment_Schedule_Variation__c)){
                        if(objInitiative.Investment_Schedule_Variation__r.Is_Active__c){
                            
                            //update payment varied
                            updateVariation.add(new Variation__c(
                                Id = objInitiative.Investment_Schedule_Variation__c,
                                Payments_Varied__c = true
                            ));
                        }
                    }
                }
                if(!updateVariation.isEmpty()){
                    List<Variation__c> variationsUpdate = new List<Variation__c>(updateVariation);
                    system.debug('Variations to update -------List------------'+variationsUpdate);
                    update variationsUpdate;
                }
            }
            
        }
    }
    public static void updateOldRecordType(List<Payment__c> listPayment){
         system.debug('Inside PaymentTriggerhandler updateOldRecordType() method');
        if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
            //To have number of SOQL queries executed so far
            Set<String>setRecordTypes = new Set<String>{'Buy_Back_Read_Only','Credit_Read_Only','RUL_Payment_Read_Only','Refund_Read_Only'};
            for(Payment__c objPay : listPayment){
                system.debug('objPay.RecordType.Name======='+objPay.RecordType.name);
                system.debug('objPay.Status======='+objPay.Status__c);
                //system.debug('objPay.RecordType.DeveloperName======='+objPay.RecordType.DeveloperName);
                if(objPay.RecordTypeId != fetchRecordTypeId('Buy_Back_Read_Only') 
                   && objPay.RecordTypeId != fetchRecordTypeId('Credit_Read_Only')
                   && objPay.RecordTypeId != fetchRecordTypeId('RUL_Payment_Read_Only')
                   && objPay.RecordTypeId != fetchRecordTypeId('Refund_Read_Only') ){
                       objPay.RUL_Old_RecordType_Id__c = objPay.RecordTypeID;
                }
                if(!objPay.Status__c.containsIgnoreCase('Variation')){
                    system.debug('inside copy old status');
                    objPay.Old_Status__c = objPay.Status__c;
                }
            }
        }  
    }
    public static String fetchRecordTypeId (String recordTypeName) {
         system.debug('Inside PaymentTriggerhandler fetchRecordTypeId() method');
        String recordTypeId =  Schema.SObjectType.Payment__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();        
        return recordTypeId;
    }
    
    public static void createLog(Exception e,String methodName){
        System.debug(e.getMessage() + 'Method Name : '+methodName);
                            cwbtool__ErrorLog__c errlog=new cwbtool__ErrorLog__c();
                            errlog.cwbtool__LineNumber__c=e.getLineNumber();
                            errlog.cwbtool__ErrorType__c=e.getTypeName();
                            errlog.cwbtool__StackTrace__c=e.getStackTraceString();
                            errlog.cwbtool__Message__c=e.getMessage()+'Method Name : '+methodName;
                            insert errlog;
    }
}