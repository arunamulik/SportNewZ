/*------------------------------------------------------------
Author:         Jack Tan
Company:        Davanti Consulting
Description:    Trigger on Measure__c
Test Class:     TestMeasureTriggerhandler

History
03-08-2017      JTan  Created
------------------------------------------------------------*/

trigger TrgMeasure on Measure__c (before insert, before update, after insert, after update, after delete, after undelete) {
     system.debug('RecursionHandler.getRunTimes  --------M---------------'+RecursionHandler.getRunTimes()+'-----Before--------------'+Trigger.isBefore+'---------Insert-------'+Trigger.isInsert+'----------------'  );
     system.debug('@Start--TrgMeasure CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
     if(Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)){
	     if(RecursionHandler.getRunTimes() < 16){
	         if(Trigger.isBefore)
	         MeasureTriggerhandler.updateOldRecordType(Trigger.new);
	      if(Trigger.isAfter) {
	        //system.debug('@1--TrgMeasure CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
	        //Update variation field for Measure varied
	        //MeasureTriggerhandler.updateVariation(Trigger.new);
	          //Pass Measure__c records to update Initiative__c.Pending_Measures__c begins
	          if(Trigger.isInsert || Trigger.isUndelete){
	              MeasureTriggerhandler.updateInitiative(Trigger.new);
	          }
	          if(Trigger.isDelete){
	              MeasureTriggerhandler.updateInitiative(Trigger.old);
	          }
	          if(Trigger.isUpdate){
	          	  MeasureTriggerhandler.updateVariation(trigger.newMap, Trigger.oldMap);
	              MeasureTriggerhandler.updateInitiative(Trigger.oldMap, Trigger.new);
	          }
	          //Pass Measure__c records to update Initiative__c.Pending_Measures__c ends
	      }
	      system.debug('@End--TrgMeasure CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
	        RecursionHandler.setRunTimes();
             system.debug('##TrgMeasure'+RecursionHandler.executionCount);
	     }
     }
}