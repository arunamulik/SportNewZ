@isTest
public class TestBatchToUpdateRequirementRRDstatus {
    
    static testMethod void testMethod1() 
    {
         Initiative__c objInit = testDataFactory();
        
        Initiative_Development_Template__c idt=new Initiative_Development_Template__c();
        idt.How_will_you_measure_success_in_Year_1__c='measure1';
        idt.What_activity_will_you_do_in_Year_1__c='activity1';
        //Amount_of_Investment_Year_1__c, Initiative_Name__c, Organisation_Name__c
        idt.Amount_of_Investment_Year_1__c=100.50;
        idt.Initiative_Name__c=objInit.Name;
        idt.Organisation_Name__c='00190000019RqvGAAS';
		insert idt;
        
        objinit.Initiative_Development_Template__c=idt.id;
        update objinit;
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
       // requirementobject.Due_Date__c = Date.valueOf('01/01/2021');       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 4';
        insert requirementObject;
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'CS Board Diversity'].Id;
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Being Reviewed';
        objRep.RecordTypeId =  recID;
        insert objRep;
        
        Test.startTest();

            BatchToUpdateRequirementRRDstatus obj = new BatchToUpdateRequirementRRDstatus();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
    
    public static Initiative__c testDataFactory(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        /*User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='rajput', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
        */
        User usr=new User();
        if([select id,isSandbox from Organization].isSandbox)
        {
              usr=[Select Id from User where Name='Admin Eternus' and email='sandra.fernandes@eternussolutions.com'];
        }
        else
             usr=[Select Id from User where Name='Admin Eternus' and email='sandra.fernandes@eternussolutions.com'];
       
        Account testAccount = new Account( Name = 'Test Account' );
        insert testAccount;
        
        Plan__c plan = new Plan__c(Partner__c=testAccount.Id,Status__c='Draft',Start_Date__c=system.today(),
                                   End_Date__c = system.today().addDays(200));
        insert plan;
        
        Strategic_Area__c sArea = new Strategic_Area__c();
        sArea.Name = 'Wellington';
        sArea.Entity__c = 'Sportz Anz';
        sArea.Status__c = 'Draft';
        sArea.Start_Date__c = system.Today();
        sArea.End_Date__c = system.Today().addDays(2);
        insert sArea;
        
        Investment_Area__c iArea = new Investment_Area__c();
        iArea.Name = 'Davanti';
        iArea.Strategic_Area__c = sArea.Id;
        iArea.Status__c = 'Active';
        iArea.Start_Date__c = system.Today();
        iArea.End_Date__c = system.Today().addDays(2);
        iArea.Investment_Area_Owner__c = usr.Id;
        insert iArea;
        
        Funding_Allocation__c fAllocation = new Funding_Allocation__c();
        fAllocation.Financial_Year__c='2018/19';
        fAllocation.Funding_Allocation_End_Date__c=system.Today().addDays(90);
        fAllocation.Funding_Allocation_Start_Date__c= system.Today();
        fAllocation.Funding_Amount__c =500;
        fAllocation.Strategic_Area__c = sArea.Id;
        insert fAllocation;
        
        Investment_Area_Allocation__c invAreaAllocation = new Investment_Area_Allocation__c();
        invAreaAllocation.Amount__c = 400;
        invAreaAllocation.Investment_Area__c = iArea.Id;
        invAreaAllocation.Funding_Allocation__c = fAllocation.Id;
        invAreaAllocation.Status__c = 'Draft';
        insert invAreaAllocation;
        
       
     
        Initiative__c inv = new Initiative__c(Name='Test Inv',
                                              Investment_Area__c=iArea.Id,
                                              Plan__c=plan.Id,
                                              Initiative_Owner__c=usr.Id,
                                              End_Date__c = system.today().addDays(190),
                                              Start_Date__c = system.today(),
                                              Planned__c = 10,
                                              Priority__c = 'Must',
                                              Type__c = 'Paid Direct');
        insert inv;
        return inv;
    }

}