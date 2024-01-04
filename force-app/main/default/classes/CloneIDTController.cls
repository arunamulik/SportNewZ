public class CloneIDTController {
    
    public Initiative_Development_Template__c idt;
	public String IDTid;
     public CloneIDTController(ApexPages.StandardController controller) {
     
         system.debug('In Contructor!');
        IDTid = ApexPages.currentPage().getParameters().get('Id');
        
        // query all necessary fields.
        idt = [select Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, 
               	SystemModstamp, LastViewedDate, LastReferencedDate, Amount_of_Investment_Year_1__c, Financial_Year__c, 
               	How_will_you_measure_success_in_Year_1__c, How_will_you_measure_success_in_Year_2__c, 
               	How_will_you_measure_success_in_Year_3__c, Initiative_Name__c, Investment_Area__c, Number_of_FTE_Allocated__c, 
               	Organisation_Name__c, Relationship_Manager__c, Status__c, What_Risks_have_been_identified__c, 
               	What_activity_will_you_do_in_Year_1__c, What_activity_will_you_do_in_Year_2__c, What_activity_will_you_do_in_Year_3__c, 
               	What_outcomes_will_you_achieve__c, Who_will_lead_this_area__c, Amount_of_Investment_Year_2__c, 
               	Amount_of_Investment_Year_3__c, Sport_NZ_Feedback__c, SME_Comments__c, SME_Approvers__c, Sign_Off_Approval_Date__c, 
               	How_will_you_measure_success_in_Year_4__c, What_activity_will_you_do_in_Year_4__c,Outcome_area__c,Outcomes__c
               from Initiative_Development_Template__c 
               where Id = :IDTid limit 1];
         
				
     }
    
    public PageReference cloneIDT()
    {
        System.debug('In method:-'+ idt);
        Initiative_Development_Template__c clonedIDT = new Initiative_Development_Template__c();
        clonedIDT.Amount_of_Investment_Year_1__c = idt.Amount_of_Investment_Year_1__c;
        clonedIDT.Amount_of_Investment_Year_2__c = idt.Amount_of_Investment_Year_2__c;
        clonedIDT.Amount_of_Investment_Year_3__c = idt.Amount_of_Investment_Year_3__c;
        clonedIDT.Financial_Year__c = idt.Financial_Year__c;
        clonedIDT.How_will_you_measure_success_in_Year_1__c = idt.How_will_you_measure_success_in_Year_1__c;
        clonedIDT.How_will_you_measure_success_in_Year_2__c = idt.How_will_you_measure_success_in_Year_2__c;
        clonedIDT.How_will_you_measure_success_in_Year_3__c = idt.How_will_you_measure_success_in_Year_3__c;
        clonedIDT.How_will_you_measure_success_in_Year_4__c = idt.How_will_you_measure_success_in_Year_4__c;
        
        clonedIDT.Investment_Area__c = idt.Investment_Area__c;
        clonedIDT.Number_of_FTE_Allocated__c = idt.Number_of_FTE_Allocated__c;
        clonedIDT.Organisation_Name__c = idt.Organisation_Name__c;
        clonedIDT.Relationship_Manager__c = idt.Relationship_Manager__c;
        clonedIDT.Initiative_Name__c = 'Copy-'+idt.Initiative_Name__c;
        clonedIDT.Sign_Off_Approval_Date__c = null;
        clonedIDT.SME_Approvers__c = null;
        clonedIDT.SME_Comments__c = null;
        clonedIDT.Sport_NZ_Feedback__c = null;
        clonedIDT.Status__c = 'Draft';
        clonedIDT.What_activity_will_you_do_in_Year_1__c = idt.What_activity_will_you_do_in_Year_1__c;
        clonedIDT.What_activity_will_you_do_in_Year_2__c = idt.What_activity_will_you_do_in_Year_2__c;
        clonedIDT.What_activity_will_you_do_in_Year_3__c = idt.What_activity_will_you_do_in_Year_3__c;
        clonedIDT.What_activity_will_you_do_in_Year_4__c = idt.What_activity_will_you_do_in_Year_4__c;
        clonedIDT.What_outcomes_will_you_achieve__c = idt.What_outcomes_will_you_achieve__c;
        clonedIDT.What_Risks_have_been_identified__c = idt.What_Risks_have_been_identified__c;
        clonedIDT.Who_will_lead_this_area__c = idt.Who_will_lead_this_area__c;
        clonedIDT.Outcome_area__c = idt.Outcome_area__c;
        clonedIDT.Outcomes__c = idt.Outcomes__c;
        
        
        insert clonedIDT;
        
       
       /* QuickAction.QuickActionRequest req = new QuickAction.QuickActionRequest();
    req.quickactionname = QuickAction.Edit;
    req.record = clonedIDT;
    QuickAction.QuickActionResult res = QuickAction.performQuickAction(req);*/
    //return clonedIDT.id;
        
        return (new PageReference('/' + clonedIDT.Id));
    }
}