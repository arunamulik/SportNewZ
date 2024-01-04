({
     PurposeOfActivity: function(component, event, helper) {
        component.set("v.PurposeOfActivity",true);
        component.set("v.ExpectationsOfImpact",false);
         component.set("v.HOPDomain",false);
        var AddcmpTarget = component.find('tab1');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('tab2');
        $A.util.removeClass(RemovecmpTarget, 'active');
         var RemovecmpTarget = component.find('tab3');
        $A.util.removeClass(RemovecmpTarget, 'active');
    },
    HOPDomain: function(component, event, helper) {
        component.set("v.PurposeOfActivity",false);
        component.set("v.HOPDomain",true);
        component.set("v.ExpectationsOfImpact",false);
        var AddcmpTarget = component.find('tab2');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('tab1');
        $A.util.removeClass(RemovecmpTarget, 'active');
         var RemovecmpTarget = component.find('tab3');
        $A.util.removeClass(RemovecmpTarget, 'active');
    },
    ExpectationsOfImpact: function(component, event, helper) {
        component.set("v.PurposeOfActivity",false);
        component.set("v.ExpectationsOfImpact",true);
        component.set("v.HOPDomain",false);
        var AddcmpTarget = component.find('tab3');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('tab1');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('tab2');
        $A.util.removeClass(RemovecmpTarget, 'active');
    }
    
    ,
    
    toggleClass: function(component, event, helper) {
        console.log('3==>***');
        
        //document.getElementById("myDropdown").classList.toggle("show");
    },
    navigateDashboardPage : function(component, event, helper) {
        var viewRecordEvent = $A.get("e.force:navigateToURL");
        viewRecordEvent.setParams({
            //"url": "https://portdev-sportnz.cs5.force.com/SportNZ/s/activity-dashboard-page"
            "url": "/activity-dashboard-page"
        });
        viewRecordEvent.fire();
        
    },
    navigateQuantativePage : function(component, event, helper) {
        var viewRecordEvent = $A.get("e.force:navigateToURL");
        viewRecordEvent.setParams({
            //"url": "https://portdev-sportnz.cs5.force.com/SportNZ/s/Activity-Quantative-Page"
            "url": "/Activity-Quantative-Page"
        });
        viewRecordEvent.fire();
        
    },
    navigateLandingPage : function(component, event, helper) {
        var viewRecordEvent = $A.get("e.force:navigateToURL");
        viewRecordEvent.setParams({
            //"url": "https://portdev-sportnz.cs5.force.com/SportNZ/s/activity-landing-page"
            "url": "/activity-landing-page"
            
        });
        viewRecordEvent.fire();
    },
    navigateQualitativePage : function(component, event, helper) {
        var viewRecordEvent = $A.get("e.force:navigateToURL");
        viewRecordEvent.setParams({
            //"url": "https://portdev-sportnz.cs5.force.com/SportNZ/s/activity-qualitive-page"
            "url": "/activity-qualitive-page"
        });
        viewRecordEvent.fire();
    },
   loadJquery : function(component, event, helper) {
        jQuery(document).ready(function(){
            var maxLength = 100;
            $('textarea').keyup(function() {
                var length = $(this).val().length;
                var length = maxLength-length;
                $('#chars').text(length);
            });
        });
    },
    scriptsLoaded : function(component, event, helper) {
        console.log('****************18***************'+component.get('v.activitiesRelatedtoUser'));
        var UserRelatedAct = component.get('v.activitiesRelatedtoUser');
        var $win = $(window);
        var $intro = $('.intro');
        var sidebar = $('.sidebar__inner');
        var $intro__title = $('.intro__title');
        var initialHeight = $intro.height();
        var $fader = $intro.find('.js-fader');
        var $faderAdaptive = $intro.find('.js-fader-adaptive');
        var $sectionAltColor = $('.js-section-alt-color');
        var color = $sectionAltColor.data('color');
        var minHeight = 240;
        var sectionAltColorOffset;
        var scrollHeight = $(document).height();
        var win = $(window).height();
        
        
        var scrollPosition = $(window).height() + $(window).scrollTop();
        if ($sectionAltColor.length) {
            sectionAltColorOffset = 915 - minHeight;
        }
        
        if ($win.width() < 768) {
            minHeight = 140;
        }
        
        
        if(UserRelatedAct == false){
            $win.on('load scroll', function () {
                
                var faderOffset = $fader.offset().top;
                var scroll = $win.scrollTop();
                var introHeightOnScroll = initialHeight - scroll;
                var sectionAltColorHeight = $sectionAltColor.outerHeight();
                var sectionAltColorOffsetBottom;
                var introHeightOnScroll1 =40-(scroll/22)+'%';
                var minmargin=10+'%';
                if ($sectionAltColor.length) {
                    sectionAltColorOffsetBottom = sectionAltColorOffset + sectionAltColorHeight;
                }
                
                if (introHeightOnScroll >= 350) {
                    $intro.removeClass('style-reduce');
                } else {
                    $intro.addClass('style-reduce');
                }
                
                if (introHeightOnScroll >= minHeight) {
                    $intro.removeClass('fixed');
                    $intro.css('height', introHeightOnScroll);
                    $intro__title.css('margin-Top', introHeightOnScroll1);
                } else {
                    $intro.addClass('fixed');
                    $intro.css('height', minHeight);
                    $intro__title.css('margin-Top', minmargin);
                    $fader.css('background-image', 'linear-gradient(to bottom, rgba(236,236,236,1) 20%,rgba(236,236,236,0) 100%)');
                    
                    if (scroll >= sectionAltColorOffset && scroll <= sectionAltColorOffsetBottom + introHeightOnScroll + 99) {
                        $faderAdaptive.css('background-image', 'linear-gradient(to bottom, rgba(' + color + ',1) 20%,rgba(' + color + ',0) 100%)');
                        $fader.removeClass('active');
                        $faderAdaptive.addClass('active');
                    } else if (scroll > sectionAltColorOffsetBottom) {
                        $fader.css('background-image', 'linear-gradient(to bottom, rgba(236,236,236,1) 20%,rgba(236,236,236,0) 100%)');
                        $fader.addClass('active');
                        $faderAdaptive.removeClass('active');
                    }
                }
                if(scroll<40){
                    sidebar.css({
                        position: "relative",
                        transform: "translate3d(0px, 0px, 0px)",
                        top: 0,
                        left: 0+ "px",
                        bottom: 0+ "px",
                    });
                }else if(scroll<700 && scroll>=40)
                {
                    sidebar.css({
                        position: "fixed",
                        transform: "translate3d(0px, 0px, 0px)",
                        top: "auto",
                        left: 0+ "px",
                        bottom: 0+ "px",
                        width: 256+ "px", 		
                    });
                }
                    else if(scroll>700 )
                    {
                        sidebar.css({
                            position: "fixed",
                            transform: "translate3d(0px, 0px, 0px)",
                            top: "auto",
                            left: 0+ "px",
                            bottom: 0+ "px",
                            width: 256+ "px", 		
                        });
                    }
                
                if ((scrollHeight - scrollPosition) / scrollHeight === 0) {
                    // when scroll to bottom of the page
                    
                    
                    sidebar.css({
                        position: "absolute",
                        transform: "translate3d(0px,"+win+", 0px)",
                        top: "auto",
                        left: 0+ "px",
                        bottom: 0+ "px",
                    });
                }
                
            });
            var scrollNextSection = function scrollNextSection() {
                $('.js-scroll-next-section').on('click', function () {
                    var $this = $(this);
                    var $nextSection = $this.closest('.intro').next();
                    var target = $nextSection.offset().top - 239;
                    
                    if ($win.width() < 768) {
                        $('html, body').animate({
                            scrollTop: target + 99
                        }, 500);
                    } else {
                        $('html, body').animate({
                            scrollTop: target
                        }, 500);
                    }
                });
            };
            
            scrollNextSection();  
        }
        if(scroll<60){
                sidebar.css({
                    position: "relative",
                    transform: "translate3d(0px, 0px, 0px)",
                    top: 0,
                    left: 0+ "px",
                    bottom: 0+ "px",
                });
            }else if(scroll<700 && scroll>=60)
            {
                sidebar.css({
                    position: "fixed",
                    transform: "translate3d(0px, 0px, 0px)",
                    top: "auto",
                    left: 0+ "px",
                    bottom: 0+ "px",
                    width: 256+ "px", 		
                });
            }
                else if(scroll>700 )
                {
                    sidebar.css({
                        position: "fixed",
                        transform: "translate3d(0px, 0px, 0px)",
                        top: "auto",
                        left: 0+ "px",
                        bottom: 0+ "px",
                        width: 256+ "px", 		
                    });
                }
            
            if ((scrollHeight - scrollPosition) / scrollHeight === 0) {
                // when scroll to bottom of the page
                
                
                sidebar.css({
                    position: "relative",
                    transform: "translate3d(0px,"+win+", 0px)",
                    top: "auto",
                    left: 0+ "px",
                    bottom: 0+ "px",
                });
            }
        
        
    },
    
    /* scriptsLoaded : function(component, event, helper) {
        
         var $win = $(window);
         var $intro = $('.intro');
         var initialHeight = $intro.height();
         var $fader = $intro.find('.js-fader');
         var $faderAdaptive = $intro.find('.js-fader-adaptive');
         var $sectionAltColor = $('.js-section-alt-color');
         var color = $sectionAltColor.data('color');
         var minHeight = 240;
         var sectionAltColorOffset;         
         var initialHeight = $intro.height();
         var $fader = $intro.find('.js-fader');
         var $faderAdaptive = $intro.find('.js-fader-adaptive');
         var $sectionAltColor = $('.js-section-alt-color');
         var color = $sectionAltColor.data('color');
         var minHeight = 240;
         var sectionAltColorOffset;
         
         if ($sectionAltColor.length) {
             sectionAltColorOffset = $sectionAltColor.offset().top - minHeight;
         }
         
         if ($win.width() < 768) {
             minHeight = 140;
         }
         
         $win.on('load scroll', function () {
             
             var faderOffset = $fader.offset().top;
             var scroll = $win.scrollTop();
             var introHeightOnScroll = initialHeight - scroll;
             var sectionAltColorHeight = $sectionAltColor.outerHeight();
             var sectionAltColorOffsetBottom;
             
             
            
             
             if ($sectionAltColor.length) {
                 sectionAltColorOffsetBottom = sectionAltColorOffset + sectionAltColorHeight;
             }
             
             if (introHeightOnScroll >= 350) {
                 $intro.removeClass('style-reduce');
             } else {
                 $intro.addClass('style-reduce');
             }
             
             if (introHeightOnScroll >= minHeight) {
                 $intro.removeClass('fixed');
                 $intro.css('height', introHeightOnScroll);
             } else {
                 $intro.addClass('fixed');
                 $intro.css('height', minHeight);
                 $fader.css('background-image', 'linear-gradient(to bottom, rgba(236,236,236,1) 20%,rgba(236,236,236,0) 100%)');
                 
                 if (scroll >= sectionAltColorOffset && scroll <= sectionAltColorOffsetBottom + introHeightOnScroll + 99) {
                     $faderAdaptive.css('background-image', 'linear-gradient(to bottom, rgba(' + color + ',1) 20%,rgba(' + color + ',0) 100%)');
                     $fader.removeClass('active');
                     $faderAdaptive.addClass('active');
                 } else if (scroll > sectionAltColorOffsetBottom) {
                     $fader.css('background-image', 'linear-gradient(to bottom, rgba(236,236,236,1) 20%,rgba(236,236,236,0) 100%)');
                     $fader.addClass('active');
                     $faderAdaptive.removeClass('active');
                 }
             }
         });
         
         
         
         
         
          
    },
*/
    doInit : function(component, event, helper) {
        //var curl=component.get("v.pageReference").state.testAttribute;
        //alert('RUL_Landing Doinit');
         /*var urlString = window.location.href;
 		var baseURL = urlString.substring(0, urlString.indexOf("/s"));
        alert(baseURL);*/
        var cyear=component.get("v.filteryear");
       // alert('RUL_Landing:- '+cyear);
        // Commenting for new solution
        
        /*if(fyear!=null)
        {
        alert('before readparams'+fyear);
           
				helper.readParams(component,fyear);
                alert('after readparams');
        //alert('landing doinit');
        }
       	else
        {
            alert('in else');
            helper.readnullParams(component,fyear);
        }*/
        
        //till above
        
        
       var ShowResultValue = event.getParam("activitiyEventSelected");
        //alert(JSON.stringify('landing data'+ShowResultValue));
		// set the handler attributes based on event data
		component.set("v.activitiySelectedRecord", ShowResultValue);

        console.log('15////==>'+component.get("v.disableAnswersOnSaveComplete"));
        component.set("v.height", window.screen.availHeight);
        helper.fetchvideoOrImage(component, event, helper);
        helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist',cyear);
        helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
        //if(fyear==null) Commenting for new solution
        {
            //alert('in null');
        var action = component.get("c.fetchUser");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                var responseArray = storeResponse.split(":");
                console.log('8===>'+responseArray);
                component.set("v.userInfo", responseArray[0]);
                 console.log('9===>'+responseArray);
                if(responseArray[1] == 0){
                    component.set("v.activitiesRelatedtoUser", true);
                }
            }
        });
        $A.enqueueAction(action);
        }
        
        //Commenting for new solution
        /*else
        {
            alert('in value');
        var action = component.get("c.fetchUser1");
            action.setParams({fy:fyear});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                var responseArray = storeResponse.split(":");
                console.log('8===>'+responseArray);
                component.set("v.userInfo", responseArray[0]);
                 console.log('9===>'+responseArray);
                if(responseArray[1] == 0){
                    component.set("v.activitiesRelatedtoUser", true);
                }
                
                //alert(baseURL);
                
                //redirection
                
                
               $A.get('e.force:refreshView').fire();
                alert(component.set("v.filteryear",fy));
            }
        });
            
        $A.enqueueAction(action);
             
        }*/
    },
    
    
    
    onPicklistChange: function(component, event, helper) {
        // get the value of select option
        console.log(event.getSource().get("v.value"));
        //component.set("v.selectedGovernedBy", event.getSource().get("v.value"));
        //var ss = component.get("v.activitiySelected");
        // ss.By_OrgGoverned__c = event.getParam("value");
    },
    
    openModel: function(component, event, helper) {
        
        // Set isModalOpen attribute to true
        component.set("v.isModalOpen", true);
        if(component.get("v.firstStepActivityWizard")== true){
            console.log('36==>');
            component.set("v.disablebuttonid",true);
        }
    },
    closeModel: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
    },
    gotoStep2: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.firstStepActivityWizard", false);
        component.set("v.secondStepActivityWizard", true);        
    },
    goBacktoStep1: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.secondStepActivityWizard", false); 
        component.set("v.firstStepActivityWizard", true);
    },
    goBacktoStep2: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.thirdStepActivityWizard", false); 
        component.set("v.secondStepActivityWizard", true);
    },
    gotoStep3: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.secondStepActivityWizard", false);  
        component.set("v.thirdStepActivityWizard", true);  
    },
    saveAndgotoStep1 : function(component, event,helper) {
        var newActivity = component.get("v.newActivity");
        console.log('36==>'+newActivity);
        var action = component.get("c.saveActivity");
        action.setParams({ 
            "act": newActivity
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            console.log('42==>'+state);
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
                console.log('hello from here'+JSON.stringify(name));
                //component.set("v.isModalOpen", false);
                //window.location.reload();
                component.set("v.thirdStepActivityWizard", false);
                component.set("v.firstStepActivityWizard", true);
                component.find('activityName').set("v.value", "");
                component.find('activityDesc').set("v.value", "");
                component.find('activityExpectDesc').set("v.value", "");
                console.log('53==>'+component.find('activityName').get("v.value"));
                
                /*var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();*/
                
            }
        });
        $A.enqueueAction(action)
    },
    submitDetailsBkup : function(component, event,helper) {
        alert("362");
        var newActivity = component.get("v.newActivity");
        console.log('36==>'+newActivity);
        var action = component.get("c.saveActivity");
        action.setParams({ 
            "act": newActivity
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            console.log('42==>'+state);
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
                console.log('hello from here'+JSON.stringify(name));
                component.set("v.isModalOpen", false);
                window.location.reload();
                component.find('activityName').set("v.value", "");
                console.log('53==>'+component.find('activityName').get("v.value"));
                
                
                /*var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();*/
                
            }
        });
        $A.enqueueAction(action)
    },
    handleFilesChange : function (component, event, helper) {
        var files = event.getSource().get("v.files");
        if(files){
            var file = files[0]
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function () {
                var template = component.get("v.richtextvalue");
                if(template===undefined) template = '';
                template += '<img src="'+reader.result+'"/>';
                component.set("v.richtextvalue",template);
            };
            reader.onerror = function (error) {
                console.log('Error: ', error);
            };
        }
    },
    displayActivityDetails : function(component, event,helper) {
        console.log('78==>'+event.target.title);
        
        var cmpTarget = component.find("changeOnSelect");
        console.log('78==>'+cmpTarget);
        $A.util.removeClass(cmpTarget, 'HOPvalueDiv');
        $A.util.addClass(cmpTarget, 'HOPvalueDivSelected');
        
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: event.target.title
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
            }
        });
        $A.enqueueAction(action);
    }  ,  
    fetchAllPicklistValues : function(component, event,helper){
        console.log('152-====>' + JSON.stringify(component.get("v.activitiySelected")));
        
        helper.getByOrgGoverned(component, 'By_OrgGoverned__c', 'accIndustry');
        helper.getByActivityGMDGoverned(component, 'By_ActivityGMDgoverned__c', 'activityGMDGovernedPicklist');
        helper.getThroughTypeOfActivityPicklist(component, 'Through_typeActNgaTaonga__c', 'ThroughTypeOfActivityPicklist');
        helper.getInOnActivitiesPicklist(component, 'InOn_LocateActMaunga__c', 'InOnActivitiesPicklist');
        helper.getSignificanceLocationPicklist(component, 'InOn_SignificanceLocation__c', 'SignificanceLoactionPicklist');
        helper.getUseOfTeReoPickilist(component, 'With_UseOfTeReo__c', 'UseOfTeReoPickilist');
        helper.getPurposeOfTeReoPickilist(component, 'With_PrposeTeReoAwareness__c', 'PurposeOfTeReoPickilist');
        
    },
    fetchDiamensionsPicklistValues : function(component, event,helper){
        console.log('195-====>');
        helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
    },
    savePicklistValues : function(component, event,helper){
        var HTML = document.getElementById('iframeid');
        console.log('418===>'+HTML.contentWindow.document.body.innerHTML);
        var newActivity = component.get("v.activitiySelected");
        console.log('36==>'+JSON.stringify(newActivity));
        var action = component.get("c.saveActivity");
        action.setParams({ 
            "act": newActivity
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            console.log('42==>'+state);
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
                console.log('hello from here'+JSON.stringify(name));
                $A.get('e.force:refreshView').fire();
                /*var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();*/
                
            }
        });
        $A.enqueueAction(action)
    },
    navigateToNextTab : function(component, event, helper) {
        console.log('224==>'+component.get("v.tabId"));
        var selectedTabid = component.get("v.tabId");
        if(selectedTabid == 'tab1'){
            component.set("v.tabId","tab2");
        }else if(selectedTabid == 'tab2'){
            component.set("v.tabId","tab3");
        }else if(selectedTabid == 'tab3'){
            component.set("v.tabId","tab4");
        }else if(selectedTabid == 'tab4'){
            component.set("v.tabId","tab5");
        }else if(selectedTabid == 'tab5'){
            component.set("v.DisableNext",true);   
        }
    },
    navigateToPreviousTab : function(component, event, helper) {
        console.log('224==>'+component.get("v.tabId"));
        var selectedTabid = component.get("v.tabId");
        if(selectedTabid == 'tab2'){
            component.set("v.tabId","tab1");
        }else if(selectedTabid == 'tab3'){
            component.set("v.tabId","tab2");
        }else if(selectedTabid == 'tab4'){
            component.set("v.tabId","tab3");
        }else if(selectedTabid == 'tab5'){
            component.set("v.tabId","tab4");
        }else if(selectedTabid == 'tab1'){
            component.set("v.DisablePre",true);   
        }
    },
    DoWhenActive : function(component, event, helper) {
        console.log('227==>'+component.get("v.tabId"));
        var selectedTabid = component.get("v.tabId");
        if(selectedTabid == 'tab1'){
            component.set("v.DisablePre",true);   
            component.set("v.DisableNext",false);   
        }else if(selectedTabid == 'tab5'){
            component.set("v.DisableNext",true);   
        }if(selectedTabid == 'tab2'){
            component.set("v.DisablePre",false);
            component.set("v.DisableNext",false);   
        }else if(selectedTabid == 'tab3'){
            component.set("v.DisablePre",false);
            component.set("v.DisableNext",false);   
        }else if(selectedTabid == 'tab4'){
            component.set("v.DisablePre",false);  
            component.set("v.DisableNext",false);   
        }else if(selectedTabid == 'tab5'){
            component.set("v.DisablePre",false);  
            component.set("v.DisableNext",true);   
        }
    },
    SaveAnswerEditMode : function(component, event, helper){
        var newActivity = component.get("v.activitiySelected");
        console.log('277==>'+JSON.stringify(newActivity));
        var action = component.get("c.saveActivity");
        action.setParams({ 
            "act": newActivity
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            console.log('284==>'+state);
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
                console.log('287'+JSON.stringify(name));
                component.set("v.refreshFlag", true);
                component.set("v.refreshCount", component.get("v.refreshCount") + 1);
                //component.set("v.refreshComponent", !component.set("v.refreshComponent"));
                //$A.get('e.force:refreshView').fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action)
    },
    SaveAnswerReadOnlyMode : function(component, event, helper){
        console.log('304===>'+component.get("v.tabId"));
        var tabId = component.get("v.tabId");
        var newActivity = component.get("v.activitiySelected");
        console.log('277==>'+JSON.stringify(newActivity));
        var action = component.get("c.saveActivity");
        action.setParams({ 
            "act": newActivity,
            "selectedTabId": tabId
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            console.log('284==>'+state);
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
                console.log('287'+JSON.stringify(name));
                component.set("v.refreshFlag", true);
                component.set("v.refreshCount", component.get("v.refreshCount") + 1);
                //component.set("v.refreshComponent", !component.set("v.refreshComponent"));
                component.set("v.disableAnswersOnSaveComplete1", true);
                console.log('320////==>'+component.get("v.disableAnswersOnSaveComplete1"));
                //$A.get('e.force:refreshView').fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();
                
            }
        });
        $A.enqueueAction(action)
    },
    SaveChangeReq : function(component, event, helper){
        var newActivity = component.get("v.activitiySelected");
        console.log('338==>'+JSON.stringify(newActivity));
        var action = component.get("c.SaveChangeReqandMail");
        action.setParams({ 
            "act": newActivity
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            console.log('345==>'+state);
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
                console.log('348'+JSON.stringify(name));
                component.set("v.refreshFlag", true);
                component.set("v.submitChangeRequest", false);
                component.set("v.ShowChangeReqModal", false);
                component.set("v.ShowChangeReqMsg", true);
                component.set("v.refreshCount", component.get("v.refreshCount") + 1);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();
                
            }
        });
        $A.enqueueAction(action)
    },
    CloseChangeReq : function(component, event, helper){
        component.set("v.ShowChangeReqModal", false);
    },
    OpenChangeReqModal : function(component, event, helper){
        component.set("v.ShowChangeReqModal", true);
    },
    onsectiontoggle: function (component, event, helper) {
       /* var auratitle = event.currentTarget.title;
        console.log('78==>'+event.currentTarget.title);
        var auraid = event.currentTarget.id;
        console.log('584==>'+auraid);
        
        var cmpTarget = component.find("changeOnSelect");
        console.log('78==>'+cmpTarget);
        $A.util.removeClass(cmpTarget, 'HOPvalueDiv');
        $A.util.addClass(cmpTarget, 'HOPvalueDivSelected');*/

        var ShowResultValue = event.getParam("activitiyEventSelected");
		// set the handler attributes based on event data
		component.set("v.activitiySelected", ShowResultValue);
        
       /* var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: event.currentTarget.title
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
            }
        });
        $A.enqueueAction(action);*/
       // helper.helperFun(component,event );
    },
    viewActivity : function (component, event, helper) {
        
        var activityDetails = component.get('v.newActivity');
        console.log('82==>'+JSON.stringify(activityDetails));
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: activityDetails.Id
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
            }
        });
        $A.enqueueAction(action);
        helper.helperFun(component,event, activityDetails.Id, 'toggleDiv'+activityDetails.Id );
        
    },
    CallLoginBox1: function (component, event, helper) {
        //var cmpTarget = component.find('tab2');
        component.set("v.LoginBox1",true);
        
    },
})