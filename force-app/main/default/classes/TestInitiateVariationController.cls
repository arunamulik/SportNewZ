@isTest
public class TestInitiateVariationController {
    /*@isTest
    public static void testMethod1(){
        Business_Case__c businessCaseObject = new Business_Case__c();
        //businessCaseObject.RecordTypeId = businessCaseRecordTypeId;
        businessCaseObject.Name = 'Test Business Case';
        //businessCaseObject.Investment_Area__c = investmentAreaObject.id;
        businessCaseObject.Approval_Type__c = 'Manager Delegation';
        businessCaseObject.Status__c = 'Approved';
        businessCaseObject.T_Cs__c ='Rural Travel Fund T&C';
        insert businessCaseObject;
        
         Variation__c objVar = new Variation__c();
        objVar.Comments__c = 'Test';
        objVar.Investment_Schedule__c = businessCaseObject.Id;
        insert objVar;
        Test.StartTest(); 
        //Test.setCurrentPageReference(new PageReference('Page.VariationCreationPage'));
        //ApexPages.StandardController controllerer = new ApexPages.standardController(businessCaseObject.id);
        //InitiateVariatonController testClass= new InitiateVariatonController(controllerer);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(businessCaseObject);
        InitiateVariatonController testClass= new InitiateVariatonController(sc);
        
        PageReference pageRef = Page.VariationCreationPage;
        pageRef.getParameters().put('id', businessCaseObject.Id);
        Test.setCurrentPage(pageRef);
       
        
        testClass.getoptns();
        testClass.insertVariation();
        testClass.cancelVariation();
        //testClass.function1Name();
        
        //testClass.function2Name();

        Test.StopTest();
    }*/
   /* @IsTest
    public static void testMethod1() {
        Variation__c obj = new Variation__c();

        Business_Case__c ivs = new Business_Case__c();
        ivs.Name = 'RUL Test INVS';
        ivs.Approval_Tpe__c = 'Manager Delegation';
        ivs.Status__c = 'Approved';
        insert ivs;

        PageReference pg = Page.VariationCreationPage;
        pg.getParameters().put('retURL','/'+ivs.Id );
        Test.setCurrentPage(pg);
        //Test.setCurrentPageReference( Page.PageName);
      System.currentPageReference().getParameters().put('id', ivs.Id);

        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        InitiateVariatonController controller = new InitiateVariatonController(sc);
        controller.isID = ivs.Id;
        controller.purpose = 'Remove the obligations and commitments of an Initiative';
        controller.comments = 'Test Class Comments';

        test.startTest();
            controller.insertVariation();
            controller.cancelVariation();
            controller.getoptns();
        //controller.NextButtonMethod();
        test.stopTest();

        List<Variation__c> varRecList = [Select Id, Comments__c From Variation__c Where Investment_Schedule__c =:ivs.Id ];
        system.assertEquals(varRecList.size(),1);
        system.assertEquals(varRecList[0].Comments__c,'Test Class Comments');
      }
*/ @isTest
     public static void testMethod2() {
        Variation__c obj = new Variation__c();

        Business_Case__c ivs = new Business_Case__c();
        ivs.Name = 'RUL Test INVS';
        ivs.Approval_Type__c = 'Manager Delegation';
        ivs.Status__c = 'Being Varied';
        insert ivs;
         
         /*IsVariationInititated__c obj1 = new IsVariationInititated__c();
		 obj1.Name = 'test';
         insert obj1;*/
         //ID profileID = [Select ID from Profile where Name = 'Kahiwi' Limit 1].id;
         insert new IsVariationInititated__c(SetupOwnerId=UserInfo.getProfileId(), Variation_Inititated__c=true);
         
         //system.debug()
         
		//IsVariationInititated__c.Variation_Inititated__c = false;
         //IsVariationInititated__c.id =mcs[0].id; 

        PageReference pg = Page.VariationCreationPage;
        pg.getParameters().put('retURL','/'+ivs.Id );
        Test.setCurrentPage(pg);
        //Test.setCurrentPageReference( Page.PageName);
      System.currentPageReference().getParameters().put('id', ivs.Id);

        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        InitiateVariatonController controller = new InitiateVariatonController(sc);
        controller.isID = ivs.Id;
        controller.purpose = 'Remove the obligations and commitments of an Initiative';
        controller.comments = 'Test Class Comments';

        test.startTest();
            controller.insertVariation();
            controller.cancelVariation();
           // controller.getoptns();
       // controller.NextButtonMethod();
        test.stopTest();

        List<Variation__c> varRecList = [Select Id, Comments__c From Variation__c Where Investment_Schedule__c =:ivs.Id ];
        system.assertEquals(varRecList.size(),1);
        system.assertEquals(varRecList[0].Comments__c,'Test Class Comments');
      }
    
     @IsTest
    public static void testMethod3() {
        Variation__c obj = new Variation__c();

        Business_Case__c ivs = new Business_Case__c();
        ivs.Name = 'RUL Test INVS';
        ivs.Approval_Type__c = 'Manager Delegation';
        ivs.Status__c = 'Approved';
        insert ivs;

        PageReference pg = Page.VariationCreationPage;
        pg.getParameters().put('retURL','/'+ivs.Id );
        Test.setCurrentPage(pg);
        //Test.setCurrentPageReference( Page.PageName);
      System.currentPageReference().getParameters().put('id', ivs.Id);
	insert new IsVariationInititated__c(SetupOwnerId=UserInfo.getProfileId(), Variation_Inititated__c=true);
        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        InitiateVariatonController controller = new InitiateVariatonController(sc);
        controller.isID = ivs.Id;
        controller.purpose = 'Remove the obligations and commitments of an Initiative';
        controller.comments = 'Test Class Comments';

        test.startTest();
            controller.insertVariation();
            controller.cancelVariation();
          //  controller.getoptns();
        //controller.NextButtonMethod();
        test.stopTest();

        List<Variation__c> varRecList = [Select Id, Comments__c From Variation__c Where Investment_Schedule__c =:ivs.Id ];
        system.assertEquals(varRecList.size(),1);
        system.assertEquals(varRecList[0].Comments__c,'Test Class Comments');
      }

     public static void testMethod4() {
        Variation__c obj = new Variation__c();

        Business_Case__c ivs = new Business_Case__c();
        ivs.Name = 'RUL Test INVS';
        ivs.Approval_Type__c = 'Manager Delegation';
        ivs.Status__c = 'Being Varied';
        insert ivs;

        PageReference pg = Page.VariationCreationPage;
        pg.getParameters().put('retURL','/'+ivs.Id );
        Test.setCurrentPage(pg);
        //Test.setCurrentPageReference( Page.PageName);
      System.currentPageReference().getParameters().put('id', ivs.Id);

        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        InitiateVariatonController controller = new InitiateVariatonController(sc);
        controller.isID = ivs.Id;
        controller.purpose = 'Remove the obligations and commitments of an Initiative';
        controller.comments = 'Test Class Comments';

        test.startTest();
            controller.insertVariation();
            controller.cancelVariation();
          //  controller.getoptns();
       // controller.NextButtonMethod();
        test.stopTest();

        List<Variation__c> varRecList = [Select Id, Comments__c From Variation__c Where Investment_Schedule__c =:ivs.Id ];
        system.assertEquals(varRecList.size(),1);
        system.assertEquals(varRecList[0].Comments__c,'Test Class Comments');
      }

}