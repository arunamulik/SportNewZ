public with sharing class StartInvestmentScheduleReportController {

    private Business_Case__c investmentSchedule;

    public StartInvestmentScheduleReportController(ApexPages.StandardController sc) {
        investmentSchedule = [SELECT Id FROM Business_Case__c WHERE Id = :sc.getId()];
    }

    public void startInvestmentScheduleReport() {
        try {
            investmentSchedule.Conga_Workflow_Investment_Schedule__c = true;
            update investmentSchedule;

            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Document sent'));
        } catch (Exception e) {
            System.debug(e.getMessage() + '\n' + e.getStackTraceString());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Something went wrong, please contact your System Administrator'));
        }
    }
}