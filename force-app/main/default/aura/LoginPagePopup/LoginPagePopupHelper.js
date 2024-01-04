({
    getContact : function(component,event) {
        var action = component.get("c.getContact");
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            if (state === "SUCCESS") {
                var userContact = response.getReturnValue(); 
                //alert(userContact);
                component.set("v.contactName",userContact);
                //alert(component.get("v.contactName"));
            }
        });
        $A.enqueueAction(action);
    }
})