@isTest
public class changeToStrategicAreaOwnerTiggerTest {

    static testMethod void sAreaOwnerChangeTest() {
       
       Test.startTest();
       
           Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
           User usr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='rajput', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, 
                            TimeZoneSidKey='America/Los_Angeles', UserName='Testuser@davanti.com');
           insert usr;
                            
           User usr1 = new User(Alias = 'standt1', Email='standarduser1@testorg.com', 
                            	EmailEncodingKey='UTF-8', LastName='john', LanguageLocaleKey='en_US', 
                            	LocaleSidKey='en_US', ProfileId = p.Id, 
                            	TimeZoneSidKey='America/Los_Angeles', UserName='Testuser121@davanti.com'); 
           
           insert usr1;
                            	
           Strategic_Area__c sArea = new Strategic_Area__c();
           
           sArea.Name = 'Wellington';
           sArea.Entity__c = 'Sportz Anz';
           sArea.Status__c = 'Draft';
           sArea.Start_Date__c = system.Today();
           sArea.End_Date__c = system.Today().addDays(2);
           
           insert sArea;
        	
        	
        
        	/*List<Strategic_Area__c> newsArea =new List<Strategic_Area__c>();
        	newsArea=[select id from Strategic_Area__c];
        	for(Strategic_Area__c st : newsArea)
            {
                st.OwnerId=usr1.Id;
                update st;
            }*/
           
           Investment_Area__c iArea = new Investment_Area__c();
           iArea.Name = 'Davanti';
           iArea.Strategic_Area__c = sArea.Id;
           iArea.Status__c = 'Draft';
           iArea.Start_Date__c = system.Today();
           iArea.End_Date__c = system.Today().addDays(2);
           iArea.Investment_Area_Owner__c = usr.Id;
           
           insert iArea;
           
           Business_Case__c bCase = new Business_Case__c();
           bCase.Strategic_Area__c = sArea.Id;
           bCase.Name = 'Invesrment Schedule 1';
           bCase.Status__c = 'Draft';
           bCase.Strategic_Area_Owner__c = UserInfo.getUserId();
           bCase.Approval_Type__c ='Manager Delegation';
           bCase.Investment_Area__c = iArea.Id;
           
           insert bCase;
           
           //sArea.ownerId = usr1.Id;
            sArea.Name = 'Wellington1';
           update sArea;
           
       Test.stopTest();
       
     }
     
     
     
}