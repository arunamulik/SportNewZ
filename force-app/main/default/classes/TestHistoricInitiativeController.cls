/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Historic Page

=========================================================================================================================
Version | Date(DD-MM-YYYY) | Last Modified By | Comments
-------------------------------------------------------------------------------------------------------------------------
1.0     | 31-03-2022       | Aruna Mulik   | 1. Created test class to test functionality of Historic Page
==========================================================================================================================
*/
@isTest
private class TestHistoricInitiativeController  {
/*
@ Description : Method to insert Initiative
*/
    public static testMethod void testInitiativeAccessToPartners() {
        //Creating test data
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test Work';
        workObj.Stage__c = 'Active';
        insert workObj;
        list<Strategic_Area__c> stratAreaList = new list<Strategic_Area__c>();
        for(Integer i=0; i<50; i++) {
            Strategic_Area__c sratObj = new Strategic_Area__c();
            sratObj.name = 'Test Strategic Area'+i;
            sratObj.Entity__c = 'Sport NZ';
            sratObj.End_Date__c = Date.Today()+i;
            sratObj.Start_Date__c = Date.Today();
            stratAreaList.add(sratObj);
        }
        insert stratAreaList;
        
        Account acc = new Account(name='TestAcc');
        insert acc;
        
        Profile profiles = [SELECT Id,
                            Name
                            FROM Profile
                            WHERE Name = 'Disability Community (Partner)' limit 1];
        Contact con= new Contact(LastName = 'TestCon',AccountId = acc.id);
        insert con;        
        
        User communityUser = new User(FirstName = 'Community',
                                      LastName = 'User'+1,
                                      Alias = 'CU',
                                      Email = 'commTest@test.com',
                                      Username = Math.random() + '@test.com',
                                      CommunityNickname = 'cust6',
                                      ContactId = con.Id,
                                      EmailEncodingKey = 'UTF-8',
                                      TimeZoneSidKey = 'America/Los_Angeles',
                                      LocaleSidKey = 'en_US',
                                      LanguageLocaleKey = 'en_US',
                                      PortalRole = 'Manager',
                                      ProfileId = profiles.Id,
                                      IsActive = true);      
        insert communityUser;
        
        list<Investment_Area__c> invAreaList = new list<Investment_Area__c>();
        for(Integer i=0; i<50; i++) {
            Investment_Area__c invObj = new Investment_Area__c();
            invObj.name = 'Test Investment Area'+i;
            invObj.Status__c = 'Active';
            invObj.End_Date__c = Date.Today()+i;
            invObj.Start_Date__c = Date.Today();
            invObj.Strategic_Area__c = stratAreaList[i].id;
            invObj.Investment_Area_Owner__c = communityUser.id;
            invAreaList.add(invObj);
        }
        insert invAreaList;
        
        list<Plan__c> planList = new list<Plan__c>();
        for(Integer i=0; i<50; i++) {
            Plan__c planObj = new Plan__c();
            planObj.Partner__c = acc.id;
            planObj.Status__c = 'Active';
            planObj.End_Date__c = Date.newInstance(2099, 06 ,30);
            planObj.Start_Date__c = Date.newInstance(2013, 01 ,01);
            planList.add(planObj);
        }
        insert planList;
        
        user usr= [Select id,contactId ,contact.accountId from User where contactId =: communityUser.ContactId and UserRoleId != NULL and IsActive =true limit 1];
        
        //system.runAs(usr) { 
            list<Initiative__c> initList = new list<Initiative__c>();
            for(Integer i=0; i<50; i++) {
                Initiative__c initObj = new Initiative__c();
                initObj.name = 'Test Initiative'+i;
                initObj.Investment_Area__c = invAreaList[0].id;
                initObj.Plan__c = planList[0].id;
                initObj.Initiative_Owner__c = communityUser.id;
                initObj.Priority__c = 'Must';
                initObj.Type__c = 'Paid Direct';           
                initObj.Planned__c = 200;
                initObj.Work_Brief__c = workObj.Id;
                initObj.End_Date__c = Date.Today().addYears(1);
                initObj.Start_Date__c = Date.Today();
                initObj.Partner__c = acc.id;
                initList.add(initObj);
            }
            insert initList;
            
            list<Requirement__c> reqList = new list<Requirement__c>();
            for(Integer i=0; i<50; i++) {
                Requirement__c reqObj = new Requirement__c();
                reqObj.name = 'Test Requirement'+i;
                reqObj.Reporting_Type__c = 'Written';
                reqObj.Description__c = 'Test Desc';
                reqObj.Partner__c = acc.id;
                reqObj.Due_Date__c = Date.Today()+10;
                reqObj.Initiative__c = initList[i].id;
                reqObj.Requirement_Reporting_Record_Type__c = 'CS Board Diversity';
                reqList.add(reqObj);
            }
            insert reqList;
            
            ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(initList);
            
            HistoricInitiativeController controller = new HistoricInitiativeController();
            controller.getInitiatives();
            controller.next();
            controller.previous();
            controller.last();
            controller.first();
            boolean test1 = controller.hasNext;
            boolean test2 = controller.hasPrevious;
            
            list<Initiative__c> lstInit = new list<Initiative__c>([SELECT Id,
                                                                   Name, 
                                                                   Partner__c,
                                                                   Start_Date__c,
                                                                   End_Date__c,
                                                                   (Select Reporting_Type__c,Initiative__c From Requirements__r where Requirement_Reporting_Record_Type__c != NULL)
                                                                   FROM Initiative__c]);
            system.assertEquals(50,lstInit.size());
        //}
    }
    /*
@ Description : Method to insert Initiative whose related Requirement has Reporting Record type as blank values
*/
    public static testMethod void testInitiativeWithoutReportingType() {
        //Creating test data
        list<Strategic_Area__c> stratAreaList = new list<Strategic_Area__c>();
        for(Integer i=0; i<50; i++) {
            Strategic_Area__c sratObj = new Strategic_Area__c();
            sratObj.name = 'Test Strategic Area'+i;
            sratObj.Entity__c = 'Sport NZ';
            sratObj.End_Date__c = Date.Today()+i;
            sratObj.Start_Date__c = Date.Today();
            stratAreaList.add(sratObj);
        }
        insert stratAreaList;
        
        Account acc = new Account(name='TestAcc');
        insert acc;
        
        Profile profiles = [SELECT Id,
                            Name
                            FROM Profile
                            WHERE Name = 'Disability Community (Partner)' limit 1];
        
        Contact con= new Contact(LastName = 'TestCon',AccountId = acc.id);
        insert con;        
        
        User communityUser = new User(FirstName = 'Community',
                                      LastName = 'User'+1,
                                      Alias = 'CU',
                                      Email = 'commTest@test.com',
                                      Username = Math.random() + '@test.com',
                                      CommunityNickname = 'cust6',
                                      ContactId = con.Id,
                                      EmailEncodingKey = 'UTF-8',
                                      TimeZoneSidKey = 'America/Los_Angeles',
                                      LocaleSidKey = 'en_US',
                                      LanguageLocaleKey = 'en_US',
                                      PortalRole = 'Manager',
                                      ProfileId = profiles.Id,
                                      IsActive = true);      
        insert communityUser;
        
        list<Investment_Area__c> invAreaList = new list<Investment_Area__c>();
        
        for(Integer i=0; i<50; i++) {
            Investment_Area__c invObj = new Investment_Area__c();
            invObj.name = 'Test Investment Area'+i;
            invObj.Status__c = 'Active';
            invObj.End_Date__c = Date.Today()+i;
            invObj.Start_Date__c = Date.Today();
            invObj.Strategic_Area__c = stratAreaList[i].id;
            invObj.Investment_Area_Owner__c = communityUser.id;
            invAreaList.add(invObj);
        }
        insert invAreaList;
        
        list<Plan__c> planList = new list<Plan__c>();
        for(Integer i=0; i<50; i++) {
            Plan__c planObj = new Plan__c();
            planObj.Partner__c = acc.id;
            planObj.Status__c = 'Active';
            planObj.End_Date__c = Date.newInstance(2099, 06 ,30);
            planObj.Start_Date__c = Date.newInstance(2013, 01 ,01);
            planList.add(planObj);
        }
        insert planList;
        
        user usr= [Select id,contactId ,contact.accountId from User where contactId =: communityUser.ContactId and UserRoleId != NULL and IsActive =true limit 1];
        
        Work_Brief__c workObj = new Work_Brief__c();
        workObj.Name = 'Test Work';
        workObj.Stage__c = 'Active';
        insert workObj;
        
        //system.runAs(usr) { 
            list<Initiative__c> initList = new list<Initiative__c>();
            for(Integer i=0; i<50; i++) {
                Initiative__c initObj = new Initiative__c();
                initObj.name = 'Test Initiative'+i;
                initObj.Investment_Area__c = invAreaList[0].id;
                initObj.Plan__c = planList[0].id;
                initObj.Initiative_Owner__c = communityUser.id;
                initObj.Priority__c = 'Must';
                initObj.Type__c = 'Paid Direct';           
                initObj.Planned__c = 200;
                initObj.Work_Brief__c = workObj.Id;
                initObj.End_Date__c = Date.Today().addYears(1);
                initObj.Start_Date__c = Date.Today();
                initObj.Partner__c = acc.id;
                initList.add(initObj);
            }
            insert initList;
            
            list<Requirement__c> reqList = new list<Requirement__c>();
            for(Integer i=0; i<50; i++) {
                Requirement__c reqObj = new Requirement__c();
                reqObj.name = 'Test Requirement'+i;
                reqObj.Reporting_Type__c = 'Written';
                reqObj.Description__c = 'Test Desc';
                reqObj.Partner__c = acc.id;
                reqObj.Due_Date__c = Date.Today()+10;
                reqObj.Initiative__c = initList[i].id;
                reqList.add(reqObj);
            }
            insert reqList;
            
            ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(initList);
            
            HistoricInitiativeController controller = new HistoricInitiativeController();
            controller.getInitiatives();
            controller.next();
            controller.previous();
            controller.last();
            controller.first();
            boolean test1 = controller.hasNext;
            boolean test2 = controller.hasPrevious;
            
            list<Initiative__c> lstInit = new list<Initiative__c>([SELECT Id,
                                                                   Name, 
                                                                   Partner__c,
                                                                   Start_Date__c,
                                                                   End_Date__c,
                                                                   (Select Reporting_Type__c,Initiative__c From Requirements__r where Requirement_Reporting_Record_Type__c != NULL)
                                                                   FROM Initiative__c]);
            List <Requirement__c> listReq = new List<Requirement__c>();
            for(Initiative__c objInit : lstInit ){
                for(Requirement__c objReq : objInit.Requirements__r){
                    listReq.add(objReq);
                }
            }
            system.assertEquals(0,listReq.size());
       // }
    }
}