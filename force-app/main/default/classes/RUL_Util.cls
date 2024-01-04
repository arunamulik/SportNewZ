/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used for creation on test data for RUL implementation.
    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 18-11-2016       | Vivian Charlie   | 1. Created draft class
   ==========================================================================================================================
*/
@isTest
public class RUL_Util {

    /*
     @ Description : Method to create organisations
    */
    public static List<Account> createAccounts() {
        List<Account> accList = new List<Account>();
        for(integer i=0; i<50; i++) {
            Account accObj;
            accObj = new Account(Name = 'Test Account'+i, Type = 'Education');
            accList.add(accObj);
        }
        return accList;
    }
    
    /*
     @ Description : Method to create Contacts
    */
    public static List<Contact> createContacts() {
        List<Contact> conList = new List<Contact>();
        List<Account> accList = new List<Account>();
        accList = createAccounts();
        insert accList;
        for(integer i=0; i<50; i++){
            Contact conObj = new Contact(LastName = 'TestLastName'+i, AccountId = accList[i].Id, FirstName='TestFirstName'+i);
            conList.add(conObj);
        }
        return conList;
    }

    /*
     @ Description : Method to create Community Users in bulk for testing
    */
    public static list<User> createCommunityUsers() {
        list<User> users = new list<User>();
        List<Contact> conList = new List<Contact>();
        conList= createContacts();
        System.runAs(new User(Id = UserInfo.getUserId())) {
            insert conList;
        }
        Profile profiles = [SELECT Id,
                                   Name
                            FROM Profile
                            WHERE Name like '%Partner%' limit 1];
        Profile adminProfile = [SELECT Id,
                                       Name
                                FROM Profile
                                WHERE Name = 'System Administrator' limit 1];
        for(Integer i=0; i<50; i++) {
        if (i<20) {
            User communityUser = new User(FirstName = 'Community',
                                           LastName = 'User'+i+1,
                                           Alias = 'CU',
                                           Email = 'commTest@test.com',
                                           Username = Math.random() + '@test.com',
                                           CommunityNickname = 'cust6'+i,
                                           ContactId = conList[i].Id,
                                           EmailEncodingKey = 'UTF-8',
                                           TimeZoneSidKey = 'America/Los_Angeles',
                                           LocaleSidKey = 'en_US',
                                           LanguageLocaleKey = 'en_US',
                                           PortalRole = 'Manager',
                                           ProfileId = profiles.Id,
                                           IsActive = true);
            users.add(communityUser);
            } else {
                User communityUser = new User(FirstName = 'Community',
                                               LastName = 'User'+i+1,
                                               Alias = 'CU',
                                               Email = 'commTest@test.com',
                                               Username = Math.random() + '@test.com',
                                               CommunityNickname = 'cust6'+i,
                                               EmailEncodingKey = 'UTF-8',
                                               TimeZoneSidKey = 'America/Los_Angeles',
                                               LocaleSidKey = 'en_US',
                                               LanguageLocaleKey = 'en_US',
                                               PortalRole = 'Manager',
                                               ProfileId = adminProfile.Id,
                                               IsActive = true);
                users.add(communityUser);
            }
        }
        return users;
    }
        
    /*
     @ Description : Method to create Participation Activity Profile Data
    */
    public static List<Participation_Activity_Profile_Data__c> createPartActivities() {
        List<Account> lstAcc = new List<Account>();
        lstAcc = createAccounts();
        insert lstAcc;
        List<Participation_Activity_Profile_Data__c> partActList = new List<Participation_Activity_Profile_Data__c>();
        for(integer i=0; i<50; i++) {
            Participation_Activity_Profile_Data__c partActObj;
            partActObj = new Participation_Activity_Profile_Data__c(Name = 'Test Participation Activity Profile'+i,
                Organisation__c = lstAcc[i].id,Start_Date__c = Date.Today(), End_Date__c = Date.Today() + 10,
                Delivery_Context__c = 'Community', Percentage_of_Adults__c = 55, Percentage_of_Young_People__c = 10);
            partActList.add(partActObj);
        }
        return partActList;
    }

