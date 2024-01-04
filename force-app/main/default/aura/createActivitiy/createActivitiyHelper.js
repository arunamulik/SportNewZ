({
    fetchPickListVal: function (component, fieldName, elementId) {
        alert(component.get("v.picklistValuesHOPoutcome"));
        var action = component.get("c.getselectOptions");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: 'HOP_Outcome__c'
        });
        action.setCallback(this, function (response) {
            alert(component.get("v.picklistValuesHOPoutcome"));
            var state = response.getState();
            var actsRelatedHOP = [];
            var HOPoutcomeValueList = [];
            var list = response.getReturnValue();
            for (var key in list) {
                HOPoutcomeValueList.push(key);
            }
            component.set("v.picklistValuesHOPoutcome", HOPoutcomeValueList);
        })
        $A.enqueueAction(action);
    },

    fetchPickListValueAct: function (component) {

        var actionAct = component.get("c.getselectOption");

        actionAct.setParams({
            "objectType": "Activity__c",
            "fieldName": "HOP_Outcome__c"
        });

        actionAct.setCallback(this, function (response) {

            var state = response.getState();

            var actsRelatedHOP = [];
            //var HOPoutcomeValueList = [];
            var list1 = [];
            var list = response.getReturnValue();

            component.set("v.picklistValuesHOPoutcome", list);

        });

        $A.enqueueAction(actionAct);
    },

    fetchPickListValueRegion: function (component) {

        var actionAct = component.get("c.getselectOption");

        actionAct.setParams({
            "objectType": "Activity__c",
            "fieldName": "Region__c"
        });

        actionAct.setCallback(this, function (response) {

            var state = response.getState();

            var actsRelatedHOP = [];
            //var HOPoutcomeValueList = [];
            var list1 = [];
            var list = response.getReturnValue();

            component.set("v.picklistValuesRegion", list);

        });

        $A.enqueueAction(actionAct);
    },

    fetchPickListValueCOVID: function (component) {

        var actionAct = component.get("c.getselectOption");

        actionAct.setParams({
            "objectType": "Activity__c",
            "fieldName": "COVID_19_ALERT_LEVEL__c"
        });

        actionAct.setCallback(this, function (response) {
            var state = response.getState();
            var actsRelatedHOP = [];
            //var HOPoutcomeValueList = [];
            var list1 = [];
            var list = response.getReturnValue();

            component.set("v.picklistValuesCOVID", list);

        });

        $A.enqueueAction(actionAct);
    },

    fetchHOPOutcomeDomainvalue: function (component) {

        var actionAct = component.get("c.getselectOption");

        actionAct.setParams({
            "objectType": "Activity__c",
            "fieldName": "HOP_Outcome_Domain__c"
        });

        actionAct.setCallback(this, function (response) {
            var state = response.getState();
            var actsRelatedHOP = [];
            //var HOPoutcomeValueList = [];
            var list1 = [];
            var list = response.getReturnValue();

            component.set("v.HOPOutcomeDomainPicklist", list);

        });

        $A.enqueueAction(actionAct);
    },
    helperFun: function (component, event, secId, toggleId) {
        var acc = document.getElementById(secId);

        var toggleDiv = document.getElementById(toggleId);

        $A.util.toggleClass(acc, 'slds-hide');
        $A.util.toggleClass(toggleDiv, 'toggleDivclass');
        //$A.util.removeClass(acc, 'slds-hide');  
        var home = document.getElementsByClassName("cls");
        for (var i = 0; i < home.length; i++) {
            console.log(i + '--->' + home[i]);
            if (home[i].id != secId) {
                $A.util.addClass(home[i], 'slds-hide');
                //$A.util.toggleClass(toggleDiv, 'toggleDivclass'); 
                // $A.util.removeClass(home[i], 'slds-show');
            }
        }

    },
    getContact: function (component, event) {
        var action = component.get("c.getContact");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var userContact = response.getReturnValue();
                //alert(userContact);
                component.set("v.contactName", userContact);
                //alert(component.get("v.contactName"));
            }
        });
        $A.enqueueAction(action);
    },
    callServer: function (component, method, callback, params) {
       // alert('params : '+params);
        var action = component.get(method);
        console.log('callServer-params' + action);
        if (params) {
            action.setParams(params);
        }

        action.setCallback(this, function (response) {
            var state = response.getState();
           // alert('State : '+state);
            if (state === "SUCCESS") {
                // pass returned value to callback function
                callback.call(this, response.getReturnValue());
            } else if (state === "ERROR") {
                // generic error handler
                var errors = response.getError();
                if (errors) {
                    console.log("Errors", errors);
                    if (errors[0] && errors[0].message) {
                        throw new Error("Error" + errors[0].message);
                    }
                } else {
                    throw new Error("Unknown Error");
                }
            }
        });

        $A.enqueueAction(action);
    },
})