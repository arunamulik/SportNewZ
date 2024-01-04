/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used to test functionality of Course_Participation Page

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 18-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of Course_Participation Page
   ==========================================================================================================================
*/
@isTest
private class Course_ParticipationControllerTest {
    /*
     @ Description : Method to insert Course Participation Data
    */
    public static testMethod void testSaveCoursePart() {
        List<Course_Activity_Profile_Data__c> lstCourseData = new List<Course_Activity_Profile_Data__c>();
        //Creating test data
        lstCourseData = RUL_Util.createCourseActProData();
        insert lstCourseData[0];
        Test.setCurrentPageReference(new PageReference('Page.Course_Participation')); 
        apexpages.currentpage().getparameters().put('id', lstCourseData[0].id);
                            
        Course_ParticipationController controller = new Course_ParticipationController();
        controller.newCoursePart.Total_Participants__c = 12;
        PageReference pageRef = controller.save();
        System.assertEquals(pageRef.getUrl(),'/' + controller.newCoursePart.Id);
       // System.assertEquals(1, [select count() from Course_Participation_Data__c WHERE Course__c =: lstCourseData[0].id]);       
    }
    
    /*
     @ Description : Method to cancel Course Participation Data
    */
    public static testMethod void testCancelCoursePart() {
        List<Course_Activity_Profile_Data__c> lstCourseData = new List<Course_Activity_Profile_Data__c>();
        //Creating test data
        lstCourseData = RUL_Util.createCourseActProData();
        insert lstCourseData[0];
        Test.setCurrentPageReference(new PageReference('Page.Course_Participation')); 
        apexpages.currentpage().getparameters().put('id', lstCourseData[0].id);
                            
        Course_ParticipationController controller = new Course_ParticipationController();
        controller.newCoursePart.Total_Participants__c = 12;
        PageReference pageRef = controller.Cancel();
        System.assertEquals(pageRef.getUrl(),'/' + controller.newCoursePart.Course__c);       
    }
}