    /*
     @ Description : Method to create Participation Data
    */
    public static List<Participation_Data__c> createParticipations() {
        List<Participation_Activity_Profile_Data__c> partActList = new List<Participation_Activity_Profile_Data__c>();
        partActList = createPartActivities();
        insert partActList;
        List<Participation_Data__c> partList = new List<Participation_Data__c>();
        for(integer i=0; i<10; i++) {
            Participation_Data__c partObj;
            if(i<20) {
                partObj = new Participation_Data__c(Programme_Name__c = partActList[i].id, Total_Participants__c = 10, Financial_Year__c= '2016-2017',
                                                    Female_Participants__c = 10, Male_Participants__c = 10);
                partList.add(partObj);
              
            } else {
                partObj = new Participation_Data__c(Programme_Name__c = partActList[i].id, Total_Participants__c = 10,Financial_Year__c= '2016-2017',
                                                    Female_Participants__c = 10, Male_Participants__c = 10);
                partList.add(partObj);
            }
        }
         
        return partList;
    }

    /*
     @ Description : Method to create Programme and Event Data
    */
    public static List<Programme_and_Event_Data__c> createProgrammeEventData() {
        List<Account> accList = new List<Account>();
        accList = createAccounts();
        insert accList;
        List<Programme_and_Event_Data__c> progDataList = new List<Programme_and_Event_Data__c>();
        for(integer i=0; i<50; i++) {
                Programme_and_Event_Data__c progDataObj;
                progDataObj = new Programme_and_Event_Data__c(Organisation__c = accList[i].id,
                    Start_Date__c = Date.Today(), End_Date__c = Date.Today() + 10);
                progDataList.add(progDataObj);
        }
        return progDataList;
    }

    /*
     @ Description : Method to create Programme and Event Participations
    */
    public static List<Programme__c> createProgrammes() {
        List<Programme_and_Event_Data__c> progDataList = new List<Programme_and_Event_Data__c>();
        progDataList = createProgrammeEventData();
        insert progDataList;
        Set<Id> accIds = new Set<Id>();
        for(Programme_and_Event_Data__c progData: progDataList) {
            accIds.add(progData.Organisation__c);
        }
        List<Account> accList = new List<Account>([SELECT Id
                                                   FROM Account
                                                   WHERE ID in:accIds]);        
        List<Programme__c> progList = new List<Programme__c>();
        for(integer i=0; i<50; i++) {
            if(i<20) {
                Programme__c progObj;
                progObj = new Programme__c(Programme_or_Event_Name__c = progDataList[i].id, Organization_Delivered_To__c = accList[0].id,
                    Number_of_Programmes_Delivered__c = 10, Number_of_Sessions_Delivered__c = 5, Location__c = 'Local', Avg_No_of_Participants_at_Each_Session__c = 50);
                progList.add(progObj);
            } else {
                Programme__c progObj;
                progObj = new Programme__c(Programme_or_Event_Name__c = progDataList[i].id, Organization_Delivered_To__c = accList[1].id,
                    Number_of_Programmes_Delivered__c = 10, Number_of_Sessions_Delivered__c = 5, Location__c = 'Local', Avg_No_of_Participants_at_Each_Session__c = 50);
                progList.add(progObj);
            }
        }
        return progList;
    }
    
    /*
     @ Description : Method to create Course Activity Profile Data
    */
    public static List<Course_Activity_Profile_Data__c> createCourseActProData() {
        List<Account> accList = new List<Account>();
        accList = createAccounts();
        insert accList;
        List<Course_Activity_Profile_Data__c> courseList = new List<Course_Activity_Profile_Data__c>();
        for(integer i=0; i<50; i++) {
                Course_Activity_Profile_Data__c courseObj;
                courseObj = new Course_Activity_Profile_Data__c(name = 'Test Course Activity Profile Data'+i,Organization__c = accList[i].id, 
                    Course_Type__c = 'Other', Start_Date__c = Date.Today(), End_Date__c = Date.Today() + 10);
                courseList.add(courseObj);
        }        
        return courseList;
    }
    
