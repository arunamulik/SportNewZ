({
    toggleClass: function(component, event, helper) {
        console.log('3==>***');
        
        //document.getElementById("myDropdown").classList.toggle("show");
    },
    navigateToDashboardPage : function(component, event, helper) {
        const myTimeout = setTimeout(scrollSection, 1000);
        
        function scrollSection() {
            window.scrollTo({
               top: 700,
               left: 0,
               behavior: 'smooth'
           });
           
        };
        window.onload = scrollSection;
        
        $(document).ready(function(){
            $(this).scrollTop(0);
        });
        
       
        component.set("v.showLoading",true);
        var selectedId=component.get("v.activitiySelected");
        //alert(JSON.stringify(selctedId.Id));
        //var storeResponse =component.get("v.activitiySelected");
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: selectedId.Id
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                component.set("v.showLoading",false);
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                //  component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        var AddcmpTarget = component.find('dashboard');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('landing');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Quantitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Qualitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        
        
        component.set("v.isDashboardPage",true);    
        component.set("v.isLandingPage",false);
        component.set("v.isQuantitativePage",false);
        component.set("v.isQualitativePage",false);
        component.set("v.currentTabClass",'dashboardBanner');  
        //helper.fetchvideoOrImage(component, event, helper);
        //helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist');
        //helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
        
        
        
    },
    
    handleonchange : function(component, event, helper){
    	
        var year=component.find("yearid").get("v.value");
        //alert(year);
        component.set("v.filteryearfield",year);
    },
    
    handleChange :function(component, event, helper){
        var cyear=component.find("yearid").get("v.value");
        //alert(cyear);
        //component.set("v.filteryear",year);
        component.set("v.showLoading",true);
        component.set("v.isDashboardPage",false);    
        component.set("v.isLandingPage",true);
        component.set("v.isQuantitativePage",false);
        component.set("v.isQualitativePage",false);
        component.set("v.currentTabClass",'landingBanner');
        console.log('$$$$$$'+component.get("v.pageReference"));
        console.log('15////==>'+window.screen.availHeight);
        component.set("v.height", window.screen.availHeight);
        var action = component.get("c.isUserHasActivities");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('14==>'+state);
            var hasActivities = response.getReturnValue();
            //if(hasActivities) {
                var ShowResultValue = event.getParam("CreateActivity");
                //alert(JSON.stringify(ShowResultValue));
                // set the handler attributes based on event data
                if(ShowResultValue != null || ShowResultValue != undefined ){
                    component.set("v.activitiySelected", ShowResultValue);
                }
                
                helper.fetchvideoOrImage(component, event, helper);
                helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist',cyear);
                helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
                helper.setBackGroundImage(component, event, helper);
                // helper.setDefaultBackGroundImage(component, event, helper);
                helper.setProfileImage(component, event, helper);
          
        })
        $A.enqueueAction(action);
        
	},
    
    navigateToQuantativePage : function(component, event, helper) {
         const myTimeout = setTimeout(scrollSection, 1000);
        
        function scrollSection() {
            window.scrollTo({
               top: 750,
               left: 0,
               behavior: 'smooth'
           });
           
        };
        window.onload = scrollSection;
        
        $(document).ready(function(){
            $(this).scrollTop(0);
        });
        
        component.set("v.showLoading",true);
        var selectedId=component.get("v.activitiySelected");
        //alert(JSON.stringify(selctedId.Id));
        //var storeResponse =component.get("v.activitiySelected");
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: selectedId.Id
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                component.set("v.showLoading",false);
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                //  component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        
        var AddcmpTarget = component.find('Quantitative');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('landing');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('dashboard');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Qualitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        
        component.set("v.isDashboardPage",false);    
        component.set("v.isLandingPage",false);
        component.set("v.isQuantitativePage",true);
        component.set("v.isQualitativePage",false);
        component.set("v.currentTabClass",'quantBanner'); 
        // helper.fetchvideoOrImage(component, event, helper);
        // helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist');
        // helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
        
    },
    navigateToLandingPage : function(component, event, helper) {
        const myTimeout = setTimeout(scrollSection, 1000);
        
        function scrollSection() {
            window.scrollTo({
               top: 950,
               left: 0,
               behavior: 'smooth'
           });
           
        };
        window.onload = scrollSection;
        
        $(document).ready(function(){
            $(this).scrollTop(0);
        });
        
        component.set("v.showLoading",true);
        var selectedId=component.get("v.activitiySelected");
        //alert(JSON.stringify(selctedId.Id));
        //var storeResponse =component.get("v.activitiySelected");
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: selectedId.Id
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                component.set("v.showLoading",false);
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                //  component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        
        var AddcmpTarget = component.find('landing');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('dashboard');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Quantitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Qualitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        
        component.set("v.isDashboardPage",false);    
        component.set("v.isLandingPage",true);
        component.set("v.isQuantitativePage",false);
        component.set("v.isQualitativePage",false);
        component.set("v.currentTabClass",'landingBanner');
        // helper.fetchvideoOrImage(component, event, helper);
        // helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist');
        // helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
    },
    navigateToQualitativePage : function(component, event, helper) {
	
        const myTimeout = setTimeout(scrollSection, 1000);
        
        function scrollSection() {
            window.scrollTo({
               top: 700,
               left: 0,
               behavior: 'smooth'
           });
           
        };
        window.onload = scrollSection;
        
        $(document).ready(function(){
            $(this).scrollTop(0);
        });
        
        component.set("v.showLoading",true);
        var selectedId=component.get("v.activitiySelected");
        //alert(JSON.stringify(selctedId.Id));
        //var storeResponse =component.get("v.activitiySelected");
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: selectedId.Id
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                component.set("v.showLoading",false);
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                //  component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        
        var AddcmpTarget = component.find('Qualitative');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('dashboard');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Quantitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('landing');
        $A.util.removeClass(RemovecmpTarget, 'active');
        
        component.set("v.isDashboardPage",false);    
        component.set("v.isLandingPage",false);
        component.set("v.isQuantitativePage",false);
        component.set("v.isQualitativePage",true);
        component.set("v.currentTabClass",'qualitativeBanner');
        
        // helper.fetchvideoOrImage(component, event, helper);
        // helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist');
        // helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
    },
    PurposeOfActivity: function(component, event, helper) {
        component.set("v.PurposeOfActivity",true);
        component.set("v.ExpectationsOfImpact",false);
        var AddcmpTarget = component.find('tab1');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('tab2');
        $A.util.removeClass(RemovecmpTarget, 'active');
    },
    ExpectationsOfImpact: function(component, event, helper) {
        component.set("v.PurposeOfActivity",false);
        component.set("v.ExpectationsOfImpact",true);
        var AddcmpTarget = component.find('tab2');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('tab1');
        $A.util.removeClass(RemovecmpTarget, 'active');
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
            sectionAltColorOffset = 915 - minHeight;
            
        }
        
        
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
        var scrollPosition = $(window).height() + $(window).scrollTop();
        if ($sectionAltColor.length) {
            sectionAltColorOffsetBottom = sectionAltColorOffset + sectionAltColorHeight;
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
            var introHeightOnScroll1 =0+'%';
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
                    position: "relative",
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
        var sidebarBottom = $('.sidebar__bottom');
        
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
                    // $fader.css('background-image', 'linear-gradient(to bottom, rgba(236,236,236,1) 20%,rgba(236,236,236,0) 100%)');
                    
                    if (scroll >= sectionAltColorOffset && scroll <= sectionAltColorOffsetBottom + introHeightOnScroll + 99) {
                        $faderAdaptive.css('background-image', 'linear-gradient(to bottom, rgba(' + color + ',1) 20%,rgba(' + color + ',0) 100%)');
                        $fader.removeClass('active');
                        // $faderAdaptive.addClass('active');
                    } else if (scroll > sectionAltColorOffsetBottom) {
                        //$fader.css('background-image', 'linear-gradient(to bottom, rgba(236,236,236,1) 20%,rgba(236,236,236,0) 100%)');
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
                        position: "relative",
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
                            position: "relative",
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
                        position: "fixed",
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
        //alert('doinit');
        var today = new Date();
		var cyear = today.getFullYear()+1;
        var curretYear=today.getFullYear();
      //  component.set('v.CurrentYear1',curretYear);
        //alert("CurrentYear : "+curretYear);
        var previousYear=today.getFullYear()-1;
        //component.set('v.previousYear',previousYear);
        //alert("previousYear : "+previousYear);
        //alert('cyear: '+cyear);
       //var setyear=cyear+'-'+(cyear+1);

        /*var cyear=component.find("yearid").get("v.value");
        alert(cyear);*/
       
        var action1 = component.get("c.getlistvalue");
        action1.setParams({ fyear : cyear });
        action1.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var list = response.getReturnValue();
                //alert('in success:- '+list);
                if(list != null)
                    component.set("v.filteryearfield",list);
            }
        });
        $A.enqueueAction(action1);
        
        var actyear;
        var action2 = component.get("c.getDueDate");
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var list = response.getReturnValue();
                actyear = list;
            }
        });
        $A.enqueueAction(action2);
        
        
        //component.set("v.filteryearfield",cyear);
        component.set("v.currentyear",curretYear);
        component.set("v.showLoading",true);
        component.set("v.isDashboardPage",false);
        component.set("v.isLandingPage",true);
        component.set("v.isQuantitativePage",false);
        component.set("v.isQualitativePage",false);
        component.set("v.currentTabClass",'landingBanner');
        console.log('$$$$$$'+component.get("v.pageReference"));
        console.log('15////==>'+window.screen.availHeight);
        component.set("v.height", window.screen.availHeight);
        
        var action = component.get("c.isUserHasActivities");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('14==>'+state);
            var hasActivities = response.getReturnValue();
           
                var ShowResultValue = event.getParam("CreateActivity");
                
                if(ShowResultValue != null || ShowResultValue != undefined ){
                    component.set("v.activitiySelected", ShowResultValue);
                    component.set("v.filteryearfield",actyear);
                    
                     var action3 = component.get("c.getlistvalue");
        			action3.setParams({ fyear : actyear });
        			action3.setCallback(this, function(response) {
                        var state = response.getState();
            		if (state === "SUCCESS") {
                		var list = response.getReturnValue();
                		//alert('in success:- '+list);
                		if(list != null)
                    		component.set("v.filteryearfield",list);
            			}
        			});
        			$A.enqueueAction(action3);
                    
                }
               
                helper.fetchvideoOrImage(component, event, helper);
                helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist',cyear);
                helper.getDiamensionScoreValues(component, 'Diamension_By_Score__c', 'DiamensionScorePicklist');
                helper.setBackGroundImage(component, event, helper);
                // helper.setDefaultBackGroundImage(component, event, helper);
                helper.setProfileImage(component, event, helper);
           
        })
        $A.enqueueAction(action);
        /*// $('select').niceSelect();
        var action = component.get("c.fetchUser");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                var responseArray = storeResponse.split(":");
                console.log('8===>'+responseArray);
                component.set("v.userInfo", responseArray[0]);
                if(responseArray[0] > 0){
                    //component.set("v.activitiesRelatedtoUser", true);
                }
                else{
                    //component.set("v.isModalOpen", true); 
                    /*if(component.get("v.firstStepActivityWizard")== true){
                        console.log('36==>');
                        //component.set("v.disablebuttonid",true);
                    }
                }
            }
        });
        $A.enqueueAction(action);
        console.log('****************248***************');*/
        
       /* currentUserId=component.get("v.userId");
        alert("currentUserId"+currentUserId);*/
       

                window.scrollTo(0, 700);

    },
    
    onPicklistChange: function(component, event, helper) {
        // get the value of select option
        console.log(event.getSource().get("v.value"));
        //component.set("v.selectedGovernedBy", event.getSource().get("v.value"));
        //var ss = component.get("v.activitiySelected");
        // ss.By_OrgGoverned__c = event.getParam("value");
    },

    scroll :  function(component, event, helper) {
        
        console.log('**** scroll', event.target.scrollTop);
        //component.set("v.pos", event.target.scrollTop);
    },
    
    openModel: function(component, event, helper) {
        
        var action = component.get("c.isDueDatePassed");
        
        action.setCallback(this, function(a) {
            var state = a.getState();
            
            if (state === "SUCCESS") {
                var isDate = a.getReturnValue();
                if(isDate==true){
                    // Set isModalOpen attribute to true
                    component.set("v.isModalOpen", true);
                    if(component.get("v.firstStepActivityWizard")== true){
                        console.log('36==>');
                        component.set("v.disablebuttonid",true);
                    }  
                }
                if(isDate==false){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        //var errorname = a.getError();
                        title : 'Error',
                        message:"Kia ora. The due date for entering planned activities has expired.",
                        duration:'5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                }
            }
            
        });
        $A.enqueueAction(action)       
        
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
       // alert("362");
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
        //alert('onsectiontoggle');
        var auratitle = event.currentTarget.name;
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
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        helper.helperFun(component,event, auratitle, auraid );
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
        /*var deleteRec = component.get("v.IdToDelete");
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
                
				$A.get('e.force:refreshView').fire();                
            }
        });
        $A.enqueueAction(action);
        component.set("v.isDeletePopup", false);*/
        var deleteRecid = component.get("v.IdToDelete");
        var deleteRec = component.get("v.isDeleteActivity");
        console.log(deleteRec);
        var action = component.get("c.deleteSelectedActivity");
        action.setParams({
            isDelete: deleteRec,
            id : deleteRecid
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                $A.get('e.force:refreshView').fire();                
            }
        });
        $A.enqueueAction(action);
        component.set("v.isDeletePopup", false);
    },
    
    callClone: function(component, event, helper) {
        
        var today = new Date();
       // var thisYear=component.get("v.current", auratTargetId);
        var previousYear=today.getFullYear();
        var ThisYear=today.getFullYear()+1;
        var auratTargetId = event.currentTarget.name;
        if(auratTargetId != undefined){
          // alert("auratTargetId"+auratTargetId);
            component.set("v.IdToClone", auratTargetId);
            var action = component.get("c.activityYearCheck");
            action.setParams({
                id : auratTargetId,
                previousYear : previousYear,
                ThisYear:ThisYear
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                   // alert(storeResponse);
                   // alert(storeResponse.Name);
                    if(storeResponse!=null){
                       // alert("Not in null");
                        component.set("v.ActivityNameToClone", storeResponse.Name);
                        component.set("v.isClonePopup", true);
                    }
                    else if(storeResponse==null){
                        //alert("in isClonePopup error");
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Error",
                            "message": "You can duplicate only previous year activities"
                        });
                        toastEvent.fire();
                    }
                }
             });
            $A.enqueueAction(action);
            
            
        }

        var currentuserId = $A.get("$SObjectType.CurrentUser.Id");
        var action1 = component.get("c.getCurrentContact");
        action1.setParams({
              id : currentuserId
        });
        action1.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                component.set("v.contactName", storeResponse);            
            }
        });
        $A.enqueueAction(action1);
        //console.log('id==>'+event.currentTarget.name);
    },
    closeCloneModal: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isClonePopup", false);
    },
    cloneDetails: function(component, event, helper) {
       var cloneRecid = component.get("v.IdToClone");
     //  alert('cloneRecid : '+cloneRecid);
       //var deleteRec = component.get("v.isDeleteActivity");
        console.log(cloneRecid);
        var action = component.get("c.activityClone");
        action.setParams({
              id : cloneRecid
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
             console.log('822==>'+state);
            // alert('Clne state==>'+state)
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Success",
                            "message": "Activity duplicated successfully."
                        });
                        toastEvent.fire();
                $A.get('e.force:refreshView').fire();                
            }
        });
        $A.enqueueAction(action);
        component.set("v.isClonePopup", false);
    },
    navigateDashboardPage:function (component, event, helper) {
        window.scrollTo(0, 700);
        component.set("v.showLoading",true);

        //var storeResponse =component.get("v.activitiySelected");
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: event.currentTarget.name
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                component.set("v.showLoading",false);
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                //  component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        component.set("v.isDashboardPage",true);    
        component.set("v.isLandingPage",false);
        component.set("v.isQuantitativePage",false);
        component.set("v.isQualitativePage",false);
        
        var AddcmpTarget = component.find('dashboard');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('landing');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Qualitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Quantitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        
    },
    navigateLandingPage:function (component, event, helper) {
        window.scrollTo(0, 950);
        component.set("v.showLoading",true);
        //var storeResponse =component.get("v.activitiySelected");
        //alert(event.currentTarget.name);
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: event.currentTarget.name
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                component.set("v.showLoading",false);
                console.log('85==>'+JSON.stringify(storeResponse));
                //  component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        component.set("v.isDashboardPage",false);    
        component.set("v.isLandingPage",true);
        component.set("v.isQuantitativePage",false);
        component.set("v.isQualitativePage",false);
        
        var AddcmpTarget = component.find('landing');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('dashboard');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Qualitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Quantitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
    }        
    ,   
    navigateQuantativePage:function (component, event, helper) {
        window.scrollTo(0, 750);
        component.set("v.showLoading",true);
        
        //var storeResponse =component.get("v.activitiySelected");
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: event.currentTarget.name
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                component.set("v.showLoading",false);
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                //component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        component.set("v.isDashboardPage",false);    
        component.set("v.isLandingPage",false);
        component.set("v.isQuantitativePage",true);
        component.set("v.isQualitativePage",false);
        
        var AddcmpTarget = component.find('Quantitative');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('dashboard');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Qualitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('landing');
        $A.util.removeClass(RemovecmpTarget, 'active');
    },
    navigateQualitativePage:function (component, event, helper) {
        window.scrollTo(0, 700);
        component.set("v.showLoading",true);
        
        //var storeResponse =component.get("v.activitiySelected");
        var action = component.get("c.showSelectedActivity");
        action.setParams({
            id: event.currentTarget.name
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('82==>'+state);
            if (state === "SUCCESS") {
                component.set("v.showLoading",false);
                var storeResponse = response.getReturnValue();
                console.log('85==>'+JSON.stringify(storeResponse));
                //component.set("v.activitiySelected",storeResponse);
                console.log('87==>'+component.get("v.activitiySelected"));
                var evt = $A.get("e.c:SelectedActivityEvent");
                evt.setParams({ "activitiyEventSelected": storeResponse});
                evt.fire();
                
            }
        });
        $A.enqueueAction(action);
        component.set("v.isDashboardPage",false);    
        component.set("v.isLandingPage",false);
        component.set("v.isQuantitativePage",false);
        component.set("v.isQualitativePage",true);
        
        var AddcmpTarget = component.find('Qualitative');
        $A.util.addClass(AddcmpTarget, 'active');
        var RemovecmpTarget = component.find('dashboard');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('Quantitative');
        $A.util.removeClass(RemovecmpTarget, 'active');
        var RemovecmpTarget = component.find('landing');
        $A.util.removeClass(RemovecmpTarget, 'active');
    },

    
})