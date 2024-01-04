/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used for the test the functionality of HistoricReqReportingController Class

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 31-03-2022       | Aruna Mulik  | 1. Created class to test functionality of HistoricReqReportingController Class
   ==========================================================================================================================
*/
@istest()
public class TestHistoricReqReportingController {
    
    @isTest
    public static void test1() {
        Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'CS Case Study';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Status__c ='Draft';
        objRep.BD_Target_Met__c = 'No';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test2() {
        Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'CS Board Diversity';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Status__c ='Draft';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
       obj.saveMethod();
       //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }

    @isTest
    public static void test3() {
        Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test4() {
        Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
//SSE-129 
@isTest
    public static void test8() {
         Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National + 1'].Id;
         Initiative__c objInit = testDataFactory();
        
        Account acc=new Account();
        acc.Name='New Zealand Org';
        insert acc;
        
        Initiative_Development_Template__c idt=new Initiative_Development_Template__c();
        idt.How_will_you_measure_success_in_Year_1__c='measure1';
        idt.What_activity_will_you_do_in_Year_1__c='activity1';
        idt.Amount_of_Investment_Year_1__c=100.50;
        idt.Initiative_Name__c=objInit.id;
        idt.Organisation_Name__c=acc.Id;
		insert idt;
		
		objinit.Initiative_Development_Template__c=idt.id;
        update objinit;
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National + 1';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
        objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test9() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional + 2';
        insert requirementObject;
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI Regional + 2'].Id;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
         objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    
    @isTest
    public static void test9_1() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional + 2';
        insert requirementObject;
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI Regional + 2'].Id;
        
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
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }


 @isTest
    public static void test10() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional + 3';
        insert requirementObject;
         Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI Regional + 3'].Id;
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
         objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
       HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
       // system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
     @isTest
    public static void test11() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional + 4';
        insert requirementObject;
         Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI Regional + 4'].Id;
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
         objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
       HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
     @isTest
    public static void test12() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 1';
        insert requirementObject;
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National 1'].Id;
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
         objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
         HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test12_1() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National';
        insert requirementObject;
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National'].Id;
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
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
       HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test12_2() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National';
        insert requirementObject;
        
        //Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National 1'].Id;
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
       // objRep.Status__c ='Draft';
         //objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }

    
    @isTest
    public static void test12_3() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National';
        insert requirementObject;
        
        //Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National 1'].Id;
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
         //objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    
 @isTest
    public static void test13() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 2';
        insert requirementObject;
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National 2'].Id;
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
         objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test13_1() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 2';
        insert requirementObject;
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National 2'].Id;
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
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }

     @isTest
    public static void test14() {
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
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 3';
        insert requirementObject;
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National 3'].Id;
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
         objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }

     @isTest
    public static void test15() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 4').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National + 1';
        insert requirementObject;

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
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }

    
     @isTest
    public static void test15_1() {
         Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('CS Board Diversity').getRecordTypeId();
		
        
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'CS Board Diversity';
        insert requirementObject;
        
         Initiative_Development_Template__c idt=new Initiative_Development_Template__c();
        idt.How_will_you_measure_success_in_Year_1__c='measure1';
        idt.What_activity_will_you_do_in_Year_1__c='activity1';
        //Amount_of_Investment_Year_1__c, Initiative_Name__c, Organisation_Name__c
        idt.Amount_of_Investment_Year_1__c=100.50;
        idt.Initiative_Name__c=objInit.Name;
        idt.Organisation_Name__c='00190000019RqvGAAS';
		insert idt;
        
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        objinit.Initiative_Development_Template__c=idt.id;
        update objinit;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    
    @isTest
    public static void test15_2() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National').getRecordTypeId();
		
        
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(-150);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National';
        insert requirementObject;
        
         Initiative_Development_Template__c idt=new Initiative_Development_Template__c();
        idt.How_will_you_measure_success_in_Year_1__c='measure1';
        idt.What_activity_will_you_do_in_Year_1__c='activity1';
        //Amount_of_Investment_Year_1__c, Initiative_Name__c, Organisation_Name__c
        idt.Amount_of_Investment_Year_1__c=100.50;
        idt.Initiative_Name__c=objInit.Name;
        idt.Organisation_Name__c='00190000019RqvGAAS';
		insert idt;
        
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        objinit.Initiative_Development_Template__c=idt.id;
        update objinit;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    
    @isTest
    public static void test15_3() {
         Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 4').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 4';
        insert requirementObject;
        
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
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    
    @isTest
    public static void test15_4() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 1').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National + 1';
        insert requirementObject;

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
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test15_5() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 2').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National + 2';
        insert requirementObject;

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
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    
    @isTest
    public static void test15_6() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National + 3').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National + 3';
        insert requirementObject;

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
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test15_7() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 2').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 2';
        insert requirementObject;

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
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    
    @isTest
    public static void test15_8() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 3').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 3';
        insert requirementObject;

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
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }

	
    @isTest
    public static void test15_9() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National 1').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National 1';
        insert requirementObject;

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
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
	    
    
    @isTest
    public static void test16() {
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
        objRep.Status__c ='Draft';
        objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
       // system.assertEquals(true, obj.editReport);
        system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test17() {
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
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }

//        
    @isTest
    public static void test5() {
        Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        //obj.cancelMethod();
        //obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test5_1() {
        Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Being Reviewed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        //obj.cancelMethod();
        //obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test6() {
        Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'CS Case Study';
        insert requirementObject;
        
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National').getRecordTypeId();
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        //obj.cancelMethod();
        //obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    @isTest
    public static void test7() {
        Initiative__c objInit = testDataFactory();
        Id devRecordTypeId = Schema.SObjectType.Requirement_Reporting_Detail__c.getRecordTypeInfosByName().get('PI National Read Only').getRecordTypeId();

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'CS Board Diversity';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = devRecordTypeId;
        objRep.Status__c ='Completed';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqid', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(false, obj.editReport);
        //system.assertEquals(false, obj.readOnlyReport);
        Test.stopTest();
    }
    
    //testdatafactory
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
              usr=[Select Id from User where Name='Rick Smith' and email='aruna.mulik@eternussolutions.com'];
        }
        else
             usr=[Select Id from User where Name='Rick Smith' and email='rick.smith@relationshipunlimited.com'];
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
    
    //Case1: when the Requirement Reporting detail record type value at Requirement is blank
    public static testmethod void reportingNotEnabled(){
       Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
        requirementobject.Status__c = 'Overdue';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        insert requirementObject;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        system.assertEquals(false, obj.editReport);
        //system.assertEquals(true, obj.readOnlyReport);
        Test.stopTest();
    }
    
    //Case2: when the Requirement Reporting detail record type value at Requirement is Nat CS Rubric 1
    public static testmethod void reportingEnabled(){
         Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
        requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'Nat CS Rubric 1';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
       
        Test.startTest();
        obj.cancelMethod();
        obj.objReport.How_much_did_you_do__c='Test1';
        obj.objReport.How_well_did_you_do_it__c='Test2';
        obj.objReport.What_impact_did_this_have__c='Test3';
        obj.objReport.What_were_your_learnings__c ='Test4';
        obj.objReport.Value_of_Auckland__c= 5;
        obj.editReport = true;
        obj.saveMethod();
        
        List<Requirement_Reporting_Detail__c>lstRep = new List<Requirement_Reporting_Detail__c>([Select id,
                                                                                                 		Status__c
                                                                                                 from Requirement_Reporting_Detail__c
                                                                                                 Where Requirement__c =:requirementObject.id]);
        system.assertEquals(1, lstRep.size());
        system.assertEquals('Draft', lstRep[0].Status__C);
        system.assertEquals(true, obj.editReport);
        Test.stopTest();
     }
    
    //Case4: when the Requirement Reporting detail record type value at Requirement is Reg CS Rubric 2
    public static testmethod void saveWithCompleteDetails1(){
        Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
        requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'Reg CS Rubric 2';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.objReport.How_much_did_you_do__c='Test1';
        obj.objReport.How_well_did_you_do_it__c='Test2';
        obj.objReport.What_impact_did_this_have__c='Test3';
        obj.objReport.What_were_your_learnings__c ='Test4';
        obj.objReport.Value_of_Young_People__c= 5;
        obj.editReport = true;
        obj.saveMethod();
        
        List<Requirement_Reporting_Detail__c>lstRep = new List<Requirement_Reporting_Detail__c>([Select id,
                                                                                                 		Status__c
                                                                                                 from Requirement_Reporting_Detail__c
                                                                                                 Where Requirement__c =:requirementObject.id]);
        system.assertEquals(1, lstRep.size());
        system.assertEquals('Draft', lstRep[0].Status__C);
        system.assertEquals(true, obj.editReport);
        Test.stopTest();
     }
    public static testmethod void submitMethodDetails(){
        Initiative__c objInit = testDataFactory();
        // initiativeOwner= objInit[0].Initiative_Owner__c;
        List<User> usrRec=[select id,name,Email from User where Id =:objInit.Initiative_Owner__c limit 1];
         String initiativeEmail=usrRec[0].Email;
        String initiativeID=usrRec[0].id;
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI Regional'].Id;
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
		requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Draft';
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        pageRef.getParameters().put('reqId', String.valueOf(requirementObject.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        //obj.cancelMethod();
        obj.submitMethod();
         List<Requirement_Reporting_Detail__c>lstRep = new List<Requirement_Reporting_Detail__c>([Select id,
                                                                                                 		Status__c
                                                                                                 		from Requirement_Reporting_Detail__c
                                                                                                 Where Requirement__c =:requirementObject.id]);
        system.assertEquals(1, lstRep.size());
       // system.assertEquals('Submitted', lstRep[0].Status__C);
        //system.assertEquals(true, obj.readOnlyReport);
        test.stopTest();
    }
    
    
    /*Case6: when the Requirement Reporting detail record type value at Requirement is Reg CS Rubric 2 and  
    status of Requirement Reporting Detail object is updated by Internal User to Being Reviewed*/
    public static testmethod void statusUpdatedToBeingReviewed(){
        Initiative__c objInit = testDataFactory();
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'CS Regional'].Id;
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
		requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Being Reviewed';
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        obj.saveMethod();
        //system.assertEquals(true, obj.readOnlyReport);
        test.stopTest();
    }
    
    /*Case7: when the Requirement Reporting detail record type value at Requirement is Reg CS Rubric 2 and  
    status of Requirement Reporting Detail object is updated by Internal User to Need More Information*/
    public static testmethod void statusUpdatedTONeedMoreInfo(){
       Initiative__c objInit = testDataFactory();
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI Regional'].Id;
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
		requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI Regional';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.Status__c ='Draft';
        objRep.RecordTypeId = recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.cancelMethod();
        system.assertEquals(false, obj.editReport);
       // system.assertEquals(true, obj.readOnlyReport);
        List<Requirement_Reporting_Detail__c>lstRep = new List<Requirement_Reporting_Detail__c>([Select id,
                                                                                                 		Status__c,
                                                                                                 		Value_of_Young_People__c
                                                                                                 from Requirement_Reporting_Detail__c
                                                                                                 Where Requirement__c =:requirementObject.id]);
        lstRep[0].Value_of_Young_People__c = 8;
        obj.saveMethod();
        system.assertEquals(1, lstRep.size());
        Test.stopTest();
    }
    
    /*Case8: when the Requirement Reporting detail record type value at Requirement is Reg CS Rubric 2 and  
    status of Requirement Reporting Detail object is updated by Internal User to Completed*/
    public static testmethod void statusUpdatedToCompleted(){
        Initiative__c objInit = testDataFactory();
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'CS Regional'].Id;

        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
		requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'Reg CS Rubric 2';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.Status__c ='Being Reviewed';
        objRep.BD_Target_issues__c = 'Yes';
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId = recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        obj.cancelMethod();
        
        List<Requirement_Reporting_Detail__c>lstRep = new List<Requirement_Reporting_Detail__c>([Select id,
                                                                                                 		Status__c,
                                                                                                 		Value_of_Young_People__c
                                                                                                 from Requirement_Reporting_Detail__c
                                                                                                 Where Requirement__c =:requirementObject.id]);
        lstRep[0].Status__c = 'Completed';
        update lstRep;
        Test.startTest();
        List<Requirement__c>lstReq = new List<Requirement__c>([Select ID,
                                                           		   Status__c
                                                           From Requirement__c]);
        //system.assertEquals(true, obj.readOnlyReport);
        /*system.assertEquals(false, obj.enableAttachment);
        system.assertEquals(false, obj.disableAttachment);*/
        test.stopTest();
    }
    
    //Case2: when the Requirement Reporting detail record type value at Requirement is CS Case Study
    public static testmethod void testCaseStudyNameRecordType(){
         Initiative__c objInit = testDataFactory();
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
        requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'CS Case Study';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.Status__c ='Draft';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
       
        Test.startTest();
        obj.cancelMethod();
        obj.objReport.How_much_did_you_do__c='Test1';
        obj.objReport.How_well_did_you_do_it__c='Test2';
        obj.objReport.What_impact_did_this_have__c='Test3';
        obj.objReport.What_were_your_learnings__c ='Test4';
        obj.objReport.Value_of_Auckland__c= 5;
        obj.saveMethod();
        
        List<Requirement_Reporting_Detail__c>lstRep = new List<Requirement_Reporting_Detail__c>([Select id,
                                                                                                 		Status__c
                                                                                                 from Requirement_Reporting_Detail__c
                                                                                                 Where Requirement__c =:requirementObject.id]);
        system.assertEquals(1, lstRep.size());
        system.assertEquals('Draft', lstRep[0].Status__C);
        system.assertEquals(false, obj.editReport);
        Test.stopTest();
     }
        
    //Case4: when the Requirement Reporting detail record type value at Requirement is CS Board Diversity
    public static testmethod void testElseRecordType(){
         Initiative__c objInit = testDataFactory();
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
		requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'CS Board Diversity';
        insert requirementObject;
       Requirement__c requiremen=[ Select ID,
                       Name,
                       Status__c,
                       Requirement_Reporting_Record_Type__c,
                       Due_Date__c,Description__c,
                       Partner__c,CreatedDate                          
                       From Requirement__c where Status__c = 'Pending'];
        
       // Requirement__c requiremen = new Requirement__c();
        requiremen.Due_Date__c = Date.Today().addDays(-9);       
        requiremen.Status__c = 'overdue';
        update requiremen;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Requirement__c = requiremen.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.Status__c ='Draft';
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
       
        Test.startTest();
        obj.cancelMethod();
        obj.objReport.How_much_did_you_do__c='Test1';
        obj.objReport.How_well_did_you_do_it__c='Test2';
        obj.objReport.What_impact_did_this_have__c='Test3';
        obj.objReport.What_were_your_learnings__c ='Test4';
        obj.objReport.Value_of_Auckland__c= 5;
        obj.saveMethod();
        
        List<Requirement_Reporting_Detail__c>lstRep = new List<Requirement_Reporting_Detail__c>([Select id,
                                                                                                 		Status__c
                                                                                                 from Requirement_Reporting_Detail__c
                                                                                                 Where Requirement__c =:requirementObject.id]);
        system.assertEquals(1, lstRep.size());
        system.assertEquals('Draft', lstRep[0].Status__C);
        system.assertEquals(false, obj.editReport);
        Test.stopTest();
     }
       
    //Case4: when the Requirement Reporting detail record type value at Requirement is CS Board Diversity
    public static testmethod void testElse123RecordType(){
         Initiative__c objInit = testDataFactory();
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(100);       
		requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'Reg CS Rubric 2';
        insert requirementObject;
       Requirement__c requiremen=[ Select ID,
                       Name,
                       Status__c,
                       Requirement_Reporting_Record_Type__c,
                       Due_Date__c,Description__c,
                       Partner__c,CreatedDate                          
                       From Requirement__c where Status__c = 'Pending'];
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Requirement__c = requiremen.id;
        objRep.BD_Target_Met__c = 'No';
        objRep.Status__c ='Draft';
        insert objRep;
        
       // Requirement__c requiremen = new Requirement__c();
        requiremen.Due_Date__c = Date.Today().addDays(110);       
        //requiremen.Status__c = 'overdue';
        update requiremen;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
       
        Test.startTest();
        obj.cancelMethod();
        obj.objReport.How_much_did_you_do__c='Test1';
        obj.objReport.How_well_did_you_do_it__c='Test2';
        obj.objReport.What_impact_did_this_have__c='Test3';
        obj.objReport.What_were_your_learnings__c ='Test4';
        obj.objReport.Value_of_Auckland__c= 5;
        obj.saveMethod();
        
        List<Requirement_Reporting_Detail__c>lstRep = new List<Requirement_Reporting_Detail__c>([Select id,
                                                                                                 		Status__c
                                                                                                 from Requirement_Reporting_Detail__c
                                                                                                 Where Requirement__c =:requirementObject.id]);
        system.assertEquals(1, lstRep.size());
        system.assertEquals('Draft', lstRep[0].Status__C);
        system.assertEquals(false, obj.editReport);
        Test.stopTest();
     }
    
    /**/
    public static testmethod void PI_National(){
        Initiative__c objInit = testDataFactory();
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National'].Id;
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
		requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Status__c ='Draft';
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.SaveMethod();
        //system.assertEquals(true, obj.editReport);
        /*system.assertEquals(true, obj.enableAttachment);
        system.assertEquals(false, obj.disableAttachment);*/
        test.stopTest();
    }
    public static testmethod void PI_Nationalplus1(){
        Initiative__c objInit = testDataFactory();
        
        Id recID = [Select Id from RecordType where sobjectType = 'Requirement_Reporting_Detail__c' and Name = 'PI National + 1'].Id;
        
        Requirement__c requirementobject = new Requirement__c();
        requirementobject.Comments__c = 'Comments Testing the Test Class';
        requirementobject.Description__c ='Description Testing the test class';
        requirementobject.Due_Date__c = Date.Today().addDays(9);       
		requirementobject.Status__c = 'Pending';
        requirementobject.Hold_Payments__c = true;
        requirementObject.Initiative__c = objInit.Id;
        requirementObject.Requirement_Reporting_Record_Type__c = 'PI National + 1';
        insert requirementObject;
        
        Requirement_Reporting_Detail__c objRep = new Requirement_Reporting_Detail__c();
        objRep.How_much_did_you_do__c ='Test1';
        objRep.How_well_did_you_do_it__c ='Test2';
        objRep.What_impact_did_this_have__c='Test3';
        objRep.What_were_your_learnings__c = 'Test5';
        objRep.Value_of_Young_People__c = 5;
        objRep.Requirement__c = requirementObject.id;
        objRep.BD_Target_issues__c = 'Yes';
        objRep.Status__c ='Draft';
        objRep.BD_Target_Met__c = 'No';
        objRep.RecordTypeId =  recID;
        insert objRep;
        
        PageReference pageRef = Page.New_Initiative_Requirements_Measures;
        pageRef.getParameters().put('Id', String.valueOf(objInit.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(objInit);
        
        HistoricReqReportingController obj = new HistoricReqReportingController(sc);
        
        Test.startTest();
        obj.SaveMethod();
        //system.assertEquals(true, obj.editReport);
        /*system.assertEquals(true, obj.enableAttachment);
        system.assertEquals(false, obj.disableAttachment);*/
        test.stopTest();
    }
}