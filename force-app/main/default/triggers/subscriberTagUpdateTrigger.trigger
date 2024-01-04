trigger subscriberTagUpdateTrigger on Subscriber__c (before insert,before update, after update) {
    if(trigger.isbefore){
        if(trigger.isInsert){
            system.debug('in insert');
            
            HelperClassSubscriberTagsUpdate.beforeInsertFunction(trigger.new);
        }
        if(trigger.isupdate){
            system.debug('in Update');
            System.debug('Trigger.new : '+Trigger.new);
            system.debug('Trigger.oldmap : '+trigger.oldMap);
            HelperClassSubscriberTagsUpdate.beforeUpdate(Trigger.new,Trigger.oldMap);
            //HelperClassSubscriberTagsUpdate.updatedfunction(Trigger.new[0],trigger.old[0]);
            
        } 
    }
        if(trigger.isafter){
            if(trigger.isUpdate){
                HelperClassSubscriberTagsUpdate.afterUpdate(trigger.new);
            }
        }
        
    }