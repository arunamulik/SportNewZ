@isTest
private class RUL_SendEmailTest {
    private static testmethod void testCaseOne() {
        Account newAcc = new Account();
        newAcc.Name = 'Test Account';
        insert newAcc;
        
        PageReference newPageRef = Page.RUL_SendEmail;
        newPageRef.getParameters().put('Id',newAcc.Id);
        Test.setCurrentPage(newPageRef);
        
        RUL_SendEmail newObj = new RUL_SendEmail();
        newObj.strSubject = 'Test';
        newObj.strBody  = 'Test';
        newObj.sendEmail();
        
        System.assert(Limits.getEmailInvocations()==1);
    }
    
    private static testmethod void testCaseTwo() {
        Account newAcc = new Account();
        newAcc.Name = 'Test Account';
        insert newAcc;
        
        PageReference newPageRef = Page.RUL_SendEmail;
        newPageRef.getParameters().put('Id',newAcc.Id);
        Test.setCurrentPage(newPageRef);
        
        RUL_SendEmail newObj = new RUL_SendEmail();
        newObj.strToAddress += ',test@gmail.com';
        newObj.strSubject = 'Test';
        newObj.strBody  = 'Test';
        newObj.fname = 'Test';
        newObj.sendEmail();
        
        System.assert(Limits.getEmailInvocations()==1);
    }
    
    private static testmethod void testCaseThree() {
        Account newAcc = new Account();
        newAcc.Name = 'Test Account';
        insert newAcc;
        
        PageReference newPageRef = Page.RUL_SendEmail;
        newPageRef.getParameters().put('Id',newAcc.Id);
        Test.setCurrentPage(newPageRef);
        
        RUL_SendEmail newObj = new RUL_SendEmail();
        newObj.strToAddress += 'abcd';
        newObj.sendEmail();
        
        System.assert(Limits.getEmailInvocations()==0);
    }
}