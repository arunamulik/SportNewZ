({
	doInit : function(component, event, helper) {
        
        var action = component.get("c.checkUserHasAccessToTWR");
        
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            if (state === "SUCCESS") { 
                //alert('hello');
                var hasAccess = response.getReturnValue(); 
                //alert(hasAccess);
				if(hasAccess==true){
                    window.location.href='https://sportnz.force.com/SportNZ'; 
                }
                else{
                  component.set("v.isError",true);
                component.set("v.Error","You do not have access to TWR Community");  
            }
            }
        });
        $A.enqueueAction(action);
    },
})