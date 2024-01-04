/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used for the functionality of Cloned_Initiative_Requirements_Measures Page

=========================================================================================================================
Version | Date(DD-MM-YYYY) | Last Modified By | Comments
-------------------------------------------------------------------------------------------------------------------------
1.0     | 25-02-2019       | Sunil Rathore   | 1. Created class to implement functionality of New_Initiative Requirements Measures Page
==========================================================================================================================
*/

public class RequirementReportingController {
    
    //Variable declarations
    public  Requirement_Reporting_Detail__c objReport{get;set;}
    public  Initiative_Development_Template__c objIdt{get;set;}
    public string selfass{get;set;}
    public String testboolean {get;set;}
    public Requirement__c objReq{get;set;}
    public String currentRecordId{get;set;}
    public String requirementRecordId{get;set;}
    public List<Requirement__c>listReq{get;set;}
    public List<Requirement__c>newListReq{get;set;}
    public Boolean editReport{get;set;}
    public Boolean readOnlyReport{get;set;}
    public Boolean regCSRubricReport{get;set;}
    public Boolean natCSRubricReport{get;set;}
    public Boolean enableAttachment{get;set;}
    public Boolean caseStudy{get;set;}
    public Boolean caseStudy2{get;set;}
    public Boolean caseStudyField{get;set;}
    public Boolean disableAttachment{get;set;}
    public Boolean auckland{get;set;}
    public List<Requirement_Reporting_Detail__c> lstRep{get;set;}
    public string initiativeOwner{get;set;}
    
    
    public Boolean activityMeasure{get;set;}
    
    public String activityRRD{get;set;}
    public String measureRRD{get;set;}
    public Boolean year1{get;set;}
    public Boolean year2{get;set;}
    public Boolean year3{get;set;}
    public Boolean year4{get;set;}
    public Boolean selfassesmentField{get;set;}
    public Boolean requirementStatusSubmit{get;set;}
    public Boolean requirementStatusSave{get;set;}
    public Boolean isSubmitted{get;set;}
    
    
    
    //Constants declaration
    public static final String REQUIREMENTSTATUS1 = 'Pending';
    public static final String REQUIREMENTSTATUS2 = 'Completed';
    
    public static final String REPORTINGSTATUS1 = 'Being Reviewed';
    public static final String REPORTINGSTATUS2 = 'Completed';
    public static final String REPORTINGSTATUS3 = 'Overdue';
    public static final String REPORTINGSTATUS4 = 'Submitted';
    
    public static final String REPORTINGSTATUS5 = 'Draft';
    public static final String REPORTINGSTATUS6 = 'Need More Information';
    
    public static final String REPORTINGSTATUS7 = 'SME review underway';
    public static final String REPORTINGSTATUS8 = 'SME review complete';
    public static final String REPORTINGSTATUS9 = 'Review being finalised';
    public static final String REPORTINGSTATUS10 = 'Pending';
    
    public static final String REPORTINGRECORDTYPE1 = 'Nat CS Rubric 1';
    public static final String REPORTINGRECORDTYPE2 = 'Reg CS Rubric 2';
    public static final String REPORTINGRECORDTYPE3 = 'CS Case Study';
    public static final String REPORTINGRECORDTYPE4 = 'CS Board Diversity';
    //SSE-31 New requirement
    public static final String REPORTINGRECORDTYPE5 = 'PI National';
    public static final String REPORTINGRECORDTYPE6 = 'PI Regional';
    
    //SSE-129 New requirement
    public static final String REPORTINGRECORDTYPE7 = 'PI National + 1';
    public static final String REPORTINGRECORDTYPE8 = 'PI National + 2';
    public static final String REPORTINGRECORDTYPE9 = 'PI National + 3';
    public static final String REPORTINGRECORDTYPE10 = 'PI National + 4';
    
    public static final String REPORTINGRECORDTYPE11 = 'PI Regional + 1';
    public static final String REPORTINGRECORDTYPE12 = 'PI Regional + 2';
    public static final String REPORTINGRECORDTYPE13 = 'PI Regional + 3';
    public static final String REPORTINGRECORDTYPE14 = 'PI Regional + 4';
    
    public static final String REPORTINGRECORDTYPE15 = 'PI National 1';
    public static final String REPORTINGRECORDTYPE16 = 'PI National 2';
    public static final String REPORTINGRECORDTYPE17 = 'PI National 3';
    public static final String REPORTINGRECORDTYPE18 = 'PI National 4';
    
    
    
