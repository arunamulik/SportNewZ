@isTest
public class TestClassForDedupeRequirement {
	
     @testSetup static void setup(){
         
         Strategic_Area__c sa=new Strategic_Area__c(Name='Test1SA',Entity__c='Sport NZ',Start_Date__c=Date.newInstance(2015,8,8),End_Date__c=Date.newInstance(2021,12,12));
        insert sa;
         
         Business_Case__c busi=new 	Business_Case__c(Name='TestInvestment TesttClassRecord',Status__c='Draft', Strategic_Area__c = sa.Id);
        insert busi;
        
        Account org=new Account(Name='Test1Org',Type='Supplier');
        insert org;
        
        Work_Brief__c wf=new Work_Brief__c(Work_Brief_Name__c='Test1wf',Name='5742',Stage__c='Active');
        insert wf;
        
        Activity_ID__c actid=new  Activity_ID__c(Name='TestClass Act');
        insert actid;
        
        Project_ID__c proid= new Project_ID__c(Name='TestClass Project');
        insert proid;
        
        Plan__c pl=new Plan__c(Partner__c=org.Id,Status__c='Draft',Start_Date__c=Date.newInstance(2020, 10, 1),End_Date__c=Date.newInstance(2021, 12, 25));
        insert pl;
        
        
        
        Investment_Area__c ia=new Investment_Area__c(Name='Test1IA',Status__c='Active',Investment_Area_Owner__c='0056F00000CkUzyQAF',Strategic_Area__c=sa.Id,Start_Date__c=Date.newInstance(2021,8,8),End_Date__c=Date.newInstance(2021,12,12));
        insert ia;
        
        Initiative__c ini= new Initiative__c(
        RecordTypeId='01290000000mWNJAA2',
        Name='TestInitiative23',
        Planned__c=800,
        Business_Case__c=busi.Id,
        Investment_Area__c=ia.Id,
        Plan__c=pl.id,
        Start_Date__c=Date.newInstance(2021, 10, 20),
        End_Date__c=Date.newInstance(2021, 11, 23),
        Initiative_Owner__c='0056F00000CkUzyQAF',
        Close_the_Initiative__c=true,
        Priority__c='Could',
        Type__c='Paid Direct',
        Work_Brief__c=wf.id,
        Partner__c=org.Id
        //ActivityID__c=actid.id,
        //Project_ID__c=proid.id 
        );
         System.debug('Status Field***'+ini.Status__c);
        insert ini;
		         
         Requirement__c req=new Requirement__c();
        req.Initiative__c=ini.Id;
         req.RecordTypeId='01290000000mWNWAA2';
         req.Name='TestName';
         req.Status__c='Pending';
         req.Due_Date__c=Date.newInstance(2021, 11, 23);
         req.Description__c='Testing';
         insert req;
        
         
         
         system.debug('INitiative planned****'+ini.Planned__c);
      
        
         
     	RequirementInitiative__c ri=new RequirementInitiative__c();   
         ri.Initiative__c=ini.Id;
         ri.Requirement__c=req.Id;
         ri.Due_Date__c=req.Due_Date__c;
         ri.Requirement_Name__c=req.Name;
         ri.Status__c=req.Status__c;
         insert ri;
      
     }
    
    public static TestMethod void checkClass(){
    	
        Test.startTest();
    	List<RequirementInitiative__c> rilist=new List<RequirementInitiative__c>();
        List<List<RequirementInitiative__c>> listoflist=new List<List<RequirementInitiative__c>>();
        
        List<RequirementInitiative__c> looplist=new List<RequirementInitiative__c>();
          
        
        looplist=[select id,Name,Initiative__c,	Requirement_Name__c,Due_Date__c,Status__c from RequirementInitiative__c];
      
      	System.debug('Looplist**'+looplist);
        for(RequirementInitiative__c r:looplist)
        {
            rilist.add(r);
            listoflist.add(rilist);
        }
        
        DedupeRequirements.getDedupedRequirements(listoflist);
        
        Test.stopTest();
    }
    
    
    