    /*
     @ Description : Method to create Course Participation Data
    */
    public static List<Course_Participation_Data__c> createCoursePartData() {   
        List<Course_Activity_Profile_Data__c> courseList = new List<Course_Activity_Profile_Data__c>();
        courseList = createCourseActProData();
        insert courseList;
        system.debug('courseList'+courseList);
        List<Course_Participation_Data__c> coursePartList = new List<Course_Participation_Data__c>();
        for(integer i=0; i<50; i++) {
                Course_Participation_Data__c courseObj;
                courseObj = new Course_Participation_Data__c(Course__c = courseList[i].id,Total_Participants__c = 10+i);
                coursePartList.add(courseObj);
        }
        return coursePartList;
    }
    
    /*
     @ Description : Method to create Membership Numbers Category
    */
    public static List<Membership_Numbers_Category__c> createMemNosCat() {        
        List<Membership_Numbers_Category__c> memNiCatList = new List<Membership_Numbers_Category__c>();
        for(integer i=0; i<50; i++) {
                Membership_Numbers_Category__c memObj;
                memObj = new Membership_Numbers_Category__c(name = 'Test Membership NO Category'+i);
                memNiCatList.add(memObj);
        }        
        return memNiCatList;
    }
    
    /*
     @ Description : Method to create Payments
    */
    public static List<Payment__c> createPayments(Integer sizeOfList) {        
        List<Payment__c> payments = new List<Payment__c>();
        for(integer i=0; i < sizeOfList; i++) {
                Payment__c objPayment = new Payment__c();
                objPayment.Status__c = 'Draft';
                objPayment.Amount__c = 100;
                objPayment.Date__c = Date.Today();
                payments.add(objPayment);
        }
        return payments;
    }
    
    /*
     @ Description : Method to create Variations
    */
    public static List<Variation__c> createVariation() {        
        List<Variation__c> variations = new List<Variation__c>();
        for(integer i=0; i<50; i++) {
                Variation__c objVariation = new Variation__c();
                variations.add(objVariation);
        }
        return variations;
    }
    
    /*
     @ Description : Method to create Requierments
    */
    public static List<Requirement__c> createRequirements(Integer sizeOfList) {        
        List<Requirement__c> requirements = new List<Requirement__c>();
        for(integer i=0; i<sizeOfList; i++) {
                Requirement__c objRequirement = new Requirement__c();
                objRequirement.Status__c = 'Pending';
                objRequirement.Due_Date__c = Date.Today();
                objRequirement.Due_Date__c = Date.today().adddays(1);
                requirements.add(objRequirement);
        }
        return requirements;
    }
    
    /*
     @ Description : Method to create Requierments
    */
    public static List<Measure__c> createMeasures(Integer sizeOfList) {        
        List<Measure__c> measures = new List<Measure__c>();
        for(integer i=0; i<sizeOfList; i++) {
                Measure__c objMeasure = new Measure__c();
                objMeasure.Status__c = 'Partially Met';
                objMeasure.Result_Date__c = Date.Today().addDays(20);
                measures.add(objMeasure);
        }
        return measures;
    }
    
    /*
     @ Description : Method to create Initiatives
    */
    public static List<Initiative__c> createInitiative(Integer sizeOfList) {        
        List<Initiative__c> initiatives = new List<Initiative__c>();
        for(integer i=0; i<sizeOfList; i++) {
                Initiative__c objInitiative = new Initiative__c();
                objInitiative.Name = 'Test Initiative '+i;
                objInitiative.Start_Date__c = Date.Today();
                objInitiative.End_Date__c = Date.Today().addDays(45);
                objInitiative.Initiative_Owner__c = UserInfo.getUserId();
                objInitiative.Planned__c = 10000000;
                objInitiative.Priority__c = 'Must';
                objInitiative.Type__c = 'Paid Direct';
                initiatives.add(objInitiative);
        }
        return initiatives;
    }
    
    /*
     @ Description : Method to create Investment Schedule
    */
    public static Business_Case__c createInvestmentSchedule() {
        Business_Case__c objInvestmentSchedule = new Business_Case__c();
        objInvestmentSchedule.Name = 'RUL Investment Schedule';
        objInvestmentSchedule.Approval_Type__c = 'Manager Delegation';
        return objInvestmentSchedule;
    }
}