    public Boolean CSBoardDiversity{get;set;}
    public Boolean CSBoardDiversityReadOnly{get;set;}
    public Boolean ReadonlyMode{get;set;}
    public Decimal BD_total_board_members{get;set;}
    //Constructor 
    public RequirementReportingController(ApexPages.StandardController controller) {
        objReport = new Requirement_Reporting_Detail__c();
        objReq = new Requirement__c();
        newListReq = new List<Requirement__c>();
        listReq = new List<Requirement__c>();
        lstRep = new List<Requirement_Reporting_Detail__c>();
        enableAttachment = false;
        caseStudy = false;
        caseStudy2 = false;// sse-169
        testboolean = '';
        caseStudyField = false;
        disableAttachment = false;
        auckland = false;
        editReport = false;
        readOnlyReport = false;
        regCSRubricReport = false;
        natCSRubricReport = false;
        CSBoardDiversity=false;
        CSBoardDiversityReadOnly=false;
        Boolean otherRecordType = true;
        activityMeasure=false;
        year1=false;
        year2=false;
        year3=false;
        year4=false;
        selfassesmentField=false;
        isSubmitted=false;
        // requirementStatusSubmit=false;
        
        
        
        
        
        //fetching current initiative ID
        currentRecordId = ApexPages.CurrentPage().getparameters().get('id');
        System.debug('***currentRecordId : '+currentRecordId);
        requirementRecordId = ApexPages.CurrentPage().getparameters().get('reqid');
        System.debug('***requirementRecordId : '+requirementRecordId);
        lstRep = checkExisitngReportRecord(currentRecordId);
        //Assigning exisitng value to the Requirement Report record to display on page
        //if(lstRep.size()>0){
        //
        //
		System.debug('lstRep 2***'+lstRep);        
        if(lstRep!=null && !lstRep.isEmpty()){
            
            for(Requirement_Reporting_Detail__c objRep : lstRep ) {
                
                System.debug('objRep.RecordType###'+objRep.RecordTypeId);
                Requirement_Reporting_Detail__c req = [SELECT Requirement__r.Status__c
                                                       FROM Requirement_Reporting_Detail__c 
                                                       WHERE Id = :lstRep[0].Id];
                
                //SSE-31
                System.debug('objRep.RecordTypeId : ***** '+ objRep.RecordTypeId);
                if(//objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI Regional').getRecordTypeId()){
                       /* */
                       
                       if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                           editReport = false;
                           caseStudy=true;
                           caseStudy2=false;//SSE-169
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                           otherRecordType = false;
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                           
                           editReport = true;
                           caseStudy2=false;
                           caseStudy = true;
                            ReadonlyMode = false;
                            readOnlyReport = false;
                            enableAttachment = true;
                            disableAttachment = false;
                            otherRecordType = false;
                       }
                   }
                
                //pi n
               
               		
                	if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National').getRecordTypeId()){
                       /* */
                       
                       if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                           editReport = false;
                           caseStudy=false;
                           caseStudy2=true;//SSE-169
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                           otherRecordType = false;
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                           
                           editReport = true;
                           caseStudy2=true;
                           caseStudy = false;
                            ReadonlyMode = false;
                            readOnlyReport = false;
                            enableAttachment = true;
                            disableAttachment = false;
                            otherRecordType = false;
                       }
                   }
                
               
                //pi n
                
