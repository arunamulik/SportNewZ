({
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
    scriptsLoaded : function(component, event, helper) {
        var $win = $(window);
        var $intro = $('.intro');
        var sidebar = $('.sidebar__inner');
        var $intro__title= $('.intro__title');
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
            var introHeightOnScroll1 =0 +'%';
            var minmargin=0+'%';
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
            if(scroll<106){
                sidebar.css({
                    position: "relative",
                    transform: "translate3d(0px, 0px, 0px)",
                    top: 0,
                    left: 0+ "px",
                    bottom: 0+ "px",
                });
            }else if(scroll<700 && scroll>=106)
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
        var dividerActive = function dividerActive(){       
            var $divider = $('.divider');
            $divider.each(function () {
                var $thisDivider = $(this);
                var dividerOffset = $thisDivider.offset().top;
                var winHeight = $win.height();
                $win.on('load scroll', function () {
                    var scroll = $win.scrollTop();
                    if (scroll + winHeight >= dividerOffset) {
                        $thisDivider.addClass('active');
                    }
                });
            });
        };
        
        scrollNextSection();
        dividerActive();
        
        
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
        var cyear=component.get("v.filteryear");
        var ShowResultValue = event.getParam("activitiyEventSelected");
        
		component.set("v.activitiySelectedRecord", ShowResultValue);
        
        component.set("v.height", window.screen.availHeight);
        helper.fetchvideoOrImage(component, event, helper);
        helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist',cyear);
        helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
        helper.getByOrgGoverned(component, 'By_OrgGoverned__c', 'accIndustry');
        helper.getByActivityGMDGoverned(component, 'By_ActivityGMDgoverned__c', 'activityGMDGovernedPicklist');
        helper.getThroughTypeOfActivityPicklist(component, 'Through_typeActNgaTaonga__c', 'ThroughTypeOfActivityPicklist');
        helper.getInOnActivitiesPicklist(component, 'InOn_LocateActMaunga__c', 'InOnActivitiesPicklist');
        helper.getSignificanceLocationPicklist(component, 'InOn_SignificanceLocation__c', 'SignificanceLoactionPicklist');
        helper.getUseOfTeReoPickilist(component, 'With_UseOfTeReo__c', 'UseOfTeReoPickilist');
        helper.getPurposeOfTeReoPickilist(component, 'With_PrposeTeReoAwareness__c', 'PurposeOfTeReoPickilist');
        
        var action = component.get("c.fetchUser");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                var responseArray = storeResponse.split(":");
                console.log('8===>'+responseArray);
                component.set("v.userInfo", responseArray[0]);
                if(responseArray[1] == 0){
                    component.set("v.activitiesRelatedtoUser", true);
                }
            }
        });
        $A.enqueueAction(action);
        
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
    submitDetails : function(component, event,helper) {
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
        alert('152-====>' + JSON.stringify(component.get("v.activitiySelected")));
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
               
               //	window.location.reload();
                console.log('hello from here'+JSON.stringify(name));
                //$A.get('e.force:refreshView').fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been successfully updated."
                });
                toastEvent.fire();
                JSON.strigify(component.get("v.activitiySelected"));
            }
            
            else if(state === "ERROR"){
                 var errorname = a.getError();
               
                /*var name = a.getReturnValue();
                alert('91==>'+name);
                component.set("v.activitiySelected",name);*/
                
                
             component.set("v.showError",true);            
             component.set("v.errorMessage",errorname[0].message);
                var errorname1 = errorname[0].message;
                
                
                     
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
           //var errorname = a.getError();
            title : 'Error',
            message:"Oops! Please ensure each total matches the number of participants total.",//errorname1,//Error Message in Validation Please Check The Error On The Page As Below
            duration:'5000',
            key: 'info_alt',
            type: 'error',
            mode: 'pester'
        });
        toastEvent.fire();
                	
        JSON.strigify(component.get("v.activitiySelected"));
                
                    } 
            
          
        });
        $A.enqueueAction(action);
        
        var action = component.get("c.doInit");
        $A.enqueueAction(action);
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
    handleSectionToggle: function (cmp, event) {
        var openSections = event.getParam('openSections');
        
        /*if (openSections.length === 0) {
            cmp.set('v.activeSectionsMessage', "All sections are closed");
        } else {
            cmp.set('v.activeSectionsMessage', "Open sections: " + openSections.join(', '));
        }
    }*/
    },
    
    calculateWhanauTypeTotal: function(component,event,helper){
        var MaraeNo = component.find("MaraeNumber").get("v.value");
        var Hapu = component.find("HapuNumber").get("v.value");
        var Iwi   = component.find("IwiNumber").get("v.value");
        var Whanau = component.find("WhanauNumber").get("v.value");
        var Kohanga = component.find("KohangaNumber").get("v.value");
        var Kura = component.find("KuraNumber").get("v.value");
        var Whare = component.find("WhareNumber").get("v.value");
        var Wanaga = component.find("WanagaNumber").get("v.value");
        var Kaupapa = component.find("KaupapaNumber").get("v.value");
        var OtherWhanau = component.find("OtherWhanauNumber").get("v.value");
        var WhanauWhaikaha = component.find("WhanauWhaikahaWhanauNumber").get("v.value");
        var ManaTipua = component.find("ManaTipuaWhanauNumber").get("v.value");

       
        
        if(MaraeNo == ''){
            MaraeNo = 0;
             component.find("MaraeNumber").set("v.value",MaraeNo);
            console.log('---'+component.find("MaraeNumber").set("v.value",MaraeNo));
           
        }
        if(Hapu == ''){
            Hapu = 0;
            component.find("HapuNumber").set("v.value",Hapu);
            console.log('---'+component.find("HapuNumber").set("v.value",Hapu));
        }
        if(Iwi == ''){
            Iwi = 0;
            component.find("IwiNumber").set("v.value",Iwi);
            console.log('---'+component.find("IwiNumber").set("v.value",Iwi));
        }
        if(Whanau == ''){
            Whanau = 0;
             component.find("WhanauNumber").set("v.value",Whanau);
            console.log('---'+component.find("WhanauNumber").set("v.value",Whanau));
        }
        if(Kohanga == ''){
            Kohanga = 0;
             component.find("KohangaNumber").set("v.value",Kohanga);
            console.log('---'+component.find("KohangaNumber").set("v.value",Kohanga));
        }
        if(Kura == ''){
            Kura = 0;
             component.find("KuraNumber").set("v.value",Kura);
            console.log('---'+component.find("KuraNumber").set("v.value",Kura));
        }
        if(Whare == ''){
            Whare = 0;
             component.find("WhareNumber").set("v.value",Whare);
            console.log('---'+component.find("WhareNumber").set("v.value",Whare));
        }
        if(Wanaga == ''){
            Wanaga = 0;
             component.find("WanagaNumber").set("v.value",Wanaga);
            console.log('---'+component.find("WanagaNumber").set("v.value",Wanaga));
        }
        if(Kaupapa == ''){
            
            Kaupapa = 0;
             component.find("KaupapaNumber").set("v.value",Kaupapa);
            console.log('---'+component.find("KaupapaNumber").set("v.value",Kaupapa));
        }
        if(OtherWhanau == ''){
            OtherWhanau = 0;
             component.find("OtherWhanauNumber").set("v.value",OtherWhanau);
            console.log('---'+component.find("OtherWhanauNumber").set("v.value",OtherWhanau));
        }

         
        if(WhanauWhaikaha == ''){
            WhanauWhaikaha = 0;
             component.find("WhanauWhaikahaWhanauNumber").set("v.value",WhanauWhaikaha);
            console.log('---'+component.find("WhanauWhaikahaWhanauNumber").set("v.value",WhanauWhaikaha));
           
        }

        if(ManaTipua == ''){
            ManaTipua = 0;
             component.find("ManaTipuaWhanauNumber").set("v.value",ManaTipua);
            console.log('---'+component.find("ManaTipuaWhanauNumber").set("v.value",ManaTipua));
           
        }
        
        
        var Total = parseInt(MaraeNo) + parseInt(Hapu) + parseInt(Iwi) + parseInt(Whanau) + parseInt(Kohanga) + parseInt(Kura) + parseInt(Whare)
        + parseInt(Wanaga) + parseInt(Kaupapa) + parseInt(OtherWhanau) + parseInt(WhanauWhaikaha)+ parseInt(ManaTipua);
        /*var Total = parseInt(MaraeNo) + parseInt(Hapu) + parseInt(Iwi) + parseInt(Whanau) + parseInt(Kohanga) + parseInt(Kura) + parseInt(Whare)
        + parseInt(Wanaga) + parseInt(Kaupapa) +  parseInt(WhanauWhaikaha)+ parseInt(ManaTipua); */
        component.set("v.activitiySelected.Particaipation_WhanauType_Total__c",Total);
    },
    
    
    ageofParticipantTotal : function(component,event,helper){
        
      /* if(component.get('v.activitiySelected.AgeOfParticipants_DidNotRespond__c') == '') {
            component.set('v.activitiySelected.AgeOfParticipants_DidNotRespond__c',0)
        } else {
            component.set('v.activitiySelected.AgeOfParticipants_DidNotRespond__c',Integer.parseInt(component.get('v.activitiySelected.AgeOfParticipants_DidNotRespond__c')));
        } 
        alert('ttt-->'+Integer.parseInt(component.get('v.activitiySelected.AgeOfParticipants_DidNotRespond__c'))); */     
        
        var Moko = component.find("MokoNumber").get("v.value");
        var Taio = component.find("TaioNumber").get("v.value");
        var RangaOne   = component.find("RangaNumberOne").get("v.value");
       // var RangaTwo = component.find("RangaNumberTwo").get("v.value");
        //var PakekaNoOne = component.find("PakekeNumberOne").get("v.value");
        var MatauOne = component.find("MatauOne").get("v.value");
        var PakekaNoTwo = component.find("PakekeNumberTwo").get("v.value");
        var Kau = component.find("KauNumber").get("v.value");
        var AgeRes =component.find("AgeResNumber").get("v.value");//component.get('v.activitiySelected.AgeOfParticipants_DidNotRespond__c');
        
        if(Moko == ''){
            Moko = 0;
            component.find("MokoNumber").set("v.value",Moko);
           
        }
        if(Taio == ''){
            Taio = 0;
            component.find("TaioNumber").set("v.value",Taio);
        }
        if(RangaOne == ''){
            RangaOne = 0;
            component.find("RangaNumberOne").set("v.value",RangaOne);
        }
        /*if(RangaTwo == ''){
            RangaTwo = 0;
            component.find("RangaNumberTwo").set("v.value",RangaTwo);
        }*/
       /* if(PakekaNoOne == ''){
            PakekaNoOne = 0;
            component.find("PakekeNumberOne").set("v.value",PakekaNoOne);
        }*/


        if(MatauOne == ''){
            MatauOne = 0;
            component.find("MatauOne").set("v.value",MatauOne);
        }
        if(PakekaNoTwo == ''){
            PakekaNoTwo = 0;
            component.find("PakekeNumberTwo").set("v.value",PakekaNoTwo);
        }
        if(Kau == ''){
            Kau = 0;
            component.find("KauNumber").set("v.value",Kau);
        }
        if(AgeRes == ''){
            AgeRes = 0;
            component.find("AgeResNumber").set("v.value",AgeRes);
        }  
        
        var TotalAge = parseInt(Moko) + parseInt(Taio) + parseInt(RangaOne)+ parseInt(MatauOne) +  
        + parseInt(PakekaNoTwo) + parseInt(Kau) + parseInt(AgeRes) ;
        component.set("v.activitiySelected.AgeOfParticipants_Total__c",TotalAge);
    },
    
    genderParticipantTotal : function(component,event,helper){
        var Tane = component.find("TaneNumber").get("v.value");
        var Wahin = component.find("WahinNumber").get("v.value");
        var ResNo = component.find("ResNumber").get("v.value");
        
        if(Tane == ''){
            Tane = 0;
            component.find("TaneNumber").set("v.value",Tane);
        }
        if(Wahin == ''){
            Wahin = 0;
            component.find("WahinNumber").set("v.value",Wahin);
        }
        if(ResNo == ''){
            ResNo = 0;
            component.find("ResNumber").set("v.value",ResNo);
        }
        var genderTotal = parseInt(Tane) + parseInt(Wahin) + parseInt(ResNo);
        
        component.set("v.activitiySelected.GenderOfParticipants_Total__c",genderTotal);
    },
    
    EthnicityTotal : function(component,event,helper) {
        var Mao = component.find("MaoriNumber").get("v.value");
        console.log("656>>"+Mao);
        
        var NonMao = component.find("NonMaoriNumber").get("v.value");
        var NoRestEthin = component.find("NoResEthin").get("v.value");   
        
        if(Mao == ''){
            Mao = 0;
             var Mao = parseInt(Mao); 
            component.find("MaoriNumber").set("v.value",Mao);
        }
        if(NonMao == ''){
            NonMao = 0;
            var NonMao = parseInt(NonMao); 
            component.find("NonMaoriNumber").set("v.value",NonMao);
        }
        if(NoRestEthin == ''){
            NoRestEthin = 0;
             //var NoRestEthin = parseInt(NoRestEthin); 
            component.find("NoResEthin").set("v.value",parseInt(NoRestEthin));
        }
        
        var EthincityTotal = parseInt(Mao) + parseInt(NonMao) + parseInt(NoRestEthin);
        component.set("v.activitiySelected.EthnicityOfParticipants_Total__c",EthincityTotal);
    },
    
    onsectiontoggle: function (component, event, helper) {
        //alert('onsectiontoggle');
         var ShowResultValue = event.getParam("activitiyEventSelected");
		// set the handler attributes based on event data
		if(ShowResultValue.Id != undefined ){
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: ShowResultValue.Id 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                //alert(JSON.stringify(storeResponse));
                component.set("v.activitiySelected",storeResponse);
                component.set("v.activitiySelectedRecord", storeResponse);
               // alert(JSON.stringify(component.get("v.activitiySelected.Raraunga_Kaunga_Question1__c")));
            }
        });
        $A.enqueueAction(action);
        }
       /* var auratitle = event.currentTarget.name;
        console.log('78==>'+event.currentTarget.name);
        var auraid = event.currentTarget.id;
        console.log('584==>'+auraid);
        
        var cmpTarget = component.find("changeOnSelect");
        console.log('78==>'+cmpTarget);
        $A.util.removeClass(cmpTarget, 'HOPvalueDiv');
        $A.util.addClass(cmpTarget, 'HOPvalueDivSelected');
        
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: event.currentTarget.name
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
        helper.helperFun(component,event, auratitle, auraid );*/
    },
    openModel: function(component, event, helper) {
        
        // Set isModalOpen attribute to true
        component.set("v.isModalOpen", true);
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
        closeModel: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
    },
     openCreateActivityWizard: function(component, event, helper) {
        // Set isModalOpen attribute to true
         component.set("v.isModalOpen", true);
        var auratTargetId = event.currentTarget.name;
        console.log('id==>'+event.currentTarget.name);
        var evt = $A.get("e.c:getRecordId");
				evt.setParams({ "activitiyEventSelectedID": auratTargetId});
                evt.fire();
        
    },
     callDelete: function(component, event, helper) {
        // Set isModalOpen attribute to true
         component.set("v.isDeletePopup", true);
        var auratTargetId = event.currentTarget.name;
         if(auratTargetId != undefined){
              component.set("v.IdToDelete", auratTargetId);
         }
       
         console.log('id==>'+event.currentTarget.name);
    },
    closeDeleteModal: function(component, event, helper) {
      // Set isModalOpen attribute to false  
      component.set("v.isDeletePopup", false);
   },
    deleteDetails:function(component, event, helper) {
     var deleteRec = component.get("v.IdToDelete");
        console.log(deleteRec);
    	var action = component.get("c.deleteSelectedActivity");
        action.setParams({
            id: deleteRec
        });
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                var viewRecordEvent = $A.get("e.force:navigateToURL");
        		viewRecordEvent.setParams({
            		"url": "/Activity-Quantative-Page"
            
        		});
        		viewRecordEvent.fire();
            }
        });
        $A.enqueueAction(action);
        component.set("v.isDeletePopup", false);
        }
})