({
    doInit: function (component, event, helper) {
        var activitiyEventSelectedID = event.getParam("activitiyEventSelectedID");
        component.set("v.recordId", activitiyEventSelectedID);
        var activitiyEventSelectedID = component.get("v.recordId");
        //alert(activitiyEventSelectedID);
        if (activitiyEventSelectedID != undefined) {
            var action = component.get("c.showSelectedActivity");
            action.setParams({
                id: activitiyEventSelectedID
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                console.log('82==>' + state);
                if (state === "SUCCESS") {
                    var storeResponse = response.getReturnValue();
                    component.set("v.newActivity", storeResponse);
                }
            });
            $A.enqueueAction(action);
        } else {
            helper.getContact(component, event);
            //helper.fetchPickListVal(component, 'HOP_Outcome__c', 'HOPoutcomePicklist');
            helper.fetchPickListValueAct(component); //, 'HOP_Outcome__c', 'list'
            helper.fetchPickListValueCOVID(component);
            helper.fetchHOPOutcomeDomainvalue(component);
            helper.fetchPickListValueRegion(component);
        }

    },
    
    onselectHandle : function(component, event, helper) {
    
        var hoplist=component.find("HOPoutcomePicklist").get("v.value");
        if(hoplist=='1.1 Kaiwhakahaere participating as Leaders in their community' || hoplist=='1.2 Increased Māori Sports Management capcity - leveraging potential and capacity' || hoplist=='1.3 Increased Māori Sports Leadership sustaining Māori success')
        {
            component.set("v.newActivity.HOP_Outcome_Domain__c",'Leaders for the future');
        }
        else if(hoplist=='2.1 Increased opportunities to participate in sport and traditional physical recreation' || hoplist=='2.2 Increased demand for Māori and non-Māori communities for opportunities to participate in Māori-led sport and traditional physical recreation'|| hoplist=='2.3 Increased opportunities for Māori and non-Māori to perform and excel in Māori sport and traditional physical recreation')
            component.set("v.newActivity.HOP_Outcome_Domain__c",'Developing participation opportunities');
        else 
            component.set("v.newActivity.HOP_Outcome_Domain__c",'Strengthening infrastructure');
    },
    
    getCitiesCommunities: function(component, event, helper) {

        console.log('getCities');
        var params = {
            "input": component.get('v.location')
        }

        helper.callServer(component, "c.getSuggestionsCommunity", function(response) {
            var resp = JSON.parse(response);
            console.log('Json parse---');
            console.log(resp.predictions);
            component.set('v.predictions', resp.predictions);
        }, params);

    },
    getCityDetailsCommunities: function(component, event, helper) {

        var selectedItem = event.currentTarget;
        var placeid = selectedItem.dataset.placeid;

        var params = {
            "placeId": placeid
        }

        helper.callServer(component, "c.getPlaceDetailsCommunity", function(response) {
            var placeDetails = JSON.parse(response);
            console.log('Json print');
            console.log(placeDetails);

            component.set('v.location', placeDetails.result.name);
            var streetConcatinate = '';
            var fullAddress = '';

            for (var i = 0; i < placeDetails.result.address_components.length; i++) {
                console.log('JSON Response****');

                if(placeDetails.result.address_components[i].types[0] == "sublocality_level_1"){
                      streetConcatinate += ' ' + placeDetails.result.address_components[i].long_name;
                      fullAddress += ' ' + placeDetails.result.address_components[i].long_name;
                      console.log('1');
                      console.log(streetConcatinate);
                }
                if (placeDetails.result.address_components[i].types[0] == "street_number") {
                    streetConcatinate += ' ' + placeDetails.result.address_components[i].long_name;
                    fullAddress += ' ' + placeDetails.result.address_components[i].long_name;
                    console.log('2');
                    console.log(streetConcatinate);
                }
                if (placeDetails.result.address_components[i].types[0] == "route") {
                    streetConcatinate += ' ' + placeDetails.result.address_components[i].long_name;
                    fullAddress += ' ' + placeDetails.result.address_components[i].long_name;
                    console.log('3');
                    console.log(streetConcatinate);
                }

                if (placeDetails.result.address_components[i].types[0] == "locality") {
                    component.set("v.newActivity.City__c", placeDetails.result.address_components[i].long_name);
                    fullAddress += ' ' + placeDetails.result.address_components[i].long_name;
                }
                if (placeDetails.result.address_components[i].types[0] == "administrative_area_level_1") {
                    component.set("v.newActivity.State__c", placeDetails.result.address_components[i].long_name);
                    fullAddress += ' ' + placeDetails.result.address_components[i].long_name;
                }
                if (placeDetails.result.address_components[i].types[0] == "country") {
                    component.set("v.newActivity.Country__c", placeDetails.result.address_components[i].long_name);
                    fullAddress += ' ' + placeDetails.result.address_components[i].long_name;
                }
                if (placeDetails.result.address_components[i].types[0] == "postal_code") {
                    component.set("v.zip", placeDetails.result.address_components[i].long_name);
                    fullAddress += ' ' + placeDetails.result.address_components[i].long_name;
                }
            }
            
            var location = placeDetails.result.geometry.location;
            component.set("v.newActivity.Latitude__c", location.lat.toString());
            component.set("v.newActivity.Longitude__c", location.lng.toString());
            
            console.log('*********streetConcatinate***');
            console.log(streetConcatinate);
            if (streetConcatinate != null) {
                component.set("v.newActivity.Street__c", streetConcatinate);
                component.set("v.address", fullAddress);
            }

            component.set('v.predictions', []);
        }, params);
    },
    closeModel: function (component, event, helper) {
        component.get("v.parent").closeModel();
    },
    gotoStep2: function (component, event, helper) {
        var Activity = component.get("v.newActivity");
        // var selectedLookUpRecord = component.get("v.selectedLookUpRecord");


        if (Activity.Name == undefined || Activity.Name == '') {
            component.set("v.errormsg", 'Activity name should not be blank.');
        } else if (Activity.HOP_Outcome__c == '--None--' || Activity.HOP_Outcome__c == '') {
            component.set("v.errormessage", 'Activity HOP Outcome should not be blank.');
        } else {
            component.set("v.errormessage", '');
            component.set("v.firstStepActivityWizard", false);
            component.set("v.secondStepActivityWizard", true);
        }
        /* if(selectedLookUpRecord== null){
             component.set("v.errormessage1", 'Please Select Initiative Name.');
         }
         else{
             //component.set("v.errormessage1", '');
             component.set("v.firstStepActivityWizard", false);
             component.set("v.secondStepActivityWizard", true); 
         }*/



    },
    goBacktoStep1: function (component, event, helper) {
        component.set("v.secondStepActivityWizard", false);
        component.set("v.firstStepActivityWizard", true);
    },
    goBacktoStep2: function (component, event, helper) {
        component.set("v.thirdStepActivityWizard", false);
        component.set("v.secondStepActivityWizard", true);
    },
    gotoStep3: function (component, event, helper) {
        component.set("v.secondStepActivityWizard", false);
        component.set("v.thirdStepActivityWizard", true);
    },
    gotoStep4: function (component, event, helper) {
        
        component.set("v.thirdStepActivityWizard", false);
        component.set("v.fourthStepActivityWizard", true);
    },
    gotoStep5: function (component, event, helper) {
        var Activity = component.get("v.newActivity");

        if (Activity.Event_Organiser_First_Name__c == undefined || Activity.Event_Organiser_First_Name__c == '') {
            component.set("v.errormsgfirstname", 'Event Organizer first name should not be blank.');
        } else if (Activity.Event_Organiser_Last_Name__c == undefined || Activity.Event_Organiser_Last_Name__c == '') {
            component.set("v.errormsgfirstname", '');
            component.set("v.errormsglastname", 'Event Organizer last name should not be blank.');
        } else if (Activity.Event_Organiser_Email__c == undefined || Activity.Event_Organiser_Email__c == '') {
            component.set("v.errormsglastname", '');
            component.set("v.errormsgemail", 'Event Organizer email should not be blank.');
        } else if (Activity.Event_Description__c == undefined || Activity.Event_Description__c == '') {
            component.set("v.errormsgemail", '');
            component.set("v.errormsgdescription", 'Event description should not be blank.');
        } else if (Activity.Activity_Start_Date_Time__c == undefined || Activity.Activity_Start_Date_Time__c == '') {
            component.set("v.errormsgdescription", '');
            component.set("v.errormsgstartdate", 'Event start date/time should not be blank.');
        } else if (Activity.Activity_End_Date_Time__c == undefined || Activity.Activity_End_Date_Time__c == '') {
            component.set("v.errormsgstartdate", '');
            component.set("v.errormsgenddate", 'Event end date/time should not be blank.');
        } else {
            component.set("v.errormsgenddate", '');
            component.set("v.errormsglastname", '');
            component.set("v.errormsgemail", '');
            component.set("v.errormsgdescription", '');
            component.set("v.errormsgstartdate", '');
            component.set("v.errormsgfirstname", '');
            component.set("v.fourthStepActivityWizard", false);
            component.set("v.fifthStepActivityWizard", true);
        }
        
    },
    goBacktoStep3: function (component, event, helper) {
        component.set("v.fourthStepActivityWizard", false);
        component.set("v.thirdStepActivityWizard", true);
    },
    goBacktoStep4: function (component, event, helper) {
        component.set("v.fifthStepActivityWizard", false);
        component.set("v.fourthStepActivityWizard", true);
    },
    saveAndgotoStep1: function (component, event, helper) {
        var newActivity = component.get("v.newActivity");
        console.log('36==>' + newActivity);
        var action = component.get("c.saveActivity");
        action.setParams({
            "act": newActivity
        });
        action.setCallback(this, function (a) {
            var state = a.getState();
            console.log('42==>' + state);
            if (state === "SUCCESS") {
                var name = a.getReturnValue();
                console.log('hello from here' + JSON.stringify(name));
                //component.set("v.isModalOpen", false);
                //window.location.reload();
                component.set("v.thirdStepActivityWizard", false);
                component.set("v.firstStepActivityWizard", true);
                //component.find('activityName').set("v.value", "");
                // component.find('activityDesc').set("v.value", "");
                //component.find('activityExpectDesc').set("v.value", "");
                //console.log('53==>'+component.find('activityName').get("v.value"));

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
    submitDetails: function (component, event, helper) {
        var newActivity = component.get("v.newActivity");
        console.log(JSON.stringify(newActivity));
        
        if (newActivity.Region__c == undefined || newActivity.Region__c == '') 
            component.set("v.errormsgregion", 'Region should not be blank.');
        
        
        //alert(JSON.stringify(newActivity));
        //set the default Initiative__c is null 
        //newActivity.Initiative__c = null ; 
        // check if selectedLookupRecord is not equal to undefined then set the Initiative__c  

        /*if(component.get("v.selectedLookUpRecord").Id != undefined){
            newActivity.Initiative__c = component.get("v.selectedLookUpRecord").Id;
        }*/
        /*if(component.get("v.selectedLookUpRecord") == null){
            newActivity.Initiative__c = null ; 
        }
        else if(component.get("v.selectedLookUpRecord").Id != undefined){
             newActivity.Initiative__c = component.get("v.selectedLookUpRecord").Id;
        }*/

        //alert(JSON.stringify(newActivity));
        else{
            component.set("v.errormsgregion",'');
        var action = component.get("c.saveActivity");
        action.setParams({
            "act": newActivity
        });
        action.setCallback(this, function (a) {
            var state = a.getState();

            if (state === "SUCCESS") {
                var name = a.getReturnValue();

                console.log('Success');

                //component.set("v.isModalOpen", false);
                component.set("v.isSubmitted", true);
                component.set('v.newActivity', name);
                var evt = $A.get("e.c:CreateActivityEvent");
                evt.setParams({
                    "CreateActivity": name
                });
                evt.fire();
                //window.location.reload();
                //component.find('activityName').set("v.value", "");
                //console.log('53==>'+component.find('activityName').get("v.value"));
            } else {
                console.log('state' + state);
                var errors = a.getError();
                console.log('Errors ' + JSON.stringify(errors));                
            }

        });
        $A.enqueueAction(action)
    }
    },

    viewActivityInInnperPage: function (component, event, helper) {
        console.log('82-->' + JSON.stringify(component.get('v.newActivity')));
        console.log('v.parent==>' + component.get("v.parent"));

        component.get("v.parent").set('v.newActivity', component.get('v.newActivity'));
        component.get("v.parent").viewActivity();
        component.get("v.parent").closeModel();

        var activityDetails = component.get('v.newActivity');
        var evt = $A.get("e.c:SelectedActivityEvent");
        evt.setParams({
            "activitiyEventSelected": activityDetails
        });
        evt.fire();

        var childComp = component.find('childComp');
        childComp.callChild();

    },
    viewActivity: function (component, event, helper) {
        /*var activityDetails = component.get('v.newActivity');
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
        helper.helperFun(component,event, activityDetails.Id, 'toggleDiv'+activityDetails.Id );*/
        var action = component.get("c.isUserHasActivities");
        component.set("v.openPopup", false);
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('14==>' + state);
            var hasActivities = response.getReturnValue();
            console.log('83==>' + hasActivities);
            if (hasActivities) {
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"
                });
                urlEvent.fire();
            } else {
                component.set("v.openPopup", true);

            }
        })
        $A.enqueueAction(action);

    },
    linkToRedirectToLanding: function (component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/"
        });
        urlEvent.fire();
    },
    onChangePicklist: function (component, event, helper) {
        var Activity = component.get("v.newActivity");
        if (Activity.Name != undefined || Activity.Name != null) {
            component.set("v.errormsg", '');
        }
        if (Activity.HOP_Outcome__c != '--None--' || Activity.HOP_Outcome__c != '') {
            component.set("v.errormessage", '');

        }
    }
})