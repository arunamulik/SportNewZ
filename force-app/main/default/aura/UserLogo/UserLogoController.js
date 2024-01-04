({
	accesslogo : function(component, event, helper) {
		var action = component.get("c.fetchUserdata");
           action.setCallback(this, function(response) {
              var state = response.getState();
            if (state === "SUCCESS") {
                 var res = response.getReturnValue();
                // alert('8===>'+res.Partner_Logo__c);
            }
            component.set('v.Sportlogo', res);
        });
     
       $A.enqueueAction(action);
	}
})