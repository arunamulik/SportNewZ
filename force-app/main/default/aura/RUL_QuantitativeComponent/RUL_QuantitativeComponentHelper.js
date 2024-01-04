({
    fetchPickListVal: function(component, fieldName, elementId,cyear) { 
        //alert('hello');
        console.log('3==>');
        var action = component.get("c.getselectOptions");
        action.setParams({
            objectType: 'Activity__c',
            fieldName: 'HOP_Outcome__c',
            fyear:cyear
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('11==>'+state);
            /*var list = response.getReturnValue();
            console.log('13==>'+list);*/
            var ShowResultValue = component.get("v.activitiySelectedRecord");
            var actsRelatedHOP = [];
            var HOPoutcomeValueList = [];
            var list = response.getReturnValue();
            console.log('13==>'+JSON.stringify(list));
            for(var key in list){
                console.log('18==>**'+key);
                HOPoutcomeValueList.push(key);
                actsRelatedHOP.push({value:list[key], key:key});
            }
            console.log('23==>**'+HOPoutcomeValueList);
            for(var key in list){
                if(ShowResultValue!=undefined){
                    component.set("v.activitiySelected", ShowResultValue);
                    
                    var getDueDate=component.get("v.activitiySelected");
                    //set date format 
                    var getDueDateFormat=getDueDate.Due_Date__c;
                    //alert('getDueDateFormat'+getDueDateFormat);
                    var formattedDate =$A.localizationService.formatDate(getDueDateFormat, "dd/MM/yyyy");
                    component.set("v.FormattedDate", formattedDate);
                    //get today's date
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
                    var yyyy = today.getFullYear();
                    
                    today = yyyy + '-' +mm  + '-' +dd ;
                    //alert('date'+today);
                    if(getDueDateFormat < today){
                        component.set("v.isDueDatePassed",false);
                    }
                    else{
                        component.set("v.isDueDatePassed",true);    
                    }
                }
                else{
                    console.log('21==>'+JSON.stringify(list[key][0]));
                    component.set("v.activitiySelected",list[key][0]);
                    console.log('23==>'+component.get("v.activitiySelected"));
                    break; 
                }
            }
            //alert('30*****==>'+component.get("v.activitiySelected").Save_and_Complete_Question1__c);
            console.log('20==>'+JSON.stringify(actsRelatedHOP));
            component.set("v.activitiesRelatedtoHOP", actsRelatedHOP);
            component.set("v.picklistValuesHOPoutcome", HOPoutcomeValueList);
            
            /*component.set("v.HOPoutcomeVal1", list[0]);
            component.set("v.HOPoutcomeVal2", list[1]);
            component.set("v.HOPoutcomeVal3", list[2]);*/
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
        
    }
})