    public static TestMethod void checkClass2(){
    	
        Test.startTest();
    	List<RequirementInitiative__c> rilist=new List<RequirementInitiative__c>();
        List<List<RequirementInitiative__c>> listoflist=new List<List<RequirementInitiative__c>>();
        
        List<RequirementInitiative__c> looplist=new List<RequirementInitiative__c>();
         
        Requirement__c req1=new Requirement__c();
        
         req1.RecordTypeId='01290000000mWNWAA2';
        
         req1.Name='TestName1';
         req1.Status__c='Pending';
         req1.Due_Date__c=Date.newInstance(2021, 11, 22);
         req1.Description__c='Testing1';
        
        
        RequirementInitiative__c ri1=new RequirementInitiative__c();
    	ri1.Due_Date__c=DAte.newInstance(2015, 11, 25);
        ri1.Status__c='Completed';
        ri1.Requirement_Name__c=req1.Name;
        
        System.debug('RI1***'+ri1);
        RequirementInitiative__c ri2=new RequirementInitiative__c();
    	ri2.Due_Date__c=DAte.newInstance(2019, 1, 25);
        ri2.Status__c='Completed';
        //ri2.Requirement__c=req.Name;
        
        looplist.add(ri1);
        looplist.add(ri2);
      	System.debug('Looplist**'+looplist);
        for(RequirementInitiative__c r:looplist)
        {
            rilist.add(r);
            listoflist.add(rilist);
        }
        
        DedupeRequirements.getDedupedRequirements(listoflist);
        
        Test.stopTest();
    }
    
    
    public static TestMethod void ReqcheckClass(){
    
        Test.startTest();
        
        List<RequirementInitiative__c> rilist=new List<RequirementInitiative__c>();
        List<List<RequirementInitiative__c>> listoflist=new List<List<RequirementInitiative__c>>();
        
        List<RequirementInitiative__c> looplist=new List<RequirementInitiative__c>();
        
    	Requirement__c req1=new Requirement__c();
        
         req1.RecordTypeId='01290000000mWNWAA2';
        
         req1.Name='TestName';
         req1.Status__c='Pending';

         req1.Description__c='Testing1';
        
        RequirementInitiative__c ri1=new RequirementInitiative__c();
    	ri1.Due_Date__c=DAte.newInstance(2019, 5, 30);
        ri1.Status__c='Completed';
        ri1.Requirement_Name__c=req1.Name;
        
        RequirementInitiative__c ri2=new RequirementInitiative__c();
    	ri2.Due_Date__c=DAte.newInstance(2009, 8, 3);
        ri2.Status__c='Completed';
        ri2.Requirement_Name__c=req1.Name;
        
        looplist.add(ri1);
        looplist.add(ri2);
        
        for(RequirementInitiative__c r:looplist)
        {
            rilist.add(r);
            listoflist.add(rilist);
        }
        
        
        DedupeRequirements.getDedupedRequirements(listoflist);
        
        Test.stopTest();
    }
    
    public static TestMethod void ReqiNVcheckClass(){
    
        Test.startTest();
        
        List<Initiative__c> rilist=new List<Initiative__c>();
        List<List<Initiative__c>> listoflist=new List<List<Initiative__c>>();
        
        List<Initiative__c> looplist=[SELECT Id FROM Initiative__c];
        
        
        for(Initiative__c r:looplist)
        {
            rilist.add(r);
            listoflist.add(rilist);
        }
        
        
        LoopOverInitiative.getDedupedRequirements(listoflist);
        
        Test.stopTest();
    }
    
    static testMethod void getDedupedPaymentsTest() {
     
          
               
               //Record Types
        Id investmentAreaStandardInvestmentRecordTypeId = [Select Id from RecordType where sobjectType = 'Investment_Area__c' and Name = 'Standard Investment'].Id;
        Id businessCaseRecordTypeId = [Select Id from RecordType where sobjectType = 'Business_Case__c' and Name = 'Investment Schedule'].Id;     
        
        //Profile
        Id sportNZProfile = [Select Id from Profile where Name ='Kahiwi'].Id;
     
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
        Test.startTest();
        
        List<RequirementInitiative__c> rilist=new List<RequirementInitiative__c>();
        List<List<RequirementInitiative__c>> listoflist=new List<List<RequirementInitiative__c>>();
        
        List<RequirementInitiative__c> looplist=new List<RequirementInitiative__c>();
        
    	Requirement__c req1=new Requirement__c();
        
         req1.RecordTypeId='01290000000mWNWAA2';
        
         req1.Name='TestName';
         req1.Status__c='Pending';

         req1.Description__c='Testing1';
        
        RequirementInitiative__c ri1=new RequirementInitiative__c();
    	ri1.Due_Date__c=DAte.newInstance(2019, 5, 30);
        ri1.Initiative__c = initiatives[0].Id;
        ri1.Status__c='Completed';
        ri1.Requirement_Name__c=req1.Name;
        
        RequirementInitiative__c ri2=new RequirementInitiative__c();
    	ri2.Due_Date__c=DAte.newInstance(2009, 8, 3);
        ri2.Status__c='Completed';
        ri2.Initiative__c = initiatives[0].Id;
        ri2.Requirement_Name__c=req1.Name;
        
        looplist.add(ri1);
        looplist.add(ri2);
        
        for(RequirementInitiative__c r:looplist)
        {
            rilist.add(r);
            listoflist.add(rilist);
        }
        
        
        DedupeRequirements.getDedupedRequirements(listoflist);
        
        Test.stopTest();
    }
    
    
    
}