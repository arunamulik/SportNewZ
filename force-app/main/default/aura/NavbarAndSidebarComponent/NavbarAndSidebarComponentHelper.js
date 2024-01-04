({

    fetchPickListVal: function(component, fieldName, elementId,cyear) {
        console.log('3==>');
        var action = component.get("c.getselectOptions");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: 'HOP_Outcome__c',
            fyear: cyear
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('11==>'+state);
            /*var list = response.getReturnValue();
            console.log('13==>'+list);*/
            var actsRelatedHOP = [];
            var HOPoutcomeValueList = [];
            var list = response.getReturnValue();
            console.log('13==>'+JSON.stringify(list));
            component.set("v.showLoading",false);
            if(list!=null)
            {
            for(var key in list){
                console.log('18==>**'+key);
                HOPoutcomeValueList.push(key);
                actsRelatedHOP.push({value:list[key], key:key});
            }
            console.log('23==>**'+HOPoutcomeValueList);

            for(var key in list){
                console.log('21==>'+JSON.stringify(list[key][0]));
                component.set("v.activitiySelected",list[key][0]);
                console.log('2323==>'+JSON.stringify(component.get("v.activitiySelected")));
                break;
            }
            console.log('30*****==>'+component.get("v.activitiySelected").Save_and_Complete_Question1__c);
           
            console.log('20==>'+JSON.stringify(actsRelatedHOP));
            component.set("v.activitiesRelatedtoHOP", actsRelatedHOP);
            component.set("v.picklistValuesHOPoutcome", HOPoutcomeValueList);
            //component.set("v.isLandingPage",true);
            /*component.set("v.HOPoutcomeVal1", list[0]);
            component.set("v.HOPoutcomeVal2", list[1]);
            component.set("v.HOPoutcomeVal3", list[2]);*/
            }
            else
            {
                //alert('in else');
                component.set("v.activitiesRelatedtoHOP", null);
                var toastEvent = $A.get("e.force:showToast");
    			toastEvent.setParams({
        			"title": "No Activities",
        			"message": "There are no activities for selected year."
    			});
    			toastEvent.fire();
              // $A.get('e.force:refreshView').fire();
                //this.fetchpicklistvalall(component, fieldName, elementId);

            }
        })
        $A.enqueueAction(action);
    },

    
    fetchvideoOrImage: function(component, fieldName, elementId) {
        console.log('19==>');
        var action = component.get("c.getVideoOrImage");

        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('27***********==>'+state);
            var VideoURL = response.getReturnValue().split('==>');
            console.log('29==>'+VideoURL);

            component.set("v.VideoURL", VideoURL[0]);
            component.set("v.imageRichText", VideoURL[1]);
            component.set("v.PartnerLogoImage", VideoURL[2]);

        })
        $A.enqueueAction(action);
    },
    getByOrgGoverned: function(component, fieldName, elementId) {
        console.log('56==>');
        var action = component.get("c.getbyOrgGovernedPicklist");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('64==>'+state);
            var list = response.getReturnValue();
            console.log('66==>'+list);
            //component.find('activityOrgGovernedPicklist').set("v.options", list);
            component.set("v.ByOrgGoverned", list);


        })
        $A.enqueueAction(action);
    },
    getDiamensionScoreValues: function(component, fieldName, elementId) {
        console.log('56==>');
        var action = component.get("c.getbyOrgGovernedPicklist");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('64==>'+state);
            var list = response.getReturnValue();
            console.log('66==>'+list);
            //component.find('activityOrgGovernedPicklist').set("v.options", list);
            component.set("v.DiamensionScorePicklistValues", list);
            console.log('101==>'+component.get("v.DiamensionScorePicklistValues"));
            console.log('101==>'+component.get("v.activitiySelected"));
            // $('#score1').niceSelect();
            /*var $select = $('#score1');
            var $dropdown = $select.next();
            var $options = $select.find('option');
            var $selected = $select.find('option:selected');

            $dropdown.find('.current').html($selected.data('display') || $selected.text());

            $options.each(function(i) {
                var $option = $(this);
                var display = $option.data('display');

                $dropdown.find('ul').append($('<li></li>')
                                            .attr('data-value', $option.val())
                                            .attr('data-display', (display || null))
                                            .addClass('option' +
                                                      ($option.is(':selected') ? ' selected' : '') +
                                                      ($option.is(':disabled') ? ' disabled' : ''))
                                            .html($option.text())
                                           );
            });
           */
        })
        $A.enqueueAction(action);
    },
    getByActivityGMDGoverned: function(component, fieldName, elementId) {
        console.log('75==>');
        var action = component.get("c.getbyOrgGovernedPicklist");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('83==>'+state);
            var list = response.getReturnValue();
            console.log('85==>'+list);
            component.set("v.ActivityGMD", list);
            /*component.set("v.HOPoutcomeVal1", list[0]);
                        component.set("v.HOPoutcomeVal2", list[1]);
                        component.set("v.HOPoutcomeVal3", list[2]);*/
        })
        $A.enqueueAction(action);
    },
    getThroughTypeOfActivityPicklist: function(component, fieldName, elementId) {
        console.log('75==>');
        var action = component.get("c.getbyOrgGovernedPicklist");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('83==>'+state);
            var list = response.getReturnValue();
            console.log('85==>'+list);
            component.set("v.ThroughTypeOfActivityPicklistValues", list);
            /*component.set("v.HOPoutcomeVal1", list[0]);
            component.set("v.HOPoutcomeVal2", list[1]);
            component.set("v.HOPoutcomeVal3", list[2]);*/
        })
        $A.enqueueAction(action);
    },
    getInOnActivitiesPicklist: function(component, fieldName, elementId) {
        console.log('75==>');
        var action = component.get("c.getbyOrgGovernedPicklist");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('83==>'+state);
            var list = response.getReturnValue();
            console.log('85==>'+list);
            component.set("v.InOnActivitiesPicklistValues", list);
            /*component.set("v.HOPoutcomeVal1", list[0]);
            component.set("v.HOPoutcomeVal2", list[1]);
            component.set("v.HOPoutcomeVal3", list[2]);*/
        })
        $A.enqueueAction(action);
    },
    getSignificanceLocationPicklist: function(component, fieldName, elementId) {
        console.log('75==>');
        var action = component.get("c.getbyOrgGovernedPicklist");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('83==>'+state);
            var list = response.getReturnValue();
            console.log('85==>'+list);
            component.set("v.SignificanceLoactionPicklistValues", list);
            /*component.set("v.HOPoutcomeVal1", list[0]);
            component.set("v.HOPoutcomeVal2", list[1]);
            component.set("v.HOPoutcomeVal3", list[2]);*/
        })
        $A.enqueueAction(action);
    },
    getUseOfTeReoPickilist: function(component, fieldName, elementId) {
        console.log('75==>');
        var action = component.get("c.getbyOrgGovernedPicklist");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('83==>'+state);
            var list = response.getReturnValue();
            console.log('85==>'+list);
            component.set("v.UseOfTeReoPickilistValues", list);
            /*component.set("v.HOPoutcomeVal1", list[0]);
            component.set("v.HOPoutcomeVal2", list[1]);
            component.set("v.HOPoutcomeVal3", list[2]);*/
        })
        $A.enqueueAction(action);
    },
    getPurposeOfTeReoPickilist: function(component, fieldName, elementId) {
        console.log('75==>');
        var action = component.get("c.getbyOrgGovernedPicklist");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: fieldName
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('83==>'+state);
            var list = response.getReturnValue();
            console.log('181==>'+list);
            component.set("v.PurposeOfTeReoPickilistValues", list);
            console.log('183==>'+component.get("v.PurposeOfTeReoPickilistValues"));
            /*component.set("v.HOPoutcomeVal1", list[0]);
            component.set("v.HOPoutcomeVal2", list[1]);
            component.set("v.HOPoutcomeVal3", list[2]);*/
        })
        $A.enqueueAction(action);
    },
    helperFun : function(component,event,secId, toggleId) {
        var acc = document.getElementById(secId);

        var toggleDiv = document.getElementById(toggleId);

        $A.util.toggleClass(acc, 'slds-hide');
        $A.util.toggleClass(toggleDiv, 'toggleDivclass');
        //$A.util.removeClass(acc, 'slds-hide');
        var home = document.getElementsByClassName("cls");
        for(var i=0;i<home.length;i++)
        {
            console.log(i+'--->'+home[i]);
            if(home[i].id != secId)
            {
                $A.util.addClass(home[i], 'slds-hide');
                //$A.util.toggleClass(toggleDiv, 'toggleDivclass');
                // $A.util.removeClass(home[i], 'slds-show');
            }
        }

    },
   setBackGroundImage: function(component,event,helper) {
        //component.set('v.backgroundImageURL', '/resource/1580108985000/image_main');
        var action = component.get("c.fetchBGImage");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                 //alert('8===>'+JSON.stringify(res));
                 component.set('v.backgroundImageURL', res);
                //alert(JSON.stringify(component.get('v.backgroundImageURL.Landing_Hero_Image__c')) );
                if(component.get('v.backgroundImageURL.Landing_Hero_Image__c') == undefined){
                    //alert('blank');
                    this.setDefaultBackGroundImage(component,event,helper);
                }
            }
            else{
                //alert('error');
                this.setDefaultBackGroundImage(component,event,helper);
            }

        });
        $A.enqueueAction(action);

    },
    setDefaultBackGroundImage: function(component,event,helper) {
        //alert('setDefaultBackGroundImage');

        var action = component.get("c.fetchDefaultBGImage");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                 component.set('v.backgroundImageURL', res);
            }

        });

        $A.enqueueAction(action);
        },
    setProfileImage: function(component,event,helper) {
         var action = component.get("c.userProfilePhoto");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                 component.set('v.userProfilePhoto', res);
            }

        });

        $A.enqueueAction(action);
    }



})