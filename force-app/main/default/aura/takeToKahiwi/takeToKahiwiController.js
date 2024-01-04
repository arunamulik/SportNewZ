({
    doInit : function(component, event, helper) {
        var action = component.get("c.checkUserHasKahiwiAccess");
        
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            if (state === "SUCCESS") { 
                
                var hasAccess = response.getReturnValue(); 
                //alert(hasAccess);
                component.set('v.hasKahiwiAccess',hasAccess); 
            }
        });
        $A.enqueueAction(action);
    },
    takeUserToKahiwi : function(component, event, helper) {
        window.location.href='https://sportnz.force.com/partners2';
        /*var urlEvent = $A.get("e.force:navigateToURL");
        
        urlEvent.setParams({
            "url": 'https://portdev-sportnz.cs5.force.com/partners'
        }); 
        urlEvent.fire();*/
    }
    // "url": '../../partners/s/'
    // "url": 'https://portdev-sportnz.cs5.force.com/partners'
})