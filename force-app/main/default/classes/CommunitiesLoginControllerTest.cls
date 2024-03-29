/**
 * An apex page controller that exposes the site login functionality
 */
@IsTest global with sharing class CommunitiesLoginControllerTest {
    @IsTest
    global static void testCommunitiesLoginController () {
     	CommunitiesLoginController controller = new CommunitiesLoginController();
     	System.assertEquals(null, controller.forwardToAuthPage());   
        controller.RedirectToLogin();
        controller.loginUser();
         controller.loginPatnerUser();
        controller.checkCommonLoginAccess();
    }    
}