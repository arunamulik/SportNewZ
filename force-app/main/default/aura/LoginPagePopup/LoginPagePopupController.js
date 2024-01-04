({
    openModel : function(component, event, helper) {
        component.set("v.isModalOpen",true);
        component.set("v.openPopup",false);
    },
    closeModel: function(component, event, helper) {        
        component.get("v.parent").closeModel();
    },
    doInit: function(component, event, helper) {  
        console.log('14==>');
        var action = component.get("c.isUserHasActivities");
        component.set("v.openPopup",false);
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('14==>'+state);
            var hasActivities = response.getReturnValue();
            console.log('83==>'+hasActivities);
            if(hasActivities) {
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": "/"
                }); 
                urlEvent.fire();
            } else {
                component.set("v.openPopup",true);
                helper.getContact(component,event);
                
            }
        })
        $A.enqueueAction(action);
		
    //component.set("v.openPopup",true);
},
 viewActivity : function (component, event, helper) {
    
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
    component.set("v.openPopup",false);
    action.setCallback(this, function(response) {
        var state = response.getState();
        console.log('14==>'+state);
        var hasActivities = response.getReturnValue();
        console.log('83==>'+hasActivities);
        if(hasActivities) {
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": "/"
            }); 
            urlEvent.fire();
        } else {
            component.set("v.openPopup",true);
            
        }
    })
    $A.enqueueAction(action);
    
}
})