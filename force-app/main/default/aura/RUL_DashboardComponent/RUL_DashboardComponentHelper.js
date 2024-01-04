({
    fetchPickListVal: function(component, fieldName, elementId,cyear) {
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
                }
                else{
                   console.log('21==>'+JSON.stringify(list[key][0]));
                component.set("v.activitiySelected",list[key][0]);
                console.log('23==>'+component.get("v.activitiySelected"));
                break; 
                }
            }
            console.log('30*****==>'+component.get("v.activitiySelected").Save_and_Complete_Question1__c);
            if(component.get("v.activitiySelected").Save_and_Complete_Question1__c == true){
                component.set("v.disableAnswersOnSaveComplete1", true);
            }else if(component.get("v.activitiySelected").Save_and_Complete_Question2__c == true){
                component.set("v.disableAnswersOnSaveComplete2", true);
            }else if(component.get("v.activitiySelected").Save_and_Complete_Question3__c == true){
                component.set("v.disableAnswersOnSaveComplete3", true);
            }else if(component.get("v.activitiySelected").Save_and_Complete_Question4__c == true){
                component.set("v.disableAnswersOnSaveComplete4", true);
            }else if(component.get("v.activitiySelected").Save_and_Complete_Question5__c == true){
                component.set("v.disableAnswersOnSaveComplete5", true);
            }
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
    
 
    gettotalParticipantsValues: function(component, event, helper,cyear) {
        
        var action = component.get("c.get_TotalParticipants");
        action.setParams({fyear:cyear});
         console.log("hi i m in");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let val = response.getReturnValue();
                 var tot1=0;
                component.set("v.Activityitems",val);
                  for(var key in val){
                       tot1=val[key].Participation_NoOfParticipants__c+tot1;
                console.log("tot1"+JSON.stringify(tot1));
    
            }
              component.set("v.total_part",tot1);  
            }   
            })
            $A.enqueueAction(action);
        },
    
    getFemaleAndMaleValues: function(component, event, helper,cyear) {
        
        var action = component.get("c.get_MaleAndFemaleValues");
        action.setParams({fyear:cyear});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                 let val = response.getReturnValue() ;
                //var sample = response.getReturnValue() ;
                //var test = [];
                var labelset=[] ;
                var dataset=[] ;
                var namevalue=[];
              
               
               component.set("v.FemaleAndMaleValues",val);
                var g=component.get("v.FemaleAndMaleValues");
                
                console.log('h=======>'+JSON.stringify(val));
                
                
            }   
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
    getFemaleAndMalePercentValues: function(component, event, helper,cyear) {
        
       
        var action = component.get("c.get_MaleAndFemalePercentValues");
        action.setParams({fyear:cyear});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                 var rows = response.getReturnValue();   
                 var maleCount=[];
                var femaleCount=[];
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];                   
                    maleCount.push(row.GenderOfParticipants_Tane__c);
                    femaleCount.push(row.GenderOfParticipants_Wahine__c);
                    
        		}
                for (var maleTotal=0 ,i = 0; i < maleCount.length; i++){
                   maleTotal += maleCount[i];
                }
                for (var femaleTotal=0 ,i = 0; i < femaleCount.length; i++){

                   femaleTotal += femaleCount[i];
                }
                var TotalCount =maleTotal+femaleTotal;
                var totalMalePercent=(maleTotal/TotalCount)*100;
                 var totalfemalePercent =(femaleTotal/TotalCount)*100;               
                 var TotalMale=totalMalePercent.toPrecision(2) + '%';
                var TotalFemale=totalfemalePercent.toPrecision(2) + '%';
                //alert(TotalMale);
                if(TotalMale == '1.0e+2%'){
                    TotalMale='100%';
                }
                if(TotalFemale == '1.0e+2%'){
                    TotalFemale='100%';
                }
                if(TotalFemale == 'NaN%'){
                    TotalFemale = '0%';
                }
                if(TotalMale == 'NaN%'){
                    TotalMale='0%'; 
                }
    			component.set('v.feMalePercentValues',TotalFemale);
                component.set('v.MalePercentValues',TotalMale);

            }   
            })
            $A.enqueueAction(action);
        }
     
})