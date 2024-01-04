@isTest
public class TestSubscriberTrigger {
   

    @isTest
    public static void testbeforeInsertFunction(){
         subscriber__c subObj=new subscriber__c();
        subObj.First_Name__c='testSubbeforeInsert';
        subObj.Last_Name__c='testLastName';
        subObj.Click_Location__c='Sign Up Free - Desktop Nav';
        subObj.Signup_Type__c='Email';
        subObj.Tags__c='Test Tag';
        subObj.Youth_sport_options__c='I am a coach,I am a teacher';
        subObj.Email_Address__c='test@gmail.com';
        subObj.Balance_is_Better__c=true;
        subObj.isDuplicate__c=false;
         subObj.Athlete_Life_Db__c=true;
        subObj.RecordTypeId ='0126F000001Msc2QAC';
        subObj.Sector_Update__c=true;
        subObj.NZ_Coach__c=true;
        subObj.Kaupapa_Maori_News__c=true;
        subObj.Disability_Sector_News__c=true;
        subObj.Healthy_Active_Learning__c=true;
        subObj.Healthy_Active_Quarterly__c=true;
        subObj.Do_you_identify_as_Maori__c= true;
        subObj.Ko_wai_koe__c='Other';
        subObj.Youth_sport_options__c='I am a Coach, Other';
        subObj.Role__c='Other';
         subObj.Monthly__c=true;
        SubObj.iseGuide__c=true;
        SubObj.HiddenTag__c='how much is too much';
        insert subObj;
        subscriber__c subObj1=new subscriber__c();
        
        subObj1.First_Name__c='testSub1beforeInsert';
        subObj1.Last_Name__c='testLastName1';
        subObj1.Click_Location__c='Sign Up Free - Desktop Nav';
        subObj1.Signup_Type__c='Email';
        subObj1.Tags__c='Test Tag';
        subObj1.Youth_sport_options__c='I am a coach,I am a teacher';
        subObj1.Email_Address__c='test@gmail.com';
        subObj1.Balance_is_Better__c=true;
        subObj1.Monthly__c=true;
        subObj1.RecordTypeId ='0126F000001Msc2QAC';
       /* subObj1.Sector_Update__c=true;
        subobj1.NZ_Coach__c=true;
        subObj1.Kaupapa_Maori_News__c=true;
        subObj1.Disability_Sector_News__c=true;
        subObj1.Healthy_Active_Learning__c=true;
        subObj1.Healthy_Active_Quarterly__c=true; */ 
        
        test.startTest();
        insert subObj1;
       
        //update subList;
        
        //delete subObj;
        test.stopTest();
        
    }
     @isTest
    public static void testupdatedfunction(){
        subscriber__c subObj=new subscriber__c();
        //Email_Address__c,First_Name__c,Last_Name__c,Click_Location__c,Signup_Type__c,Tags__c
        subObj.First_Name__c='testSubtestupdated';
        subObj.Last_Name__c='testLastName';
        subObj.Click_Location__c='Sign Up Free - Desktop Nav';
        subObj.Signup_Type__c='Email';
        subObj.Tags__c='Test Tag';
        subObj.Email_Address__c='test@gmail.com';
        subObj.Balance_is_Better__c=true;
      subObj.Monthly__c=true;
        subObj.isDuplicate__c=false;
        subObj.Youth_sport_options__c='I am a coach';
        insert subObj;
        
        subscriber__c subObj1=new subscriber__c();
        //Email_Address__c,First_Name__c,Last_Name__c,Click_Location__c,Signup_Type__c,Tags__c
        subObj1.First_Name__c='testSub2testupdated';
        subObj1.Last_Name__c='testLastName';
        subObj1.Click_Location__c='Sign Up Free - Desktop Nav';
        subObj1.Signup_Type__c='Email';
        subObj1.Tags__c='Test Tag';
        subObj1.Email_Address__c='test@gmail1.com';
        subObj1.Balance_is_Better__c=true;
           //subObj1.RecordTypeId='Public';
        subObj1.HiddenTag__c='How Much is too much';
        subObj1.isDuplicate__c=true;
         subObj1.Monthly__c=true;
         
        insert subObj1;
        
        List<Subscriber__c> updatedlist = new List<Subscriber__c>();
        List<Subscriber__c> listtoupdate = [select id,isDuplicate__c,Email_Address__c,HiddenTag__c from Subscriber__c where First_Name__c='testSub2testupdated' ];
        for(Subscriber__c c: listtoupdate )
        {
            c.Email_Address__c = 'test@gmail.com';
            c.HiddenTag__c ='how much is too much';
            updatedlist.add(c);
            
        }
        
        test.startTest();
        update updatedlist;
        test.stopTest();
        
    }
    
      @isTest
    public static void testupdatedfunctionNoDuplicate(){
        
        subscriber__c subObj1=new subscriber__c();
        //Email_Address__c,First_Name__c,Last_Name__c,Click_Location__c,Signup_Type__c,Tags__c
        subObj1.First_Name__c='testSubUNoDuplicate';
        subObj1.Last_Name__c='testLastName';
        subObj1.Click_Location__c='Sign Up Free - Desktop Nav';
        subObj1.Signup_Type__c='Email';
        subObj1.Tags__c='Test Tag';
        subObj1.Email_Address__c='test@gmail.com';
        subObj1.Balance_is_Better__c=false;
        subObj1.isDuplicate__c=true;
        subObj1.Youth_sport_options__c='I am a coach,I am a teacher';
         subObj1.Monthly__c=true;
        insert subObj1;
        
        subscriber__c subObj=new subscriber__c();
        //Email_Address__c,First_Name__c,Last_Name__c,Click_Location__c,Signup_Type__c,Tags__c
        subObj.First_Name__c='testSubUNoDuplicate';
        subObj.Last_Name__c='testLastName';
        subObj.Click_Location__c='Sign Up Free - Desktop Nav';
        subObj.Signup_Type__c='Email';
        subObj.Tags__c='Test Tag';
        subObj.Email_Address__c='test1@gmail.com';
        subObj.Balance_is_Better__c=true;
        subObj.Youth_sport_options__c='I am a coach,I am a teacher';
        subObj.isDuplicate__c=false;
         subObj.Monthly__c=true;
        insert subObj;
        
        List<Subscriber__c> lupdate=new List<Subscriber__c>();
        /*subObj1.isDuplicate__c=false;
        lupdate.add(subObj1);*/
        //subscriber__c subObj2=new subscriber__c();
        //Email_Address__c,First_Name__c,Last_Name__c,Click_Location__c,Signup_Type__c,Tags__c
        subObj1.First_Name__c='testSub1UNoDuplicate';
        subObj1.Email_Address__c='test1@gmail.com';
        lupdate.add(subObj1);
        
        
        test.startTest();
        update lupdate;
        test.stopTest();
        
    }

}