@isTest(SeeAllData=true)
public class Test_DedupePayments {
    static testMethod void getDedupedPaymentsTest() {
     
          
               
               //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Default_Security_Profile__c profile = Default_Security_Profile__c.getValues('Profile');
        Id sportNZProfile = [Select Id from Profile where Name =:profile.Value__c].Id;
     
        //Create User
        User userObject = new User();
        userObject.LastName = 'Test';
        userObject.Alias = 'test';
        userObject.Username = 'test@sportnz.org.nz';
        userObject.CommunityNickname = 'test';
        userObject.Email = 'test@sportnz.org.nz';
        userObject.EmailEncodingKey = 'UTF-8';
        userObject.LanguageLocaleKey = 'en_US';
        userObject.LocaleSidKey = 'en_NZ';
        userObject.TimeZoneSidKey = 'Pacific/Auckland';
        userObject.ProfileId = sportNZProfile;
        insert userObject;
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        strategicAreaObject.OwnerId = userObject.Id;
        insert strategicAreaObject;
        
        //Create Investment Area
        Investment_Area__c investmentAreaObject = new Investment_Area__c();
        investmentAreaObject.RecordTypeId = investmentAreaStandardInvestmentRecordTypeId;
        investmentAreaObject.Strategic_Area__c = strategicAreaObject.id;
        investmentAreaObject.Name = 'Test Investment Area';
        investmentAreaObject.Start_Date__c = date.today();
        investmentAreaObject.End_Date__c = date.today().addDays(5);
        investmentAreaObject.Status__c = 'Active';
        insert investmentAreaObject;
        
        Funding_Allocation__c objFund = new Funding_Allocation__c();
        objFund.Strategic_Area__c = strategicAreaObject.id;
        objFund.Financial_Year__c = '2018/19';
        objFund.Funding_Amount__c = 10000;
        objFund.Funding_Allocation_Start_Date__c = system.today();
        objFund.Funding_Allocation_End_Date__c = system.today().addDays(365);
        objFund.Status__c = 'Approved';
        insert objFund;
        
        Investment_Area_Allocation__c objInv = new Investment_Area_Allocation__c();
        objInv.Investment_Area__c = investmentAreaObject.id;
        objInv.Funding_Allocation__c = objFund.id;
        objInv.Amount__c = 10000;
        objInv.Status__c= 'Active';
        insert objInv;
        
        //Create Business Case
        Business_Case__c businessCaseObject = new Business_Case__c();
        businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Draft';
        insert businessCaseObject;
        
        //Create Account
        Id accountPartnerRecordTypeId = [Select Id from RecordType where sobjectType = 'Account' and Name = 'Organisation'].Id;
        Account accountObject = new Account();
        accountObject.RecordTypeId = accountPartnerRecordTypeId;
        accountObject.Name = 'Test Partner';
        accountObject.Type = 'National Sporting Organization';
        insert accountObject;
        
        
        //Create Plan
        Id planPartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Plan__c' and Name = 'Partner Plan'].Id;
        Plan__c planObject = new Plan__c();
        planObject.Partner__c = accountObject.id;
        planObject.RecordTypeId = planPartnerPlanRecordTypeId;
        planObject.Start_Date__c = date.today();
        planObject.End_Date__c = date.today().addDays(5);
        planObject.Status__c = 'Active';
        insert planObject;
        
        Variation__c objVariation = RUL_Util.createVariation()[0];
        objVariation.Investment_Schedule__c = businessCaseObject.id;
        insert objVariation;
        
        //Create Initiatives
        Id initiativePartnerPlanRecordTypeId = [Select Id from RecordType where sobjectType = 'Initiative__c' and Name = 'Partner Plan'].Id;
        List<Initiative__c> initiatives = new List<Initiative__c>();
        Initiative__c initiativeObject = new Initiative__c();
        initiativeObject.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject.Name = 'Test Initiative'+ System.currentTimeMillis();
        initiativeObject.Plan__c = planObject.id;
        initiativeObject.Type__c = 'Paid to Partner';
        initiativeObject.Start_Date__c = date.today();
        initiativeObject.End_Date__c = date.today().addDays(5);
        initiativeObject.Requested__c = 100;
        initiativeObject.Planned__c = 100;
        initiativeObject.Priority__c = 'Must';
        initiativeObject.Initiative_Owner__c = userObject.Id;
        initiativeObject.Investment_Area__c = investmentAreaObject.id;
        initiativeObject.Business_Case__c = businessCaseObject.id;
        initiativeObject.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject);
        
        Initiative__c initiativeObject1 = new Initiative__c();
        initiativeObject1.RecordTypeId = initiativePartnerPlanRecordTypeId;
        initiativeObject1.Name = 'Test Initiative';
        initiativeObject1.Plan__c = planObject.id;
        initiativeObject1.Type__c = 'Paid to Partner';
        initiativeObject1.Start_Date__c = date.today();
        initiativeObject1.End_Date__c = date.today().addDays(5);
        initiativeObject1.Requested__c = 100;
        initiativeObject1.Planned__c = 100;
        initiativeObject1.Priority__c = 'Must';
        initiativeObject1.Initiative_Owner__c = userObject.Id;
        initiativeObject1.Investment_Area__c = investmentAreaObject.id;
        initiativeObject1.Business_Case__c = businessCaseObject.id;
        initiativeObject1.Investment_Schedule_Variation__c = objVariation.Id;
        initiatives.add(initiativeObject1);
        insert initiatives;
            
          List<List<Initiative__c> >initiatives1 = new List<List<Initiative__c> >();
        initiatives1.add(initiatives);  
            
            
            
            
            
            
      /*  Payment__c pay = new Payment__c();
        pay.Initiative__c= initiativeObject.id; 
        insert pay;*/
      Payment__c objPayment5 = new Payment__c();
        objPayment5.RecordTypeId = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        objPayment5.Status__c = 'Draft';
        objPayment5.Old_Status__c = 'Draft';
        objPayment5.Supplier_Invoice_Date__c = system.today();
        objPayment5.Supplier_Invoice_Number__c = '123';
        objPayment5.Partner__c = accountObject.id;
        objPayment5.Amount__c = 100;
        objPayment5.Date__c = Date.Today();
        objPayment5.Initiative__c = initiatives[0].Id;
        objPayment5.RUL_Old_RecordType_Id__c = [Select Id from RecordType where sobjectType = 'Payment__c' and Name = 'Payment'].Id;
        insert objPayment5;
        DedupePayments.getDedupedPayments(initiatives1);
    }
}