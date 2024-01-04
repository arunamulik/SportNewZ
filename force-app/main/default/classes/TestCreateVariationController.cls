@isTest
public class TestCreateVariationController {
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
    @IsTest
    public static void testMethod1() {
        Variation__c obj = new Variation__c();

        Business_Case__c ivs = new Business_Case__c();
        ivs.Name = 'RUL Test INVS';
        ivs.Approval_Type__c = 'Manager Delegation';
        ivs.Status__c = 'Approved';
        insert ivs;

        PageReference pg = Page.CreateVariationPage;
        pg.getParameters().put('retURL','/'+ivs.Id );
        Test.setCurrentPage(pg);
        //Test.setCurrentPageReference( Page.PageName);
      System.currentPageReference().getParameters().put('id', ivs.Id);

        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        CreateVariatonController controller = new CreateVariatonController(sc);
        Business_Case__c objInv = [Select ID from Business_Case__c Where ID =:ivs.Id Limit 1];
        controller.isID = objInv.Id;
        controller.purpose = 'Remove the obligations and commitments of an Initiative';
        controller.comments = 'Test Class Comments';

        test.startTest();
            controller.insertVariation();
            controller.cancelVariation();
           // controller.getoptns();
        //controller.NextButtonMethod();
        test.stopTest();

        List<Variation__c> varRecList = [Select Id, Comments__c From Variation__c Where Investment_Schedule__c =:ivs.Id ];
        system.assertEquals(varRecList.size(),1);
        system.assertEquals(varRecList[0].Comments__c,'Test Class Comments');
      }
	@isTest
     public static void testMethod2() {
        Variation__c obj = new Variation__c();

        Business_Case__c ivs = new Business_Case__c();
        ivs.Name = 'RUL Test INVS';
        ivs.Approval_Type__c = 'Manager Delegation';
        ivs.Status__c = 'Being Varied';
        insert ivs;

        PageReference pg = Page.CreateVariationPage;
        pg.getParameters().put('retURL','/'+ivs.Id );
        Test.setCurrentPage(pg);
        //Test.setCurrentPageReference( Page.PageName);
      System.currentPageReference().getParameters().put('id', ivs.Id);

        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        CreateVariatonController controller = new CreateVariatonController(sc);
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
   
}