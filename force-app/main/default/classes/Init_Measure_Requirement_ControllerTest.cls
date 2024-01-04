/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Initiative Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 16-12-2016       | Vivian Charlie   | 1. Created test class to test functionality of Initiative Requirement 
                                                           Measure Page
   ==========================================================================================================================
*/
@isTest
private class Init_Measure_Requirement_ControllerTest {
    /*
     @ Description : Method to insert Initiative
    */
    public static testMethod void testInitiativeMeasuresReq() {
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
        system.debug('acc'+acc);
        Profile profiles = [SELECT Id,
                                   Name
                            FROM Profile
                            WHERE Name like '%Partner%' limit 1];
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
            planObj.End_Date__c = Date.Today()+i;
            planObj.Start_Date__c = Date.Today();
            planList.add(planObj);
        }
        insert planList;
        
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
            initObj.End_Date__c = Date.Today();
            initObj.Start_Date__c = Date.Today();
            initObj.Partner__c = acc.id;
            initList.add(initObj);
        }
        insert initList;
        system.debug('initList'+initList);
        
        list<Measure__c> measuresList = new list<Measure__c>();
        for(Integer i=0; i<50; i++) {
            Measure__c measObj = new Measure__c();
            measObj.name = 'Test Measure'+i;
            measObj.Reporting_Type__c = 'Written';
            measObj.Description__c = acc.id;
            measObj.Partner__c = acc.id;
            measObj.Initiative__c = initList[i].id;
            measuresList.add(measObj);
        }
        insert measuresList;
        system.debug('measuresList'+measuresList);
        
        list<Requirement__c> reqList = new list<Requirement__c>();
        for(Integer i=0; i<50; i++) {
            Requirement__c reqObj = new Requirement__c();
            reqObj.name = 'Test Requirement'+i;
            reqObj.Reporting_Type__c = 'Written';
            reqObj.Description__c = acc.id;
            reqObj.Partner__c = acc.id;
            reqObj.Initiative__c = initList[i].id;
            reqList.add(reqObj);
        }
        insert reqList;
        system.debug('reqList'+reqList);
        
        user usr= [Select id,contactId ,contact.accountId from User where contactId =: communityUser.ContactId and UserRoleId != NULL and IsActive =true limit 1];
        system.debug(loggingLevel.error,'usr'+usr);
        
        system.runAs(usr) {            
            ApexPages.StandardController sc= new ApexPages.StandardController(initList[0]);
            
            Initiative_MeasureController MeasureController = new Initiative_MeasureController(sc);
            MeasureController.getMeasures();
            MeasureController.next1();
            MeasureController.previous1();
            MeasureController.last1();
            MeasureController.first1();
            boolean nextMeas = MeasureController.hasNext1;
            boolean prevMeas = MeasureController.hasPrevious1;
            
            Initiative_RequirementController ReqController = new Initiative_RequirementController(sc);
            ReqController.getRequirements();
            ReqController.next();
            ReqController.previous();
            ReqController.last();
            ReqController.first();
            boolean nextReq = ReqController.hasNext;
            boolean prevReq = ReqController.hasPrevious;
                                      
            list<Measure__c> lstMeas = new list<Measure__c>([SELECT Id
                                                             FROM Measure__c
                                                             WHERE Partner__c =:acc.Id AND Initiative__c IN:initList]);
            list<Requirement__c> lstRequi = new list<Requirement__c>([SELECT Id
                                                                      FROM Requirement__c
                                                                      WHERE Partner__c =:acc.Id AND Initiative__c IN:initList]);                                                 
            /*
            system.assertEquals(lstMeas.size(),MeasureController.measureList.size());
            system.assertEquals(lstMeas.size(),ReqController.reqList.size());
            */
        }
    }
}