                //SSE - 129
                system.debug('objRep.status__c'+objRep.status__c);
                if(//objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 1').getRecordTypeId() ||
                  // objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 2').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 3').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 4').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI Regional + 1').getRecordTypeId() ||
                  // objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI Regional + 2').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI Regional + 3').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI Regional + 4').getRecordTypeId()
                  ){
                      if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                          
                          editReport = false;
                          caseStudy2 = false;
                          caseStudy=true;//SSE-169
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            activityMeasure=true;
                      		selfassesmentField=true;
                          otherRecordType = false;
                          
                          /*editReport = false;
                          caseStudy2 = false;
                          caseStudy=true;//SSE-169
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            activityMeasure=true;
                      		selfassesmentField=true;
                          otherRecordType = false;*/
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                      editReport = true;
                      caseStudy2 = false;
                      caseStudy = true;
                      ReadonlyMode = false;
                      readOnlyReport = false;
                      enableAttachment = true;
                      disableAttachment = false;
                      otherRecordType = false;
                      activityMeasure=true;
                      selfassesmentField=true;
                       }
                  }
                //n+1
                
                if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 1').getRecordTypeId())
                {
                    {
                      if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                           editReport = false;
                          caseStudy2 = true;
                          caseStudy = false;
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            activityMeasure=true;
                      		selfassesmentField=true;
                          otherRecordType = false;
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                      editReport = true;
                      caseStudy2 = true;
                      caseStudy = false;
                      ReadonlyMode = false;
                      readOnlyReport = false;
                      enableAttachment = true;
                      disableAttachment = false;
                      otherRecordType = false;
                      activityMeasure=true;
                      selfassesmentField=true;
                       }
                  }
                }
                
                //n+1
                
               if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 2').getRecordTypeId()||
                  objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI Regional + 2').getRecordTypeId())
                {
                    {
                      if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                           editReport = false;
                          caseStudy2 = true;
                          caseStudy = false;
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            activityMeasure=true;
                      		selfassesmentField=true;
                          otherRecordType = false;
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                      editReport = true;
                      caseStudy2 = true;
                      caseStudy = false;
                      ReadonlyMode = false;
                      readOnlyReport = false;
                      enableAttachment = true;
                      disableAttachment = false;
                      otherRecordType = false;
                      activityMeasure=true;
                      selfassesmentField=true;
                       }
                  }
                }    
                if(//objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 1').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 3').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 4').getRecordTypeId() 
                  ){
                      if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                           editReport = false;
                          caseStudy2 = false;
                          caseStudy = true;
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            activityMeasure=true;
                      		selfassesmentField=false;
                          otherRecordType = false;
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                      editReport = true;
                           caseStudy2 = false;
                      caseStudy = true;
                      ReadonlyMode = false;
                      readOnlyReport = false;
                      enableAttachment = true;
                      disableAttachment = false;
                      otherRecordType = false;
                      activityMeasure=true;
                      selfassesmentField=false;
                       }
                  }
                
                //pi n1
                
                /*if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 1').getRecordTypeId())
                 {
                     if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                         
                         editReport = false;
                          caseStudy2 = true;
                          caseStudy = false;
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            activityMeasure=true;
                      		selfassesmentField=false;
                          otherRecordType = false;
                         
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                      editReport = true;
                      caseStudy2 = true;
                      caseStudy = false;
                      ReadonlyMode = false;
                      readOnlyReport = false;
                      enableAttachment = true;
                      disableAttachment = false;
                      otherRecordType = false;
                      activityMeasure=true;
                      selfassesmentField=false;
                       }
                 }*/
                
                //pi n1
                
                
                 if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 1').getRecordTypeId() || 
					objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 2').getRecordTypeId())
                 {
                     System.debug('PI N1***'+Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 1').getRecordTypeId());
                     if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                         
                         editReport = false;
                          caseStudy2 = true;
                          caseStudy = false;
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            activityMeasure=true;
                      		selfassesmentField=false;
                          otherRecordType = false;
                         
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                      editReport = true;
                      caseStudy2 = true;
                      caseStudy = false;
                      ReadonlyMode = false;
                      readOnlyReport = false;
                      enableAttachment = true;
                      disableAttachment = false;
                      otherRecordType = false;
                      activityMeasure=true;
                      selfassesmentField=false;
                       }
                 }
                
                //SSE-31
                if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National Read Only').getRecordTypeId() ||
                   objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI Regional Read Only').getRecordTypeId()){
                       
                       editReport = false;
                       caseStudy = true;
                       ReadonlyMode = true;
                       readOnlyReport = true;
                       enableAttachment = false;
                       disableAttachment = true;
                       otherRecordType = false;
                   }
                
                //SSE-36
                if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('CS Case Study').getRecordTypeId()){
                    if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                           editReport = false;
                        	caseStudyField = true;
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            activityMeasure=true;
                      		selfassesmentField=false;
                        otherRecordType = false;
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                    		editReport = true;caseStudyField = true;ReadonlyMode = false;readOnlyReport = false;enableAttachment = true;
                    		disableAttachment = false;otherRecordType = false;
                       }
                }
                
                //SSE-36
                if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('CS Case Study Read Only').getRecordTypeId()){
                    editReport = false;
                    caseStudyField = true;
                    ReadonlyMode = true;
                    readOnlyReport = true;
                    enableAttachment = false;
                    disableAttachment = true;
                    otherRecordType = false;
                }
                
                if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS2){
                    editReport = false;
                    readOnlyReport = true;
                    enableAttachment = false;
                    disableAttachment = true;
                    otherRecordType = false;
                    
                    
                }
                
                /*if(objRep.status__c == REPORTINGSTATUS3 || objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('CS Board Diversity Read Only').getRecordTypeId()){
editReport = true;readOnlyReport = false;enableAttachment = true;disableAttachment = false;
CSBoardDiversity=false;CSBoardDiversityReadOnly=true;


}*/
                if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('CS Board Diversity').getRecordTypeId()){
                    if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                        CSBoardDiversity=false;
                        CSBoardDiversityReadOnly=true;
                       // editReport = false;
                        //ReadonlyMode=true;
                        //readOnlyReport = true;
                        auckland = false;
                        enableAttachment = false;
                        disableAttachment = true;
                        otherRecordType=false;
                        //activityMeasure=true;
                    }
                    else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                        CSBoardDiversity=true;
                        CSBoardDiversityReadOnly=false;
                        editReport = true;
                        //caseStudy = true;
                        ReadonlyMode = false;
                        readOnlyReport = false;
                        enableAttachment = true;
                        disableAttachment = false;
                        otherRecordType = false;
                        activityMeasure=false;
                        selfassesmentField=false;
                    }
                }
                
                if(otherRecordType){
                    System.debug('**********Other Record Type**************');
                      if(objRep.status__c == REPORTINGSTATUS1 || objRep.status__c == REPORTINGSTATUS3 || objRep.status__c == REPORTINGSTATUS4  || objRep.status__c == REPORTINGSTATUS7 ||objRep.status__c == REPORTINGSTATUS8 || objRep.status__c == REPORTINGSTATUS9 || objRep.status__c == REPORTINGSTATUS10){
                           editReport = false;
                        	caseStudyField = true;
                           ReadonlyMode=true;
                           readOnlyReport = true;
                           auckland = false;
                           enableAttachment = false;
                           disableAttachment = true;
                            //activityMeasure=true;
                      		//selfassesmentField=false;
                       }
                       else if(objRep.status__c == REPORTINGSTATUS5 || objRep.status__c == REPORTINGSTATUS6 ){
                    	editReport = true;readOnlyReport = false;enableAttachment = true;disableAttachment = false;
                       }
                    
                }
                //****************
                if(req.Requirement__r.Status__c == REQUIREMENTSTATUS2) {
                    editReport = false;
                    caseStudy = true;
                    ReadonlyMode = true;
                    readOnlyReport = true;
                    auckland = false;
                    enableAttachment = false;
                    disableAttachment = true;
                    otherRecordType = false;
                    
                }
                if(req.Requirement__r.Status__c == REQUIREMENTSTATUS1) {
                    requirementStatusSubmit=true;
                    
                }
                
                /* 
if(objRep.RecordTypeId==Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('CS Board Diversity Read Only').getRecordTypeId()){
CSBoardDiversity=false;
CSBoardDiversityReadOnly=true;
}*/
                /*if(objRep.RecordTypeId != Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('CS Board Diversity Read Only').getRecordTypeId()){
CSBoardDiversity=false;
CSBoardDiversityReadOnly=false;
}
if(objRep.RecordTypeId != Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('CS Board Diversity').getRecordTypeId())
{
CSBoardDiversity=false;
CSBoardDiversityReadOnly=false;
} */
                
                objReport.RecordTypeId = objRep.RecordTypeId;
                objReport.How_much_did_you_do__c = objRep.How_much_did_you_do__c;
                objReport.How_well_did_you_do_it__c = objRep.How_well_did_you_do_it__c;
                objReport.What_impact_did_this_have__c = objRep.What_impact_did_this_have__c;
                objReport.What_were_your_learnings__c = objRep.What_were_your_learnings__c;
                objReport.What_are_you_learning_2__c = objRep.What_are_you_learning_2__c;
                objReport.What_impact_is_this_having_2__c = objRep.What_impact_is_this_having_2__c;
                objReport.How_well_are_you_delivering_2__c = objRep.How_well_are_you_delivering_2__c;
                objReport.Value_of_Auckland__c = objRep.Value_of_Auckland__c;
                objReport.Value_of_Young_People__c = objRep.Value_of_Young_People__c;
                objReport.id = objRep.id;
                objReport.status__c = objRep.status__c;
                objReport.Requirement__c = objRep.Requirement__c;
                objReport.Partner__c = objRep.Partner__c;
                objReport.Case_study_name__c = objRep.Case_study_name__c;
                objReport.Requirement_Status__c = objRep.Requirement_Status__c;
                objReport.Name = objRep.Name;
                objReport.BD_Target_Met__c = objRep.BD_Target_Met__c;
                BD_total_board_members = objRep.BD_total_board_members__c;
                objReport.BD_Total_female__c = objRep.BD_Total_female__c;
                objReport.BD_Target_issues__c = objRep.BD_Target_issues__c;                
                objReport.BD_Total_male__c = objRep.BD_Total_male__c;
                objReport.BD_Total_gender_diverse__c = objRep.BD_Total_gender_diverse__c;
                objReport.BD_board_vacancies__c = objRep.BD_board_vacancies__c;
                objReport.BD_reach_target__c = objRep.BD_reach_target__c;
                objReport.Female_Managers__c = objRep.Female_Managers__c;
                objReport.Male_Managers__c = objRep.Male_Managers__c;
                objReport.Gender_Diverse_Managers__c = objRep.Gender_Diverse_Managers__c;
                objReport.Gender_of_your_CEO__c =  objRep.Gender_of_your_CEO__c;
                objReport.Gender_of_your_Board_Chair__c =  objRep.Gender_of_your_Board_Chair__c;
                objReport.Self_review_rating__c = objRep.Self_review_rating__c;
                system.debug('***objReport.Self_review_rating__c'+objReport.Self_review_rating__c);
                system.debug('***objReport'+objReport);
                
            }
        }
        /*else{
            editReport=false;
        }*/
        
    }
    
    /*Fetching related Requirement of Initiative(Passing as an argument)on which reporting is enabled and
existing Requirement Reporting detail record if present*/
    public List<Requirement_Reporting_Detail__c> checkExisitngReportRecord(String currentRecordId){
        List<Requirement_Reporting_Detail__c> lstRep = new List<Requirement_Reporting_Detail__c>();
        List<Requirement__c>firstReqLst = new List<Requirement__c>();
        List<Requirement__c>secReqLst = new List<Requirement__c>();
        if(currentRecordId != null){
            listReq = [Select ID,
                       Name, Description__c,
                       Status__c,
                       Requirement_Reporting_Record_Type__c,
                       Due_Date__c,
                       Partner__c,CreatedDate,
                       (Select ID,
                        How_much_did_you_do__c,
                        How_well_did_you_do_it__c,
                        What_impact_did_this_have__c,
                        What_were_your_learnings__c,
                        How_well_are_you_delivering_2__c,
                        What_impact_is_this_having_2__c,
                        What_are_you_learning_2__c,
                        Value_of_Auckland__c,
                        Value_of_Young_People__c,
                        Status__c,
                        Name,
                        Partner__c,
                        Case_study_name__c,
                        Requirement_Status__c,
                        BD_total_board_members__c,
                        BD_Total_female__c,
                        BD_Total_male__c,
                        BD_Target_issues__c,
                        BD_Target_Met__c,
                        BD_Total_gender_diverse__c,
                        BD_board_vacancies__c,
                        BD_reach_target__c,
                        Female_Managers__c,
                        Male_Managers__c,
                        Gender_Diverse_Managers__c,
                        Gender_of_your_CEO__c,
                        Gender_of_your_Board_Chair__c,
                        Requirement__c,RecordTypeId,
                        Self_review_rating__c
                        From Requirement_Reporting_Details__r 
                        /*where RecordTypeId=
[Select Id from recordtype where developername=:recType].Id*/
                       )                         
                       From Requirement__c
                       Where Initiative__c =: currentRecordId
                       AND Requirement_Reporting_Record_Type__c != NULL
                       AND Id = :requirementRecordId
                       AND (Status__c =: REQUIREMENTSTATUS1 
                            OR Status__c =: REQUIREMENTSTATUS2
                            OR Status__c =: REPORTINGSTATUS3) ORDER BY CreatedDate DESC LIMIT 1];
            
        }
        if(listReq.size()>0){
            System.debug('listReq*****' + listReq);
            for(Requirement__C newReqVar :listReq ){
                
                
                //Checking Requirement due date Year is of current year or Last Year
                /* if((newReqVar.Due_Date__c.Year() == Date.Today().Year())){
firstReqLst.add(newReqVar);
}else if(newReqVar.Due_Date__c.Year() == Date.Today().Year()-1 && newReqVar.Status__c != 'Overdue'){
secReqLst.add(newReqVar);
}*/
                objReq.Name = newReqVar.Name;
                objReq.Description__c = newReqVar.Description__c;
                if((newReqVar.Due_Date__c.addDays(100) >= Date.Today())){//newReqVar.Due_Date__c >= Date.Today()
                    firstReqLst.add(newReqVar);
                }else if(newReqVar.Due_Date__c.addDays(100) < Date.Today() ){//newReqVar.Due_Date__c < Date.Today() && newReqVar.Status__c == 'Overdue'
                    secReqLst.add(newReqVar);
                }
            }
            // If reporting is enabled on Requirement with current year due date 
            if(firstReqLst.size()>0 ){
                for(Requirement__C reqVar :firstReqLst ){
                    if(reqVar.Status__c == REQUIREMENTSTATUS1 || reqVar.Status__c == REPORTINGSTATUS3) {
                        requirementStatusSubmit=true;
                        
                    }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE1){
                        natCSRubricReport = true;regCSRubricReport = false;caseStudy = true;caseStudyField = false;
                        CSBoardDiversity=false;CSBoardDiversityReadOnly=false;
                    } if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE2){
                        natCSRubricReport = false;regCSRubricReport = true;caseStudy = true;caseStudyField = false;
                        CSBoardDiversity=false;CSBoardDiversityReadOnly=false;
                    } if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE3){
                        natCSRubricReport = false;
                        regCSRubricReport = false;
                        caseStudy = false;
                        CSBoardDiversity=false;
                        CSBoardDiversityReadOnly=false;
                        caseStudyField = true;
                    }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE4){
                        //CSBoardDiversity=true;
                        CSBoardDiversityReadOnly=true;
                    }
                    //*********************************
                    if(//reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE5 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE6){
                           caseStudy=true;
                       }
                    
                    //SSE-169
					if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE5){
                           caseStudy2=true;
                       }
                    
                    //SSE-129
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE7){
                        System.debug('im here 7-1');
                           String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_1__c,What_activity_will_you_do_in_Year_1__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                          
                            caseStudy=false;
                           	caseStudy2=true;
                           	activityMeasure=true;
                           	year1=true;
                           	year2=false;
                           	year3=false;
                           	year4=false;
                           	selfassesmentField=true;
                              
                           }
                         
                       }
                    
                    
                    if(//reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE7 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE11){
                           System.debug('im here 11-1');
                           String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_1__c,What_activity_will_you_do_in_Year_1__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                          
                           	caseStudy=true;
                           	activityMeasure=true;
                           	year1=true;
                           	year2=false;
                           	year3=false;
                           	year4=false;
                           	selfassesmentField=true;
                           }
                       }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE8 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE12){
                           System.debug('im here 8-12-1');
                            String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_2__c,What_activity_will_you_do_in_Year_2__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                           caseStudy=false;//SSE-169
                           caseStudy2=true;//SSE-169    
                           activityMeasure=true;
                           year1=false;
                           year2=true;
                           year3=false;
                           year4=false;
                           selfassesmentField=true;
                           }
                       }
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE9 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE13){
                           System.debug('im here 9-13-1');
 						String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_3__c,What_activity_will_you_do_in_Year_3__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                           caseStudy=true;
                           activityMeasure=true;
                           year1=false;
                           year2=false;
                           year3=true;
                           year4=false;
                           selfassesmentField=true;
                           }
                       }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE10 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE14){
                           System.debug('im here 10-14-1');
                            String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_4__c,What_activity_will_you_do_in_Year_4__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                           caseStudy=true;
                           activityMeasure=true;
                           year1=false;
                           year2=false;
                           year3=false;
                           year4=true;
                           selfassesmentField=true;
                           }
                       }
                    
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE15){
                        System.debug('Im here 15-1*****');
                         String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_1__c,What_activity_will_you_do_in_Year_1__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                        caseStudy=false;
                        caseStudy2=true; // SSE-169
                        activityMeasure=true;
                        year1=true;
                        year2=false;
                        year3=false;
                        year4=false;
                        selfassesmentField=false;
                           }
                    }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE16){
                        System.debug('im here 16-1');
                         String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_2__c,What_activity_will_you_do_in_Year_2__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                        caseStudy=false;
                        caseStudy2=true;
                        activityMeasure=true;
                        year1=false;
                        year2=true;
                        year3=false;
                        year4=false;
                        selfassesmentField=false;
                           }
                    }
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE18){
                        System.debug('im here 18-1');
                         String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_4__c,What_activity_will_you_do_in_Year_4__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                        caseStudy=true;
                        activityMeasure=true;
                        year1=false;
                        year2=false;
                        year3=false;
                        year4=true;
                        selfassesmentField=false;
                           }
                    }
                    if(objReport.Name == NULL){
                        objReport.Name = reqVar.name +' Report';
                    }
                    editReport = true;
                    newListReq.add(reqVar);
                    if(reqVar != NULL){
                        for(Requirement_Reporting_Detail__c reqRep : reqVar.Requirement_Reporting_Details__r){
                            lstRep.add(reqRep);
                        }
                    }
                }
            }
            /*If reporting is not enabled on Requirement with current year due date then display previous year 
Requirement with Reporting enable*/
            else if(firstReqLst.size()< 1 && secReqLst.size()>0 ){
                for(Requirement__C reqVar :secReqLst ){
                    if(reqVar.Status__c == REQUIREMENTSTATUS1 || reqVar.Status__c == REPORTINGSTATUS3) {
                        requirementStatusSubmit=true;
                        
                    }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE1){
                        
                        System.debug('im here 1-2');
                        natCSRubricReport = false;
                        CSBoardDiversity=false;
                        CSBoardDiversityReadOnly=false;
                        regCSRubricReport = false;
                        caseStudy = false;
                        caseStudyField = false;
                        ReadonlyMode = true;
                    } if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE2){
                        System.debug('im here 2-2');
                        natCSRubricReport = false;
                        CSBoardDiversity=false;
                        CSBoardDiversityReadOnly=false;
                        regCSRubricReport = false;
                        caseStudy = false;
                        caseStudyField = false;
                        ReadonlyMode = true;
                    } if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE3){
                        System.debug('im here 3-2');
                        natCSRubricReport = false;
                        regCSRubricReport = false;
                        caseStudy = false;
                        CSBoardDiversity=false;
                        CSBoardDiversityReadOnly=false;
                        caseStudyField = false;
                        ReadonlyMode = true;
                    } if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE4){
                        System.debug('im here 4-2');
                        
                        CSBoardDiversityReadOnly=true;
                        
                    }
                    //*******************
                    if(//reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE5 || 
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE6){
                           System.debug('im here 6-2');
                           caseStudy=true;
                       }
                    // SSE-169 
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE5){
                        System.debug('im here 5-2');
                           caseStudy2=true;
                       }
                    
                    if(//reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE7 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE11){
                           System.debug('im here 11-2');
                            String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_1__c,What_activity_will_you_do_in_Year_1__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                           caseStudy=true;
                           activityMeasure=true;
                           year1=true;
                           year2=false;
                           year3=false;
                           year4=false;
                           selfassesmentField=true;
                           }
                       }
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE7){
                        System.debug('im here 7-2');
                            String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_1__c,What_activity_will_you_do_in_Year_1__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                           caseStudy=false;
                           caseStudy2=true;
                           activityMeasure=true;
                           year1=true;
                           year2=false;
                           year3=false;
                           year4=false;
                           selfassesmentField=true;
                           }
                       }
                    
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE8 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE12){
                           System.debug('im here 8-12-2');
                            String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_2__c,What_activity_will_you_do_in_Year_2__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                           caseStudy=false;
                           caseStudy2=true;//SSE-169
                           activityMeasure=true;
                           year1=false;
                           year2=true;
                           year3=false;
                           year4=false;
                           selfassesmentField=true;
                           }
                       }
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE9 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE13){
                           System.debug('im here 9-13-2');
                            String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_3__c,What_activity_will_you_do_in_Year_3__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                           caseStudy=true;
                           activityMeasure=true;
                           year1=false;
                           year2=false;
                           year3=true;
                           year4=false;
                           selfassesmentField=true;
                           }
                       }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE10 ||
                       reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE14){
                           System.debug('im here 10-14-2');
                            String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_4__c,What_activity_will_you_do_in_Year_4__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                           caseStudy=true;
                           activityMeasure=true;
                           year1=false;
                           year2=false;
                           year3=false;
                           year4=true;
                           selfassesmentField=true;
                           }
                       }
                    
                    
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE15){
                        System.debug('im here 15-2 ****'); 
                        String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_1__c,What_activity_will_you_do_in_Year_1__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                        caseStudy=false;
                        caseStudy2=true; // SSE-169
                        activityMeasure=true;
                        year1=true;
                        year2=false;
                        year3=false;
                        year4=false;
                        selfassesmentField=false;
                           }
                    }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE16){
                        System.debug('im here 16-2');
                         String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_2__c,What_activity_will_you_do_in_Year_2__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                        caseStudy=false;
                        caseStudy2=true;
                        activityMeasure=true;
                        year1=false;
                        year2=true;
                        year3=false;
                        year4=false;
                        selfassesmentField=false;
                           }
                    }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE17){
                        System.debug('im here 17-2');
                         String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_3__c,What_activity_will_you_do_in_Year_3__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                        caseStudy=true;
                        activityMeasure=true;
                        year1=false;
                        year2=false;
                        year3=true;
                        year4=false;
                        selfassesmentField=false;
                           }
                    }
                    if(reqVar.Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE18){
                        System.debug('im here 18-2');
                         String idtName=[select Initiative_Development_Template__r.Name from Initiative__c where Id =:currentRecordId].Initiative_Development_Template__r.Name;
                           if(idtName!=null){
                          objIdt=[select How_will_you_measure_success_in_Year_4__c,What_activity_will_you_do_in_Year_4__c from Initiative_Development_Template__c where 
                                  Name =:idtName];
                        caseStudy=true;
                        activityMeasure=true;
                        year1=false;
                        year2=false;
                        year3=false;
                        year4=true;
                        selfassesmentField=false;
                           }
                    }
                    
                    if(objReport.Name == NULL){
                        objReport.Name = reqVar.name +' Report';
                    }
                    editReport = true;
                    newListReq.add(reqVar);
                    if(reqVar != NULL){
                        for(Requirement_Reporting_Detail__c reqRep : reqVar.Requirement_Reporting_Details__r ){
                            lstRep.add(reqRep);
                        }
                    }
                }
            }
        }
        return lstRep;
    }
    
    //Upsert Requirement Reporting record on click of Save button
    public  void saveMethod(){
        Map<String,Id> recordTypesAvailable = new Map<String,Id>(); //Map to store Requirement Reporting Detail Record type
        //Fetching Record type of Requirement Reporting detail object
        for(RecordType objRecordType: [Select 	Id, 
                                       DeveloperName 
                                       From 	RecordType 
                                       WHERE 	sObjectType = 'Requirement_Reporting_Detail__c'
                                      ]){
                                          recordTypesAvailable.put(objRecordType.DeveloperName , objRecordType.Id);
                                      }
        if(newListReq.size()>0) {
            objReport.Requirement__c = newListReq[0].ID;
            objReport.Partner__c = newListReq[0].Partner__c;
            objReport.Requirement_Status__c = newListReq[0].status__c;//rrd status gets changed with requirement status
            System.debug('objReport###'+objReport.Case_study_name__c);
            
            if(objReport.status__c == NULL){
                objReport.status__c = 'Draft';
            }
            
            if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE1){
                objReport.RecordTypeId = recordTypesAvailable.get('Nat_CS_Rubric_1');
                objReport.Value_of_Young_People__c = NULL;
            }else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE2){
                objReport.RecordTypeId = recordTypesAvailable.get('Reg_CS_Rubric_2');
                objReport.Value_of_Auckland__c = NULL;
            }else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE3){
                objReport.RecordTypeId = recordTypesAvailable.get('CS_Case_Study');
                objReport.Value_of_Auckland__c = NULL;
                objReport.Value_of_Young_People__c = NULL;
                objReport.How_much_did_you_do__c = NULL;
                objReport.How_well_did_you_do_it__c = NULL;
                objReport.What_impact_did_this_have__c = NULL;
                objReport.What_were_your_learnings__c = NULL;
            }else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE4){
                objReport.RecordTypeId = recordTypesAvailable.get('CS_Board_Diversity');
                /*objReport.BD_Total_female__c = NULL;
objReport.BD_Total_male__c = NULL;
objReport.BD_Total_gender_diverse__c = NULL;
objReport.BD_board_vacancies__c = NULL;
objReport.BD_reach_target__c = NULL;*/
            }
            //**********************
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE5){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National');
                
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE6){
  
                objReport.RecordTypeId = recordTypesAvailable.get('PI_Regional');
                
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE7){
                //objReport.RecordTypeId = recordTypesAvailable.get('PI National + 1');
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National_1');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE8){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National_2');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE9){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National_3');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE10){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National_4');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE11){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_Regional_1');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE12){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_Regional_2');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE13){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_Regional_3');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE14){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_Regional_4');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE15){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National_y1');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE16){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National_y2');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE17){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National_y3');
            }
            else if(newListReq[0].Requirement_Reporting_Record_Type__c == REPORTINGRECORDTYPE18){
                objReport.RecordTypeId = recordTypesAvailable.get('PI_National_y4');
            }
        }
        try{
            upsert objReport; 
            enableAttachment = true;
            testboolean = 'SUCCESS';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info, System.Label.Requirement_Reporting_Success));
        }
        catch(exception e) {
            testboolean =e.getMessage() ;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
        }
        /*PageReference pageRef = ApexPages.currentPage();
pageRef.setRedirect(true);
return pageRef;*/
    }
    
    public void submitMethod(){
        saveMethod();
        List<Initiative__c> invRec =[Select id,name,Initiative_Owner__c from Initiative__c where id=:currentRecordId];
        initiativeOwner= invRec[0].Initiative_Owner__c;
        List<User> usrRec=[select id,name,Email from User where Id =:initiativeOwner];
        String initiativeEmail=usrRec[0].Email;
        String initiativeID=usrRec[0].id;
        List<Requirement_Reporting_Detail__c> reqlst1=new List<Requirement_Reporting_Detail__c>();
        Requirement_Reporting_Detail__c r;
        
        if(newListReq.size()>0) {
           
            r=objReport;
            r.status__c = 'Submitted';
            //upsert r;
        }
        try{
            upsert r; 
            Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
            String[] sendingTo = new String[]{initiativeEmail};
                semail.setToAddresses(sendingTo);
            semail.setSubject(' Report has been submitted');
            //semail.setPlainTextBody('Hello, This mail is to inform you that, status for '+invRec[0].name+' has been changed to submitted.');
            //String param1 ='<html><body>Dear '+usrRec[0].name+', <br><br>This mail is to inform you that, status for Requirement Reporting Detail of initiative <a href="https://sportnzgroup.lightning.force.com/lightning/r/Requirement_Reporting_Detail__c/'+r.Id+'/view">'+invRec[0].name+'</a> has been changed to submitted.';
           String param1;
            if([select id,isSandbox from Organization].isSandbox)
        	{
             	param1 ='<html><body>Dear '+usrRec[0].name+', <br><br>This mail is to inform you that, status for Requirement Reporting Detail of initiative <a href="https://sportnzgroup--preprod.lightning.force.com/lightning/r/Requirement_Reporting_Detail__c/'+r.Id+'/view">'+invRec[0].name+'</a> has been changed to submitted.';
        	}
            else
            param1 ='<html><body>Dear '+usrRec[0].name+', <br><br>This mail is to inform you that, status for Requirement Reporting Detail of initiative <a href="https://sportnzgroup.lightning.force.com/lightning/r/Requirement_Reporting_Detail__c/'+r.Id+'/view">'+invRec[0].name+'</a> has been changed to submitted.';    
            semail.setHtmlBody(param1);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info, System.Label.Requirement_Reporting_Submit_Success));
        }
        catch(exception e) {
            testboolean =e.getMessage() ;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
        }
        
    }
    
    //Method called on click of Cancel Button
    public PageReference cancelMethod(){
        PageReference p = new PageReference('/apex/Initiative_Page');
        p.setRedirect(true);
        return p;
    }
}