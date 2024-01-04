/*
    History
	Feb 2017 JT - Davanti. Updated isValidInitiative(List<Initiative__c>)
							The method only validated the total amount of the payments associated to the added initiatives. Updated to validate the total amount of all payments of the investment area allocation.
*/
public with sharing class AssociateInitiatives {

    // Internal Variables
    private static Integer PAGE_SIZE;   // Page size 
    private ApexPages.StandardSetController setController; // StandardSetController 
    private Map<Id, DisplayedRow> mapdisplayedRows = new Map<Id, DisplayedRow>();   // Maintains modified rows state
    private Set<Id> setExistingInitiativeIds = new Set<Id>();   
    private List<Initiative__c> existingInitiatives = new List<Initiative__c>();
    // Page Variables
    public Business_Case__c businessCase {get;set;}
    public Boolean bHasResults {get {return (bHasResults != null)? bHasResults:false;} set;}
    public List<DisplayedRow> displayedRows {get; set;} // SEARCH Rows displayed [max of (page size) at a time]
    public List<System.selectOption> filterOptions {get;set;}
    public String strFilter {get;set;}
    public List<InvestmentAreaWrapper> investmentAreaList {get;set;}
    
    // Updated on 25/06/2015
    
    public Double doubTotalRequested {get {return (doubTotalRequested != null)? doubTotalRequested:0.00;} set;}
    public Double doubTotalPlanned {get {return (doubTotalPlanned != null)? doubTotalPlanned:0.00;} set;}
    public Double doubTotalPayments {get {return (doubTotalPayments != null)? doubTotalPayments:0.00;} set;}
    
    public String sortDir { // Current sort direction. defaults to asc
        // Set a Direction either in ascending order or descending order.
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;} set;
    }
    public String sortField { // Current field to sort by. defaults to name
        // To set a Field for sorting.
        get  { if (sortField == null) {sortField = 'Name'; } return sortField;  } set;
    }   
    public Integer currentPageNumber {get{return (currentPageNumber == null)? 1:currentPageNumber;} set;}
    static { // SET PAGE SIZE 
        PAGE_SIZE = 200; // Default page size
        if(ApexPages.currentPage().getParameters().get('pagesize') != null) {
            PAGE_SIZE = Integer.valueOf(ApexPages.currentPage().getParameters().get('pagesize'));
        }   
    }
    // Error class
    public class cException extends Exception {}
    public Boolean bThrowException {get {return (bThrowException != null)? bThrowException:false;} set;}        
    // Wrapper Class
    public class DisplayedRow {
        public Boolean bSelected {get;set;}
        public Initiative__c initiative {get;set;}
        public DisplayedRow() {
            bSelected = false;
            initiative = new Initiative__c();       
        }       
    }       
    // Constructor           
    public AssociateInitiatives(ApexPages.standardController con) {
        businessCase = [select Id, Name, Investment_Area__c, Organisation__c, Status__c,
                            (select Id,
                             Description__c,
                             Name,Business_Case__c,Investment_Area__r.Status__c,Investment_Area__r.Strategic_Area__r.Status__c,Cost_Centre__c,Expense_Code__c, Total_Paid_Payments__c
                                from Initiatives__r 
                                    where Investment_Area__r.Strategic_Area__r.Status__c!='Draft') 
                        from Business_Case__c where Id = :con.getId()];
                        
        if(businessCase<>NULL){                
            if(businessCase.Initiatives__r != null && businessCase.Initiatives__r.size()>0)                 
                existingInitiatives = businessCase.Initiatives__r;
            if(existingInitiatives.size()>0) {
                for(Initiative__c i:existingInitiatives) {
                    setExistingInitiativeIds.add(i.Id);
                }
            }
        }
        filterOptions = new List<System.selectOption>();
        Schema.DescribeFieldResult fieldResult = Initiative__c.Priority__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        filterOptions.add(new SelectOption('', 'All'));
        for(Schema.PicklistEntry f:ple) {
            filterOptions.add(new SelectOption(f.getValue(), f.getLabel()));
        }
        // populate standard set controller
        populateInitiativesList();
    }
    // Page Methods  
    
    private void populateInitiativesList() {
        system.debug('## businessCase.Organisation__c =>' + businessCase.Organisation__c);
        String sortField1 = sortField;
                
        List<Initiative__c> searchResults;                             
        System.debug('DJMH: ' + businessCase.Organisation__c);
        // Organisation and Investment Area
        if(businessCase.Organisation__c != null && businessCase.Investment_Area__c != null){
            if (!string.isBlank(strFilter)){
                searchResults = [select Id, Name, Status__c, Start_Date__c, End_Date__c, Requested__c, Plan__c, Business_Case__c, SUM_Payments__c,
                                        Partner__c, Priority__c,
                                 Description__c, 
                                 Type__c, Planned__c,Investment_Area__r.Status__c,Investment_Area__r.Strategic_Area__r.Status__c
                                 from Initiative__c
                                 Where ((Investment_Area__c =: businessCase.Investment_Area__c and Partner__c =: businessCase.Organisation__c and Business_Case__c = null)
                                         OR Business_Case__c =: businessCase.Id)
                                         AND Investment_Area__r.Strategic_Area__r.Status__c!='Draft'
                                         AND Priority__c =: strFilter
                                        // order BY :sortField
                                ];
            } else {
                searchResults = [select Id, Name, Status__c, Start_Date__c, End_Date__c, Requested__c, Plan__c, Business_Case__c, SUM_Payments__c,
                                        Partner__c,Priority__c,
                                 Description__c, 
                                 Type__c, Planned__c,Investment_Area__r.Status__c
                                 from Initiative__c
                                 Where ((Investment_Area__c =: businessCase.Investment_Area__c and Partner__c =: businessCase.Organisation__c and Business_Case__c = null)
                                         OR Business_Case__c =: businessCase.Id)
                                         AND Investment_Area__r.Strategic_Area__r.Status__c!='Draft'
                                         //order by :sortField1 :sortDir
                                ];
            }                
           
        }// Investment Area Only
        else if(businessCase.Investment_Area__c != null){
            if(!string.isBlank(strFilter)){
                searchResults = [select Id, Name, Status__c, Start_Date__c, End_Date__c, Requested__c, Plan__c, Business_Case__c, SUM_Payments__c,
                                        Partner__c,Priority__c,
                                 Description__c,
                                 Type__c, Planned__c,Investment_Area__r.Status__c
                                 from Initiative__c
                                 Where ((Investment_Area__c =: businessCase.Investment_Area__c and Business_Case__c = null)
                                        OR Business_Case__c =: businessCase.Id)
                                        AND Investment_Area__r.Strategic_Area__r.Status__c!='Draft'
                                        AND Priority__c =: strFilter
                                        //order by sortField
                                ];
            } else {
                searchResults = [select Id, Name, Status__c, Start_Date__c, End_Date__c, Requested__c, Plan__c, Business_Case__c, SUM_Payments__c,
                                        Partner__c,Priority__c,
                                 Description__c, 
                                 Type__c, Planned__c,Investment_Area__r.Status__c
                                 from Initiative__c
                                 Where ((Investment_Area__c =: businessCase.Investment_Area__c and Business_Case__c = null)
                                        OR Business_Case__c =: businessCase.Id)
                                        AND Investment_Area__r.Strategic_Area__r.Status__c!='Draft'
                                        //order by sortField
                                 
                                ];
            }               
             
        }// Organisation Only
        else if(businessCase.Organisation__c != null){
            if (!string.isBlank(strFilter)){
                searchResults = [select Id, Name, Status__c, Start_Date__c, End_Date__c, Requested__c, Plan__c, Business_Case__c, SUM_Payments__c,
                                        Partner__c,Priority__c,
                                 Description__c, 
                                 Type__c, Planned__c,Investment_Area__r.Status__c
                                 from Initiative__c
                                 Where ((Partner__c =: businessCase.Organisation__c and Business_Case__c = null)
                                        OR Business_Case__c =: businessCase.Id)
                                        AND Investment_Area__r.Strategic_Area__r.Status__c!='Draft'
                                        AND Priority__c =: strFilter
                                        //order by sortField  
                                ];
            } else {
                searchResults = [select Id, Name, Status__c, Start_Date__c, End_Date__c, Requested__c, Plan__c, Business_Case__c, SUM_Payments__c,
                                        Partner__c,Priority__c,
                                 Description__c, 
                                 Type__c, Planned__c,Investment_Area__r.Status__c
                                 from Initiative__c
                                 Where ((Partner__c =: businessCase.Organisation__c and Business_Case__c = null)
                                        OR Business_Case__c =: businessCase.Id)
                                        AND Investment_Area__r.Strategic_Area__r.Status__c!='Draft'
                                        //order by sortField  
                                ];
            }                
        }                            
      
        //system.debug('### Search Results Size: ' + searchResults.size());
        bHasResults = false;
        if(searchResults != null && searchResults.size()>0) {   
            bHasResults = true;                          
            setController = new ApexPages.StandardSetController(searchResults);                             
            setController.setPageSize(PAGE_SIZE);
            populateDisplayedRows();
            //computeTotals();                  
        }
        else {
            computeInvestmentAreaInitiative();
            addPageMessage(ApexPages.severity.INFO, 'No Initiatives found');
        }       
    }
    
    
    // Populates Displayed Rows
    private void populateDisplayedRows() {
        displayedRows = new List<displayedRow>();
        for(Initiative__c initiative:(List<Initiative__c>)setController.getRecords()) {
            DisplayedRow row = new DisplayedRow();
            if(setExistingInitiativeIds.size()>0 && setExistingInitiativeIds.contains(initiative.Id)) 
                row.bSelected = true; // mark as checked if already linked to Business Case
                row.initiative = initiative;    
            if(mapdisplayedRows.size()>0 && mapdisplayedRows.containsKey(initiative.Id)) {
                row = mapdisplayedRows.get(initiative.Id);
            }           
            displayedRows.add(row);
            system.debug('dispalyRTOws>>>>>>>'+displayedRows);
        }   
        
        //Added on 6th July 2015
        computeInvestmentAreaInitiative();        
    }   
    
    // Compute Investment Area Allocation - added 15/06/2015
    public Decimal totalAllocatedFund {get;set;}
    public Decimal totalFundConsumed {get;set;}
    public Decimal totalAvailableFundAfterConsume {get;set;}
    
    public void computeInvestmentAreaInitiative() {
        system.debug('Inside computeInvestmentAreaInitiative >>>>>>>>>>>>>>>>mapdisplayedRows#########  '+mapdisplayedRows);
        Set<Id> initiativeIdSet = new Set<Id>();
        //Map<String, InvestmentAreaWrapper> investmentAreaMap = new Map<String, InvestmentAreaWrapper>();
        // updated on 24th june 2015
        Map<Id, InvestmentAreaWrapper> investmentAreaMap = new Map<Id, InvestmentAreaWrapper>();
        investmentAreaList = new List<InvestmentAreaWrapper>();         
        maintainPageState();
        if(mapdisplayedRows.size()>0) {
            for(Id idInitiative:mapdisplayedRows.keySet()) {
                if(mapdisplayedRows.get(idInitiative).bSelected){
                    initiativeIdSet.add(idInitiative);
                }   
            }
        }
        system.debug('strFilter >>>>>>>>>>>>>>>>> ############ '+strFilter);
        List<AggregateResult> aggregateResults;
        
        if(strFilter==NULL || strFilter.contains('All')){
            aggregateResults = [Select SUM(Requested__c) REQUESTED, SUM(Planned__c) PLANNED, SUM(SUM_Payments__c) PAYMENTS
                                FROM Initiative__c WHERE Id IN :initiativeIdSet];
        } else {
            aggregateResults = [Select SUM(Requested__c) REQUESTED, SUM(Planned__c) PLANNED, SUM(SUM_Payments__c) PAYMENTS 
                                FROM Initiative__c WHERE Id IN :initiativeIdSet
                                AND Priority__c =: strFilter];
        }                                         
        doubTotalRequested = 0.00;
        doubTotalPlanned = 0.00;
        doubTotalPayments = 0.00;// Added by JTan 15/06/2017
        if (aggregateResults<>NULL){
            for(AggregateResult ar : aggregateResults) {
                if(ar.get('REQUESTED') != null) doubTotalRequested = (Double)ar.get('REQUESTED');
                if(ar.get('PLANNED') != null) doubTotalPlanned = (Double)ar.get('PLANNED');
                if(ar.get('PAYMENTS') != null) doubTotalPayments = (Double)ar.get('PAYMENTS');// Added by JTan 15/06/2017
            }
        }
        system.debug('initiativeIdSet>>>>>>>>>>>>>> '+initiativeIdSet);
        List<Payment__c> paymentList = new List<Payment__c>();
        
        if(!initiativeIdSet.isEmpty()) {
            // updated on 24th june 2015
            List<Payment__c> tempList;
            if (strFilter==NULL || strFilter.contains('All')){
                tempList = new List<Payment__c>([Select Id, Investment_Area_Allocation__r.Investment_Area__r.Name,Initiative__r.Investment_Area__c,Initiative__r.Priority__c,
                                                     Initiative__c,Initiative__r.Name,Investment_Area_Allocation__r.Financial_Year__c, Investment_Area_Allocation__r.Amount__c,Amount__c
                                                From Payment__c 
                                                where Investment_Area_Allocation__c != null 
                                                and Initiative__c in : initiativeIdSet
                                             ]);
            } else {
                
                tempList = new List<Payment__c>([Select Id, Investment_Area_Allocation__r.Investment_Area__r.Name,Initiative__r.Investment_Area__c,Initiative__r.Priority__c,
                                                     Initiative__c,Initiative__r.Name,Investment_Area_Allocation__r.Financial_Year__c, Investment_Area_Allocation__r.Amount__c,Amount__c
                                                From Payment__c 
                                                where Investment_Area_Allocation__c != null 
                                                and Initiative__c in : initiativeIdSet
                                                AND Initiative__r.Priority__c =: strFilter
                                             ]);
            }                                                
                                                             
            system.debug('tempList >>>>>>>>>>>>>>> '+tempList);
            if (tempList<>NULL && !tempList.isEmpty()){
                for (Payment__c pay : tempList){
                    if (pay.Initiative__r.Investment_Area__c == pay.Investment_Area_Allocation__r.Investment_Area__c){
                        paymentList.add(pay); 
                    }
                }
            }                                                   
                                                                
            //addPageMessage('## paymentList =>' + paymentList.size());
            //addPageMessage('## paymentList =>' + paymentList);
            system.debug('paymentList >>>>>>>>>>>>>>> '+paymentList);
            if(paymentList.size() > 0) {
                for(Payment__c p : paymentList) {
                    // Updated on 24 june 2015
                    if(investmentAreaMap.containsKey(p.Initiative__c)) {
                        //todo fix - which initiative is added?
                        //investmentAreaMap.get(p.Investment_Area_Allocation__r.Investment_Area__r.Name).amountDec += p.Amount__c;
                        // Updated on 24th june 2015
                        investmentAreaMap.get(p.Initiative__c).amountDec += p.Investment_Area_Allocation__r.Amount__c;
                        investmentAreaMap.get(p.Initiative__c).consumedDec += p.Amount__c;
                        investmentAreaMap.get(p.Initiative__c).availableDec = investmentAreaMap.get(p.Initiative__c).amountDec - investmentAreaMap.get(p.Initiative__c).consumedDec;
                        
                    } else {
                        
                        InvestmentAreaWrapper tempInvestAreaWrap = new InvestmentAreaWrapper();
                        // Added on 25th June 2015
                        tempInvestAreaWrap.initiativeName = p.Initiative__r.Name;
                        tempInvestAreaWrap.investmentAreaStr = p.Investment_Area_Allocation__r.Investment_Area__r.Name;
                        tempInvestAreaWrap.financialYearStr = p.Investment_Area_Allocation__r.Financial_Year__c;
                        tempInvestAreaWrap.amountDec = p.Investment_Area_Allocation__r.Amount__c;
                        tempInvestAreaWrap.consumedDec = p.Amount__c;
                        
                        tempInvestAreaWrap.availableDec = tempInvestAreaWrap.amountDec - tempInvestAreaWrap.consumedDec;
                        
                        investmentAreaMap.put(p.Initiative__c, tempInvestAreaWrap);
                    }
                    
                }
                investmentAreaList = investmentAreaMap.values();
            }
        }   
    }

    public class InvestmentAreaWrapper {
        public String investmentAreaStr {get;set;}
        public String financialYearStr {get;set;}
        public Decimal amountDec {get;set;}
        public Decimal consumedDec {get;set;}
        public Decimal availableDec {get;set;}
        // added on 25th june 2015
        public String initiativeName {get;set;}
    }

    // Wrapper to handle overdue initiative 
    public class OverDuePaymentHandler {
        boolean isTrue = false;
        Initiative__c initiative = new Initiative__c(); 
        public OverDuePaymentHandler(boolean isTrue,Initiative__c initiative){
            this.isTrue = isTrue;
            this.initiative = initiative;
        }
    }

    public List<Initiative__c> iniLst;
    
    //Feb 2017 JT - Updated to validate the total amount of all payments of the investment area allocation
 public OverDuePaymentHandler isValidInitiative(List < Initiative__c > initiativeList) {
    Set<Id> investmentAreaAllocIds = new Set<Id>();
     OverDuePaymentHandler overDuePayment;
    Map<Id, Set<Id>> initiativeAllocationMap = new Map<Id, Set<Id>>();
    for (Payment__c paymentRecord : [SELECT Amount__c, Date__c, Investment_Area_Allocation__c, Status__c, Initiative__c
        FROM Payment__c
        WHERE Initiative__c IN :initiativeList
        AND Status__c != 'Cancelled'
    ]) {
        if (paymentRecord.Investment_Area_Allocation__c != null) {
            investmentAreaAllocIds.add(paymentRecord.Investment_Area_Allocation__c);
        }
        if (initiativeAllocationMap.containsKey(paymentRecord.Initiative__c)) {
            Set<Id> tempSetId = initiativeAllocationMap.get(paymentRecord.Initiative__c);
            tempSetId.add(paymentRecord.Investment_Area_Allocation__c);
            initiativeAllocationMap.put(paymentRecord.Initiative__c, tempSetId);
        } else {
            initiativeAllocationMap.put(paymentRecord.Initiative__c, new Set<Id>{paymentRecord.Investment_Area_Allocation__c});
        }
    }

    AggregateResult[] groupedResults = [SELECT SUM(Amount__c) TotalPaymentAmount, Investment_Area_Allocation__c
                                         FROM Payment__c
                                    WHERE
                                        (
                                            (
                                                Investment_Area_Allocation__c IN :investmentAreaAllocIds AND
                                                Initiative__r.Business_Case__c != NULL AND
                                                Initiative__c NOT IN :(List<Initiative__c>) setController.getRecords()
                                            ) OR
                                            Initiative__c IN: initiativeList
                                        ) AND
                                        Status__c != 'Cancelled' 
                                        AND Allocation_Date_Criteria__c=true                    
                                      GROUP BY
                                        Investment_Area_Allocation__c];
     
    Map<Id, Decimal> allocationTotalAmountMap = new Map<Id, Decimal>();
     
    for(AggregateResult agg : groupedResults){
        allocationTotalAmountMap.put((Id)agg.get('Investment_Area_Allocation__c'), (Decimal)agg.get('TotalPaymentAmount'));
      }

     Map <Id,Investment_Area_Allocation__c> invAreaAllocation = new Map <Id,Investment_Area_Allocation__c>([SELECT Id,Investment_Area__c,Amount__c,Funding_Allocation_End_Date__c,Funding_Allocation_Start_Date__c
                                                                            FROM Investment_Area_Allocation__c WHERE Id IN : allocationTotalAmountMap.keySet()]);
	System.debug('initiativeAllocationMap : '+initiativeAllocationMap.keyset());
    for (Initiative__c initiativeRecord : initiativeList) {
				system.debug('initiativeRecord.id'+initiativeRecord.id);
        if (initiativeAllocationMap.containsKey(initiativeRecord.id)){
            for (Id allocationId:initiativeAllocationMap.get(initiativeRecord.Id)) {
                if (allocationTotalAmountMap.get(allocationId) > invAreaAllocation.get(allocationId).Amount__c) {
                    system.debug('total payment is greater than Available payment of investment area >>>>>>');
                    overDuePayment = new OverDuePaymentHandler(true, initiativeRecord);
                    return overDuePayment;
                }
            }
       }
     }
    

    overDuePayment = new OverDuePaymentHandler(false, null);
    return overDuePayment;
}
    
    // Process Records - SAVE
    public PageReference processRecords() {
        maintainPageState();
        PageReference pref = null;
        List<Initiative__c> listInitiatives = new List<Initiative__c>();
        List<Initiative__c> listOfOverdueInitiatives = new List<Initiative__c>();
        OverDuePaymentHandler OverDuePayment; 
        List<Id> lstOfInvIds = new List<Id>();
        //validate allocation is within budget
        
        // Added by JTan 15/06/2017 begins
        if (businessCase.Status__c == 'Approved' || businessCase.Status__c == 'Signed'){
            addPageMessage(Apexpages.severity.Error, 'Initiatives cannot be added to or removed from Investment Schedules that have been Approved or Signed.');
            return null;
        }
        // Added by JTan 15/06/2017 ends
        system.debug('Save Method displayedRows>>>>>'+displayedRows);
        if (displayedRows<>NULL && !displayedRows.isEmpty()){
            for (DisplayedRow dRow : displayedRows){
                if (dRow.bSelected){
                    //listOfOverdueInitiatives.add(dRow.initiative);
                    lstOfInvIds.add(dRow.initiative.Id);
                } 
            }
            system.debug('lstOfInvIds>>>>>'+lstOfInvIds);
            listOfOverdueInitiatives= [select Id,Name,Business_Case__c,Investment_Area__r.Status__c,Investment_Area__r.Strategic_Area__r.Status__c,
                                              Cost_Centre__c,
                                       Description__c,
                                       Expense_Code__c,Type__c, Total_Paid_Payments__c
                                        from Initiative__c WHERE Id IN :lstOfInvIds];
        }
        system.debug('ListInitiaitive>>>>>>>>>>'+listOfOverdueInitiatives);
        
               
        if (listOfOverdueInitiatives<>NULL && !listOfOverdueInitiatives.isEmpty()){
            /*for(Initiative__c objInt :listOfOverdueInitiatives){
                system.debug('objInt>>>>>>>>>>>>'+objInt);
                for(Payment__c objPay :objInt.Payments__r ){
                    if(objPay.status__c == 'Paid'){
                        system.debug('objPay>>>>>>>'+objPay);
                        addPageMessage(Apexpages.severity.Error, 'The selected Initiative '+objInt.Name +' cannot be removed');
                    }
                }
            }*/
            OverDuePayment = isValidInitiative(listOfOverdueInitiatives);
            system.debug('OverDuePayment >>>>>>>>>>>>>>> '+OverDuePayment);
            if (OverDuePayment.isTrue){
                addPageMessage(Apexpages.severity.Error, 'The selected Initiative '+OverDuePayment.initiative.Name +' cannot be included in the Investment Schedule. This would exceed the funding available in the Investment Area by financial year.');
                
                return null;
            } else {
                for (Initiative__c iniObj : listOfOverdueInitiatives){
                    if (iniObj.Type__c<>'Time & Advice'){
                        if (iniObj.Cost_Centre__c==NULL) {
                            addPageMessage(Apexpages.severity.Error, 'The selected Initiative '+iniObj.Name +' cannot be included in the Investment Schedule as this initiative doesnt have cost center.');
                            return null;
                        }
                        if (iniObj.Expense_Code__c==NULL){
                            addPageMessage(Apexpages.severity.Error, 'The selected Initiative '+iniObj.Name +' cannot be included in the Investment Schedule as this initiative doesnt have expense code.');
                            return null;
                        }
                    }
                }
            }
            // else do nothing
        }
        String initiativeWithPaidPayments = '';
        
        if(existingInitiatives.size()>0) {
            for(Initiative__c initiative:existingInitiatives) {
                if(mapdisplayedRows.size()>0 && (!mapdisplayedRows.containsKey(initiative.Id) || 
                    (mapdisplayedRows.containsKey(initiative.Id) && 
                        mapdisplayedRows.get(initiative.Id).bSelected == false ))) {
                    initiative.Business_Case__c = null;
                    listInitiatives.add(initiative);
                    //If paid payment exist add initiative to a list of strings
                    if(initiative.Total_Paid_Payments__c > 0){
                        initiativeWithPaidPayments += initiative.Name;
                        initiativeWithPaidPayments += ', ';
                    }
                }
                if(mapdisplayedRows.size() == 0) {
                    // unlink all initiatives
                    initiative.Business_Case__c = null;
                    listInitiatives.add(initiative);    
                }
            }
        }
        //Add error to the page if their are paid payments for initiatives getting removed
        if(String.isNotBlank(initiativeWithPaidPayments)){
        	initiativeWithPaidPayments = initiativeWithPaidPayments.removeEnd(', ');
        	addPageMessage(Apexpages.severity.Error, 'The selected Initiatives '+initiativeWithPaidPayments +' cannot be removed from the Investment Schedule as their payment is paid.');
            return null;
        }

        if(mapdisplayedRows.size()>0) {
            for(Id idInitiative:mapdisplayedRows.keySet()) {
                if(mapdisplayedRows.get(idInitiative).bSelected) {
                    Initiative__c initiative = new Initiative__c(Id = idInitiative, Business_Case__c = businessCase.Id);
                    listInitiatives.add(initiative);
                }
            }
        }
        if(listInitiatives.size()>0) {
            try {
                Database.update(listInitiatives);
                pref = new PageReference('/' + businessCase.Id);
                if(bThrowException && Test.isRunningTest()) throw new cException('TEST ERROR');
            }
            catch(Exception ex) {
                addPageMessage(ApexPages.severity.FATAL, ex);
            }
        }   
        return pref;
    }
    // Method to maintain Page state between pages
    private void maintainPageState() {   
        // Maintain state between pages by iterating through displayed rows 
        // and updating private collection variable (mapdisplayedRows)
        if(displayedRows != null) {
            for(displayedRow displayRow:displayedRows) {
                Id idKey = displayRow.initiative.Id;    
                if(mapdisplayedRows.containsKey(idKey)) { 
                    mapdisplayedRows.remove(idKey); 
                }   
                //if(displayRow.bSelected) {                
                mapdisplayedRows.put(idKey, displayRow);    
                //} 
            }
        }
        system.debug('### mapdisplayedRows: ' + mapdisplayedRows);      
    }   
    // FALSE if current page is the LAST page. Otherwise, value will be TRUE
    public Boolean hasNext {
        get {
            return (setController != null)? setController.getHasNext():false;
        }
    }
    // FALSE if current page is the FIRST page. Otherwise, value will be TRUE
    public Boolean hasPrevious {
        get {
            return (setController != null)? setController.getHasPrevious():false;
        }
    } 
    // Display current  page number
    public Integer pageNumber {
        get {
            return (setController != null)? setController.getPageNumber():0;
        }
    }
    // Display total number of  pages
    public Integer totalPages {
        get {
            return (setController != null)? Integer.valueOf(Math.floor(setController.getResultSize() / setController.getPageSize()) + 
                    ((Math.mod(setController.getResultSize(), PAGE_SIZE)>0) ? 1 : 0)) + ((setController.getResultSize() == 0)? 1:0):0;
        }
    }    
    // "First Page" Page button action
    public void first() {  
        maintainPageState();
        setController.first();
        populateDisplayedRows();                
    }
    // "Last Page" Page button action
    public void last() {
        maintainPageState(); 
        setController.last();
        populateDisplayedRows();                  
    }
    // "Previous" Page button action    
    public void previous() {
        maintainPageState();
        setController.previous();
        populateDisplayedRows();               
    }  
    // "Next" Page button action
    public void next() {
        maintainPageState();
        setController.next();
        populateDisplayedRows();            
    }
    // Toggles the sorting of query from asc <--> desc
    public void toggleSort() {
        // toggle the direction
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        populateInitiativesList();
    }  
    // Filter Records
    public void filterRecords() {
         populateInitiativesList();
    }               
    // Add Page Messages
    public void addPageMessage(ApexPages.severity severity, Object objMessage) {
        ApexPages.Message pMessage = new ApexPages.Message(severity, String.valueOf(objMessage));
        ApexPages.addMessage(pMessage);
    }
    public void addPageMessage(Object objMessage) {
        addPageMessage(ApexPages.severity.INFO, objMessage);
    }       
}