({
    doInit : function(component, event, helper) {
        //alert('doint');
        var action = component.get("c.checkUserHasKahiwiAccess");
        
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            if (state === "SUCCESS") { 
                
                var hasAccess = response.getReturnValue(); 
                //alert(hasAccess);
                if(hasAccess==true){
                    window.location.href='https://sportnz.force.com/partners2';
                    /*var urlEvent = $A.get("e.force:navigateToURL");
                    
                    urlEvent.setParams({
                        "url": '../../partners'
                    }); 
                    urlEvent.fire();*/
                }
                else{
                    window.location.href='https://sportnz.force.com/SportNZ';
                }
            }
        });
        $A.enqueueAction(action);
    },
})