({
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
        function progressCircle() {
            if ($('.progress-circle').length) {
                
                initProgressCircle();
                
            }
        }
        
        var initProgressCircle = function initProgressCircle() {
            var counter = document.getElementById('counter').getContext('2d');
            var no = 0;
            var pointToFill = 4.72;
            var cw = counter.canvas.width;
            var ch = counter.canvas.height;
            var diff;
            
            function fillCounter() {
                diff = no / 100 * Math.PI * 2 * 10;
                counter.clearRect(0, 0, cw, ch);
                counter.lineWidth = 10;
                counter.fillStyle = '#fff';
                counter.strokeStyle = '#d01d1b';
                counter.textAlign = 'center';
                counter.font = '25px monospace';
                counter.beginPath();
                counter.arc(100, 100, 93, pointToFill, diff / 10 + pointToFill);
                counter.stroke();
                if (no >= 60) {
                    clearTimeout(fill);
                }
                
                no++;
            }
            
            var fill = setInterval(fillCounter, 10);
            
        };
        progressCircle();
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
   
    
    doInit : function(component, event, helper) {
        
        var cyear=component.get("v.filteryear");
        //alert('RUL_Dashboard cyear:- '+cyear);
        console.log('15////==>'+component.get("v.disableAnswersOnSaveComplete"));
         var ShowResultValue = event.getParam("activitiyEventSelected");
        //alert(JSON.stringify(ShowResultValue));
		// set the handler attributes based on event data
		component.set("v.activitiySelectedRecord", ShowResultValue);
        
        component.set("v.height", window.screen.availHeight);
        helper.fetchvideoOrImage(component, event, helper);
        helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist',cyear);
        helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
        helper.gettotalParticipantsValues(component, event, helper,cyear);
        helper.getFemaleAndMaleValues(component, event, helper,cyear);
        helper.getFemaleAndMalePercentValues(component, event, helper,cyear);
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
        
        var action123 = component.get("c.get_With_PrposeTeReo");
        action123.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
            }
            
        });
        $A.enqueueAction(action123); 
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
    /*  generateChart: function (component, event, helper) {
                var action1 = component.get("c.getBy_ActivityGMDdelivered");
                action1.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        let val = response.getReturnValue() ;
                        var labelset=[] ;
                        var dataset = []
                        var keyString = 'y';
                        var myMap = new Map();
                        
                        var dataset1 = [
                            {label : "Malcom", y:7},
                            {label : "Kaylee", y: 5},
                            {label : "Jayne", y: 7}
                        ];
                        val.forEach(function(key) {
                           
                            
                            myMap.set(keyString,key.count);
                        });
                        
                        console.log("dataset>>>>>>>>>>"+JSON.stringify(val));
                        CanvasJS.addColorSet("greenShades",
                        [//colorSet Array
        
                       "rgb(208, 29, 27)" ,"rgb(255, 131, 0)","rgb(255, 195, 0)"          
                        ]);
                        var chart = new CanvasJS.Chart("chartContainer1", {
                            animationEnabled: true,
                             colorSet: "greenShades",
                            data: [{
                                type: "doughnut",
                                radius:  "90%", 
                                 innerRadius: "50%",
                                size:"60%",
                                 indexLabelPlacement: "inside",
                                indexLabelFontSize: 17,
                                indexLabel: "#percent%",
                                toolTipContent: "<b>{label}:</b> {y} (#percent%)",
                                dataPoints:val,
                                 
                                
                                
                                
                                
                                
                            }]
                            
                        });
                    }     
                    chart.render();
                    
                    
                });
                $A.enqueueAction(action1);
                
            }*/
    
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
    handleSectionToggle: function (cmp, event) {
        var openSections = event.getParam('openSections');
        
        /*if (openSections.length === 0) {
                    cmp.set('v.activeSectionsMessage', "All sections are closed");
                } else {
                    cmp.set('v.activeSectionsMessage', "Open sections: " + openSections.join(', '));
                }
            }*/
    },
    /* scriptsLoaded1: function(component, event, helper) {
                var action = component.get("c.getBy_ActivityGMDgoverned");
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        let val = response.getReturnValue() ;
                        var labelset=[] ;
                        var dataset=[] ;
                        val.forEach(function(key) {
                            labelset.push(key.label) ; 
                            dataset.push(key.count) ; 
                        });
                        new Chart(document.getElementById("pie-chart1"), {
                            type: 'doughnut',
                            data: {
                                labels:labelset,
                                datasets: [{
                                    
                                    backgroundColor: [
                                        "rgb(208, 29, 27)" ,"rgb(255, 131, 0)","rgb(255, 195, 0)"
                                    ],   
                                    data: dataset
                                }]
                            },
                            options: {
                                title: {
                                    display: true,
                                },
                                legend: {
                                    display: false
                                },
                                
                            }
                        });
                    }
                });
                $A.enqueueAction(action);
                
                var action1 = component.get("c.getBy_ActivityGMDdelivered");
                action1.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        let val = response.getReturnValue() ;
                        var labelset=[] ;
                        var dataset=[] ;
                        val.forEach(function(key) {
                            labelset.push(key.label) ; 
                            dataset.push(key.count) ; 
                        });
                        new Chart(document.getElementById("pie-chart2"), {
                            type: 'doughnut',
                            
                            data: {
                                labels:labelset,
                                datasets: [{
                                    
                                    backgroundColor: [
                                        "rgb(208, 29, 27)" ,"rgb(255, 131, 0)","rgb(255, 195, 0)"
                                    ],   
                                    data: dataset,
                                    
                                }]
                            },
                            options: {
                                
                                title: {
                                    display: true,
                                },
                                legend: {
                                    display: false
                                },
                                
                            }
                            
                        });
                    }
                });
                $A.enqueueAction(action1);
                
                helper.getThirdChart(component,event,helper); 
                var action5 = component.get("c.getAgeOfParticipants");
                action5.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var val = response.getReturnValue() ;
                        console.log('704>>'+val);
                        var labelset=[] ;
                        var dataset=[] ;
                        
                        new Chart(document.getElementById("bar"), {
                            type: 'horizontalBar',
                            
                            data : {
                                labels: [ "Mokopuna","Taiohi", "Rangatahi(13_15)", "Rangatahi16_19", "Pakeke40_59", "Pakeke_20_39", "Kaum_tua"],
                                datasets: [
                                    {
                                        
                                        data: val,
                                        backgroundColor: [
                                            "rgb(255, 195, 0)",
                                            "rgb(255, 195, 0)",
                                            "rgb(255, 195, 0)",
                                            "rgb(255, 195, 0)",
                                            "rgb(255, 195, 0)",
                                            "rgb(255, 195, 0)",
                                            "rgb(255, 195, 0)"
                                        ],   
                                        
                                        
                                    }
                                    
                                ]
                            },xAxis: {
                                type: 'category',
                                labels: {
                                    style: {
                                        color: '#330000',
                                        fontSize: '14px'
                                    }
                                }
                            },
                            yAxis: {
                                min: 0,
                                max: 400,
                                title: {
                                    text: ''
                                }
                            },
                            plotOptions: {
                                series: {
                                    borderWidth: 0,
                                    pointPadding: 1,
                                    groupPadding: .8,
                                    dataLabels: {
                                        enabled: true,
                                        format: '{point.y:.1f}%'
                                    }
                                }
                            },
                            options: {
                                
                                title: {
                                    display: true,
                                },
                                legend: {
                                    display: false
                                },
                                
                                
                            }
                            
                        });
                    }
                });
                $A.enqueueAction(action5);
                var action7 = component.get("c.get_With_PrposeTeReo");
                action7.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var val = response.getReturnValue() ;
                        console.log('704>>'+val);
                        var labelset=[] ;
                        var dataset=[] ;
                        
                        new Chart(document.getElementById("pie-chart5"), {
                            type: 'doughnut',
                            
                            data : {
                                labels: [ "Raise tawareness","Build knowledge", "Extended activity"],
                                datasets: [
                                    {
                                        
                                        data: val,
                                        backgroundColor: [
                                            "rgb(208, 29, 27)" ,"rgb(255, 131, 0)","rgb(255, 195, 0)"
                                        ],   
                                        
                                        
                                    }
                                    
                                ]
                            },
                            options: {
                                
                                title: {
                                    display: true,
                                },
                                legend: {
                                    display: false
                                },
                                
                                
                            }
                            
                        });
                    }
                });
                $A.enqueueAction(action7);
                var action6 = component.get("c.getEthnicityOfParticipants");
                action6.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var val = response.getReturnValue() ;
                        console.log('704>>'+val);
                        var labelset ;
                        var dataset=[] ;
                        
                        new Chart(document.getElementById("pie-chart4"), {
                            type: 'doughnut',
                            
                            data : {
                                labels: [ "Māori","Non Māori"],
                                datasets: [
                                    {
                                        
                                        data: val,
                                        backgroundColor: [
                                            "rgb(208, 29, 27)" ,"rgb(255, 131, 0)","rgb(255, 195, 0)"
                                        ],    
                                        
                                        
                                    }
                                    
                                ]
                            },
                            options: {
                                
                                title: {
                                    display: true,
                                },
                                legend: {
                                    display: false
                                },
                                
                                
                            }
                            
                        });
                    }
                });
                $A.enqueueAction(action6);
                
                var action8 = component.get("c.get_With_PrposeTikanga");
                action8.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var val = response.getReturnValue() ;
                        var labelset=[] ;
                        var dataset=[] ;
                        
                        new Chart(document.getElementById("pie-chart6"), {
                            type: 'doughnut',
                            
                            data : {
                                labels: [ "Raise tawareness","Build knowledge", "Opportunity to Apply"],
                                datasets: [
                                    {
                                        
                                        data: val,
                                        backgroundColor: [
                                            "rgb(208, 29, 27)" ,"rgb(255, 131, 0)","rgb(255, 195, 0)"
                                        ],   
                                        
                                        
                                    }
                                    
                                ]
                            },
                            options: {
                                
                                title: {
                                    display: true,
                                },
                                legend: {
                                    display: false
                                },
                                
                                
                            }
                            
                        });
                    }
                });
                $A.enqueueAction(action8);
                var action9 = component.get("c.getNoOfGroups");
                action9.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var val = response.getReturnValue() ;
                        console.log('704>>'+val);
                        var labelset=[] ;
                        var dataset=[] ;
                        
                        new Chart(document.getElementById("bar1"), {
                            type: 'horizontalBar',
                            
                            data : { 
                                labels: [ "Marae","Hapu", "Iwi", "Wh_nau", "Waka", "KohangaPuna", "Kura_Kaupapa","Whare_Kura","_Whare_Wananga","Kaupapa_H_kinakina"],
                                datasets: [
                                    {
                                        
                                        data: val,
                                        backgroundColor: [
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)", "rgb(208, 29, 27)", "rgb(208, 29, 27)", "rgb(208, 29, 27)"
                                        ],   
                                        
                                        
                                    }
                                    
                                ]
                            },xAxis: {
                                type: 'category',
                                labels: {
                                    style: {
                                        color: '#330000',
                                        fontSize: '14px'
                                    }
                                }
                            },
                            yAxis: {
                                min: 0,
                                max: 400,
                                title: {
                                    text: ''
                                }
                            },
                            plotOptions: {
                                series: {
                                    borderWidth: 0,
                                    pointPadding: 1,
                                    groupPadding: .8,
                                    dataLabels: {
                                        enabled: true,
                                        format: '{point.y:.1f}%'
                                    }
                                }
                            },
                            options: {
                                
                                title: {
                                    display: true,
                                },
                                legend: {
                                    display: false
                                },
                                
                                
                            }
                            
                        });
                    }
                });
                $A.enqueueAction(action9);
                var action10 = component.get("c.getInOn_LocateAct");
                action10.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var val = response.getReturnValue() ;
                        console.log('893>>'+val);
                        var labelset=[] ;
                        var dataset=[] ;
                        
                        new Chart(document.getElementById("bar2"), {
                            type: 'horizontalBar',
                            
                            data : { 
                                labels: [ "Maunga","Awa", "Marae", "Kohanga", "Kura", "Wahi", "SRC","SRC2"],
                                datasets: [
                                    {
                                        
                                        data: val,
                                        backgroundColor: [
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)",
                                            "rgb(208, 29, 27)"
                                        ],   
                                        
                                        
                                    }
                                    
                                ]
                            },xAxis: {
                                type: 'category',
                                labels: {
                                    style: {
                                        color: '#330000',
                                        fontSize: '14px'
                                    }
                                }
                            },
                            yAxis: {
                                min: 0,
                                max: 400,
                                title: {
                                    text: ''
                                }
                            },
                            plotOptions: {
                                series: {
                                    borderWidth: 0,
                                    pointPadding: 1,
                                    groupPadding: .8,
                                    dataLabels: {
                                        enabled: true,
                                        format: '{point.y:.1f}%'
                                    }
                                }
                            },
                            options: {
                                
                                title: {
                                    display: true,
                                },
                                legend: {
                                    display: false
                                },
                                
                                
                            }
                            
                        });
                    }
                });
                $A.enqueueAction(action10);
                var action11 = component.get("c.getActivityDiamension");
                action11.setCallback(this, function(response) {
                    var state = response.getState();
                    var totalOfScore=[];
                    var custs = [];
                    var custs1 = [];
                    var totalOfScore1=0,totalOfScoreThorugh=0,totalOfScoreFor=0,totalOfScoreInOn=0,totalOfScoreWith=0;
                    if (state === "SUCCESS") {
                        var val = response.getReturnValue() ;
                        for(var key in val){
                            custs.push({value:val[key], key:key});
                        }
                        component.set("v.DiamensionValues", custs);
                        
                        // component.set("v.DiamensionValuesInList", custs);
                        console.log('valval8===>'+JSON.stringify(val));
                        console.log( component.get("v.DiamensionValues"));
                    }
                });
                
                $A.enqueueAction(action11);
            },*/
    generateChart12: function (component, event, helper) {
        var cyear=component.get("v.filteryear");
        var action1 = component.get("c.getBy_ActivityGMDdelivered");
        action1.setParams({fyear:cyear});
        action1.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                
                console.log('valval8===>'+JSON.stringify(val));
                var myMap = new Map();
                Highcharts.chart('chart-delivered', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: ''
                    },
                    tooltip: {
                        pointFormat: '<b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            showInLegend: true,
                            allowPointSelect: true,
                            cursor: 'pointer',
                            //colors: ['#d01d1b','#ff8300', '#ffc300','#FF7F50' ],
                            colors: ['#ff8300','#FF7F50', '#ffc300','#d01d1b' ],
                            dataLabels: {
                                enabled: false,
                              /*  align: 'center',
                                enabled: true,
                               // format: '{point.percentage:.1f} %',
                                distance: -25,
                                style: {
                                    fontSize: '9px !important',
                                    color: '#000000',
                                    textOutline: 'none'
                                },*/
                                filter: {
                                    property: 'percentage',
                                    operator: '>',
                                    value: 1
                                }
                            }
                        }
                    },
                    series: [{
                        
                        innerSize: '50%',
                        data: val
                    }]
                });
            }
        });
        $A.enqueueAction(action1);
       
        var action2 = component.get("c.getBy_ActivityGMDgoverned");
        action2.setParams({fyear:cyear});
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                var dataset1 = [
                    {label : "Malcom", y:7},
                    {label : "Kaylee", y: 5},
                    {label : "Jayne", y: 7}
                ];
                
                
                console.log("datase2324t>zsfsfsd>>>>>>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-pie-governed', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: ''
                    },
                    tooltip: {
                        pointFormat: '<b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            showInLegend: true,
                            allowPointSelect: true,
                            cursor: 'pointer',
                            //colors: ['#d01d1b','#ff8300', '#ffc300','#FF7F50' ],
                            colors: ['#ff8300','#FF7F50', '#ffc300','#d01d1b' ],
                            dataLabels: {
                                align: 'center',
                                enabled: false,
                                //format: '{point.percentage:.1f} %',
                                distance: -20,
                                style: {
                                    fontSize: '9px !important',
                                    color: '#000000',
                                    textOutline: 'none'
                                },
                                filter: {
                                    property: 'percentage',
                                    operator: '>',
                                    value: 1
                                }
                            }
                        }
                    },
                    series: [{
                        
                        innerSize: '50%',
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action2);
        var action3 = component.get("c.getInOn_LocateAct");
        action3.setParams({fyear:cyear});
        console.log("@@@@@@@@@@@@@@@@@@@@@@>>>>>>>");
        action3.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                
                
                
                console.log("@@@@@@@@@@@@@@@@@@@@@@>>>>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-location', {
                    chart: {
                        type: 'bar',
                        colors: ['#d01d1b'],
                    },
                    title: {
                        text: ''
                    },
                    subtitle: {
                        text: ''
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            
                            style: {
                                color: '#6f6f6f',
                                fontSize: '20px',
                                letterSpacing: '-.5',
                                cursor: 'default',
                                 fill: '#4f4f4f'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        max: 100,
                        labels: {
                            style: {}
                        },
                        title: {
                            text: ''
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    plotOptions: {
                        series: {
                            borderWidth: 0,
                            pointPadding: 1,
                            groupPadding: .8,
                            dataLabels: {
    						y: 6,
                                enabled: true,
                                style: {
                                    textOutline: 'none'
                                },
                                format: '{point.y:.1f}%'
                            }
                        }
                    },
                    tooltip: {
                        headerFormat: '<span style="font-size:16px;">{series.name}</span><br>',
                        pointFormat: '<span style="color:{point.color};font-size:16px;">{point.name}</span><span style="font-weight:700;color:#000;font-size:16px;"> Average:{point.count2:.2f}</span><br/>'
                    },
                    series: [{
                        name: "",
                        fontSize: '20px',
                        color:"#d01d1b",
                        colorByPoint: false,
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action3);
        var action11 = component.get("c.getActivityDiamension");
        action11.setParams({fyear:cyear});
        action11.setCallback(this, function(response) {
            var state = response.getState();
            var totalOfScore=[];
            var custs = [];
            var custs1 = [];
            var totalOfScore1=0,totalOfScoreThorugh=0,totalOfScoreFor=0,totalOfScoreInOn=0,totalOfScoreWith=0;
            if (state === "SUCCESS") {
                var val = response.getReturnValue() ;
                for(var key in val){
                    custs.push({value:val[key], key:key});
                }
                component.set("v.DiamensionValues", custs);
                
                // component.set("v.DiamensionValuesInList", custs);
                console.log('valval8===>'+JSON.stringify(val));
                console.log( component.get("v.DiamensionValues"));
            }
        });
        
        $A.enqueueAction(action11);
        
        var action4 = component.get("c.getBy_ActivityGMDmanaged");
        action4.setParams({fyear:cyear});
         action4.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                var dataset1 = [
                    {label : "Malcom", y:7},
                    {label : "Kaylee", y: 5},
                    {label : "Jayne", y: 7}
                ];
                
                
                console.log("datase2324t>zsfsfsd>>>>>>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-managed', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: ''
                    },
                    tooltip: {
                        pointFormat: '<b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                             showInLegend: true,
                            cursor: 'pointer',
                            //colors: ['#d01d1b','#ff8300', '#ffc300','#FF7F50' ],
                            colors: ['#ff8300','#FF7F50', '#ffc300','#d01d1b' ],
                            dataLabels: {
                                align: 'center',
                                enabled: false,
                                //format: '{point.percentage:.1f} %',
                                distance: -20,
                                style: {
                                    fontSize: '9px !important',
                                    color: '#000000',
                                    textOutline: 'none'
                                },
                                filter: {
                                    property: 'percentage',
                                    operator: '>',
                                    value: 1
                                }
                            }
                        }
                    },
                    series: [{
                        
                        innerSize: '50%',
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action4);
        
        
        
         var action13 = component.get("c.getBy_ORGGOVERENED");
        action13.setParams({fyear:cyear});
       action13.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                var dataset1 = [
                    {label : "Malcom", y:7},
                    {label : "Kaylee", y: 5},
                    {label : "Jayne", y: 7}
                ];
                
                
                console.log("datase2324t>zsfsfsd>>>>>>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-org-governed', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: ''
                    },
                    tooltip: {
                        pointFormat: '<b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            showInLegend: true,
                            allowPointSelect: true,
                            cursor: 'pointer',
                            //colors: ['#ffc300','#d01d1b', '#ff8300','#FF7F50' ],
                            colors: ['#ff8300','#ffc300', '#d01d1b','#FF7F50'],
                            dataLabels: {
                                align: 'center',
                                enabled: false,
                               // format: '{point.percentage:.1f} %',
                                distance: -20,
                                style: {
                                    fontSize: '9px !important',
                                    color: '#000000',
                                    textOutline: 'none'
                                },
                                filter: {
                                    property: 'percentage',
                                    operator: '>',
                                    value: 1
                                }
                            }
                        }
                    },
                    series: [{
                        
                        innerSize: '50%',
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action13);
        
        
        
        var action5 = component.get("c.getAgeOfParticipants");
        action5.setParams({fyear:cyear});
        action5.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                
                console.log('valval8==jk,sfd=>'+JSON.stringify(val));
                var myMap = new Map();
                Highcharts.chart('chart-age', {
                    chart: {
                        type: 'bar',
                        
                    },
                    title: {
                        text: ''
                    },
                    subtitle: {
                        text: ''
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            style: {
                                color: '#6f6f6f',
                                fontSize: '20px',
                                letterSpacing: '-.5',
                                cursor: 'default',
                                 fill: '#4f4f4f' 
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        max: 100,
                        title: {
                            text: ''
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    plotOptions: {
                        series: {
                            color:"#ffc300",
                            borderWidth: 0,
                            pointPadding: 1,
                            groupPadding: .8,
                            dataLabels: {
                                y:6,
                                enabled: true,
                                format: '{point.y:.1f}%'
                            }
                        }
                    },
                    tooltip: {
                        headerFormat: '<span style="font-size:16px;">{series.name}</span><br>',
                        pointFormat: '<span style="color:#4f4f4f;font-size:16px;">{point.name}</span><span style="font-weight:700;color:#000;font-size:16px;"> Total:{point.count2}</span> <br/>'
									//{point.color}
                    },
                    series: [{
                        name: "",
                        colorByPoint: false,
                        data: val
                    }]
                    
                    
                });
            }
        });
        $A.enqueueAction(action5);
        var action6 = component.get("c.getEthnicityOfParticipants");
        action6.setParams({fyear:cyear});
        action6 .setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                console.log("hi>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-ethnicity', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: ''
                    },
                    tooltip: {
                        pointFormat: '<b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            showInLegend: true,
                            allowPointSelect: true,
                            cursor: 'pointer',
                           colors: [ '#d01d1b','#ff8300'],
                            dataLabels: {
                                align: 'center',
                                enabled: false,
                               // format: '{point.percentage:.1f} %',
                                distance: -20,
                                style: {
                                    fontSize: '9px',
                                    color: '#000000',
                                    textOutline: 'none'
                                },
                                filter: {
                                    property: 'percentage',
                                    operator: '>',
                                    value: 1
                                }
                            }
                        }
                    },
                    series: [{
                        name: 'Partial',
                        innerSize: '50%',
                        data:val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action6);
        var action7 = component.get("c.get_With_PrposeTeReo");
        action7.setParams({fyear:cyear});
        action7.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                console.log("hi>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-te-reo', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: ''
                    },
                    tooltip: {
                        pointFormat: '<b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            showInLegend: true,
                            allowPointSelect: true,
                            cursor: 'pointer',
                            colors:  ['#d01d1b','#ff8300', '#ffc300' ],
                            dataLabels: {
                                align: 'center',
                                enabled: false,
                               // format: '{point.percentage:.1f} %',
                                distance: -20,
                                style: {
                                    fontSize: '9px',
                                    color: '#000000',
                                    textOutline: 'none'
                                },
                                filter: {
                                    property: 'percentage',
                                    operator: '>',
                                    value: 1
                                }
                            }
                        }
                    },
                    series: [{
                        name: 'Partial',
                        innerSize: '50%',
                        data:val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action7);
        var action8 = component.get("c.get_With_PrposeTikanga");
        action8.setParams({fyear:cyear});
        action8.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                console.log("hi>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-tikanga', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: ''
                    },
                    tooltip: {
                        pointFormat: '<b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            showInLegend: true,
                            allowPointSelect: true,
                            cursor: 'pointer',
                            colors:  ['#d01d1b','#ff8300', '#ffc300' ],
                            dataLabels: {
                                align: 'center',
                                enabled: false,
                               // format: '{point.percentage:.1f} %',
                                distance: -20,
                                style: {
                                    fontSize: '9px',
                                    color: '#000000',
                                    textOutline: 'none'
                                },
                                filter: {
                                    property: 'percentage',
                                    operator: '>',
                                    value: 1
                                }
                            }
                        }
                    },
                    series: [{
                        name: 'Partial',
                        innerSize: '50%',
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action8);
        
       var action9 = component.get("c.getNoOfGroups");
        action9.setParams({fyear:cyear});
        action9.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
               console.log("hidsgdgh>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-representation', {
                    chart: {
                        type: 'bar'
                    },
                    title: {
                        text: ''
                    },
                    subtitle: {
                        text: ''
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            style: {
                                color: '#6f6f6f',
                                fontSize: '20px',
                                letterSpacing: '-.5',
                                cursor: 'default',
                                 fill: '#4f4f4f'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        max: 100,
                        title: {
                            text: ''
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    plotOptions: {
                        series: {
                            color:"#ffc300",
                            borderWidth: 0,
                            pointPadding: 1,
                            groupPadding: .8,
                            dataLabels: {
                                y:6,
                                enabled: true,
                                format: '{point.y:.1f}%'
                            }
                        }
                    },
                    tooltip: {
                        headerFormat: '<span style="font-size:16px;">{series.name}</span><br>',
                        pointFormat: '<span style="color:{point.color};font-size:16px;">{point.name}</span><span style="font-weight:700;color:#000;font-size:16px;"> Total:{point.count2}</span><br/>'
                    },
                    series: [{
                        name: "",
                        color:"#d01d1b",
                        colorByPoint: false,
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action9); 
        
        
        
     /*   var action9 = component.get("c.getNoOfGroups");
        console.log("@@@@@@@@@@@@@@@@@@@@@@>>>>>>>");
        action9.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                
                
                
                console.log("@@@@@@@@@@@@@@@@@@@@@@>>>>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chart-representation', {
                    chart: {
                        type: 'bar',
                        colors: ['#d01d1b'],
                    },
                    title: {
                        text: ''
                    },
                    subtitle: {
                        text: ''
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            style: {
                                color: '#330000',
                                fontSize: '14px',
                                letterSpacing: '-.5'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        max: 100,
                        labels: {
                            style: {}
                        },
                        title: {
                            text: ''
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    plotOptions: {
                        series: {
                            borderWidth: 0,
                            pointPadding: 1,
                            groupPadding: .8,
                            dataLabels: {
                                enabled: true,
                                style: {
                                    textOutline: 'none'
                                },
                                format: '{point.y:.1f}%'
                            }
                        }
                    },
                    tooltip: {
                        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b><br/>'
                    },
                    series: [{
                        name: "",
                        color:"#d01d1b",
                        colorByPoint: false,
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action9);*/
        
        
        
        var action10 = component.get("c.LinkstoHOPoutcomes");
        action10.setParams({fyear:cyear});
        action10.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //alert('hop');
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                var dataset1 = [
                    {label : "Malcom", y:7},
                    {label : "Kaylee", y: 5},
                    {label : "Jayne", y: 7},
                    
                ];
                
                
                console.log("datase2324t>zsfsfsd>>>>>>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chartContainer', {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: ''
                    },
                    tooltip: {
                        pointFormat: '<b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            colors: ['#d01d1b','#ff8300', '#ffc300','#FF7F50','#FF6347', '#FFA07A','#DC143C','#B22222', '#8B0000','#FFDAB9','#F0E68C', '#228B22','#8FBC8F','#00FFFF', '#00BFFF' ],
                            dataLabels: {
                                align: 'center',
                                enabled: true,
                                format: '{point.percentage:.1f} %',
                                distance: -20,
                                style: {
                                    fontSize: '9px !important',
                                    color: '#000000',
                                    textOutline: 'none'
                                },
                                filter: {
                                    property: 'percentage',
                                    operator: '>',
                                    value: 1
                                }
                            }
                        }
                    },
                    series: [{
                        
                        innerSize: '50%',
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action10);
        /*action10.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue() ;
                var labelset=[] ;
                var dataset = []
                var keyString = 'y';
                var myMap = new Map();
                
                console.log("chart container>>>>"+JSON.stringify(val));
                
                Highcharts.chart('chartContainer', {
                    chart: {
                        type: 'bar'
                    },
                    title: {
                        text: ''
                    },
                    subtitle: {
                        text: ''
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            style: {
                                color: '#330000',
                                fontSize: '13px'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        max: 400,
                        title: {
                            text: ''
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    plotOptions: {
                        series: {
                            color:"#ffc300",
                            borderWidth: 0,
                            pointPadding: 1,
                            groupPadding: .8,
                            dataLabels: {
                                enabled: true,
                                format: '{point.y:.1f}%'
                            }
                        }
                    },
                    tooltip: {
                        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b><br/>'
                    },
                    series: [{
                        name: "",
                        color:"#d01d1b",
                        colorByPoint: false,
                        data: val
                    }]
                });
                
            }
        });
        $A.enqueueAction(action10);*/
        
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
    onsectiontoggle: function (component, event, helper) {
       var ShowResultValue = event.getParam("activitiyEventSelected");
            //alert(JSON.stringify(ShowResultValue.Id));
		// set the handler attributes based on event data
		//component.set("v.activitiySelected", ShowResultValue);
 
        if(ShowResultValue.Id != undefined ){
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: ShowResultValue.Id 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
               // alert(JSON.stringify(storeResponse.Raraunga_Kaunga_Question1__c));
                component.set("v.activitiySelected",storeResponse);
               // alert(JSON.stringify(component.get("v.activitiySelected.Raraunga_Kaunga_Question1__c")));
            }
        });
        $A.enqueueAction(action);
        }
        /*var auratitle = event.currentTarget.name;
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
            		"url": "/activity-dashboard-page"
            
        		});
        		viewRecordEvent.fire();
            }
        });
        $A.enqueueAction(action);
        component.set("v.isDeletePopup", false);
        }
    
})