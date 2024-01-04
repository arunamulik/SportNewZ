trigger TrgBusinessCase on Business_Case__c(before insert, before update, after insert, after update) {
    public integer i = 0 ;
     if (Trigger.isUpdate && RecursionHandler.TrgInvestmentScheduleBypassUpdate)
        return;
    if (Trigger.isInsert && RecursionHandler.TrgInvestmentScheduleBypassInsert)
        return;
    if (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)) {
        if (RecursionHandler.getRunTimes() < 16) {
        //if(RecursionHandler.runOnce()){  
        //important debug
            system.debug('RecursionHandler.getRunTimes  --------IS ----------------Insert --------------------' + RecursionHandler.TrgInvestmentScheduleBypassInsert + '--------Update-----------------' + RecursionHandler.TrgInvestmentScheduleBypassUpdate);
           
            List < Business_Case__c > setTCList = new List < Business_Case__c > ();
            List < Business_Case__c > setStrategicAreaList = new List < Business_Case__c > ();
            List < Id > setExecutiveSummaryList = new List < Id > ();
            List < Id > updateInitiativesList = new List < Id > ();
            List < Id > lstOfInvestSchIds = new List < Id > ();

            if (Trigger.isAfter && Trigger.isInsert) {
                RecursionHandler.TrgInvestmentScheduleBypassInsert = true;
            }

            Set < Id > setBusinessCaseIds = new Set < Id > ();

            for (Business_Case__c i: trigger.new) {
                // New Changes Start..
                // Commented By Pallavi For SSE-16
                // Reason For comment nothing is affecting as the functionsetTermsAndConditions not updating any record
                // just consuming CPU time
                /*if (Trigger.isBefore && Trigger.isUpdate && i.T_Cs__c != trigger.OldMap.get(i.Id).T_Cs__c) {
                    setTCList.add(i);
                }*/

                if (Trigger.isBefore && (Trigger.isInsert || (Trigger.isUpdate && i.Investment_Area__c != trigger.OldMap.get(i.Id).Investment_Area__c))) {
                    setStrategicAreaList.add(i);
                }

              if (Trigger.isAfter && (Trigger.isInsert || (Trigger.isUpdate && i.Executive_Summary_Template__c != trigger.OldMap.get(i.Id).Executive_Summary_Template__c)))
                    setExecutiveSummaryList.add(i.Id);
                if (Trigger.isAfter && Trigger.isUpdate && i.Status__c != trigger.OldMap.get(i.Id).Status__c) {
                    updateInitiativesList.add(i.Id);
                }

                if (Trigger.isAfter && Trigger.isUpdate && i.Status__c != trigger.OldMap.get(i.Id).Status__c && i.Status__c == 'Signed') {
                    system.debug('In method');
                    lstOfInvestSchIds.add(i.id);
                    system.debug('lstOfInvestSchIds'+lstOfInvestSchIds);
                }

                if (Trigger.isAfter && (Trigger.isInsert || (Trigger.isUpdate && i.Strategic_Area__c != trigger.OldMap.get(i.Id).Strategic_Area__c))) {
                    setBusinessCaseIds.add(i.Id);
                }
            }
      //impoprtant debug
      system.debug('@4--TrgBusinessCase CPU Limits >>>>>>>>>>> ' + Limits.getCpuTime());
            
            if (setBusinessCaseIds.size() > 0 && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))) {
                BusinessCaseTriggerHandler.populateStrategicAreaOwner(setBusinessCaseIds);
            }

            /*if (setTCList.size() > 0 && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)))
                BusinessCaseTriggerHandler.setTermsAndConditions(setTCList);*/

            if (setStrategicAreaList.size() > 0 && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)))
                BusinessCaseTriggerHandler.setStrategicAreaOwner(setStrategicAreaList);

            if (setExecutiveSummaryList.size() > 0 && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)))
                BusinessCaseTriggerHandler.setExecutiveSummary(setExecutiveSummaryList);
                
            if (Trigger.isAfter && Trigger.isUpdate && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))) {
                //Added on 12 Dec 2018 as per SNIS-88 by RUL
                RecursionHandler.TrgInvestmentScheduleBypassUpdate = true;//changes done by Prajwal 25/1/2022
                 BusinessCaseTriggerHandler.updateInvestmentSchedule(Trigger.newMap, Trigger.oldMap);
                
                //RecursionHandler.TrgInvestmentScheduleBypassUpdate = true;changes done by Prajwal 25/1/2022
                // Added on 7th july 2015
                //RUL to make related Record Readonly or editable depending on status of investment schedule
                Boolean draftPaymentUpdated = BusinessCaseTriggerHandler.updateRelatedInitiativesToEditable(Trigger.newMap, Trigger.oldMap);
                system.debug('draftPaymentUpdated'+draftPaymentUpdated);
                if (!draftPaymentUpdated && (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit))) {
                   
                    BusinessCaseTriggerHandler.updatePaymentStatusToScheduled(Trigger.newMap);
                }
            }
            RecursionHandler.setRunTimes();
            system.debug('##TrgBusinessCase'+RecursionHandler.executionCount);
        } else {
            return;
        }
    } else {
        return;
    }
}