/*---------------------------------------------------------------------------------------------------------------------------
Description: This class is used for detail implementation of RUL_ParticipationDataTrigger

    =========================================================================================================================
        Version | Date(DD-MM-YYYY) | Last Modified By | Comments
    -------------------------------------------------------------------------------------------------------------------------
        1.0     | 18-11-2016       | Vivian Charlie   | 1. Created test class to test functionality of
                                                           RUL_ParticipationDataTrigger
	=========================================================================================================================
*/
public without sharing class RUL_ParticipationDataTriggerHandler {

    public void afterInsert(list<Participation_Data__c> lstNew){
        set<Id> setProgramId = new set<Id>();
        for(Participation_Data__c objPD : lstNew){
            if(objPD.Programme_Name__c != null){
                setProgramId.add(objPD.Programme_Name__c);
            }
        }
        if(!setProgramId.isEmpty()){
            rollupDetails(setProgramId);
        }
    }
    
    public void afterUpdate(map<Id,Participation_Data__c> mapNewMap, map<Id,Participation_Data__c> mapOLdMap){
        set<Id> setProgramId = new set<Id>();
        for(Participation_Data__c objPD : mapNewMap.values()){
            if(objPD.Total_Participants__c !=
            mapOLdMap.get(objPD.Id).Total_Participants__c || objPD.Financial_Year__c !=
            mapOLdMap.get(objPD.Id).Financial_Year__c){
                setProgramId.add(objPD.Programme_Name__c);
            }
        }
        if(!setProgramId.isEmpty()){
            rollupDetails(setProgramId);
        }
    }
    
    public void rollupDetails(set<Id> setIds){
        list<Participation_Activity_Profile_Data__c> lstToUpdate = new list<Participation_Activity_Profile_Data__c>();
        list<Participation_Activity_Profile_Data__c> lstPA = [Select 
                                                                p.Total_Participants_This_Year__c, 
                                                                p.Total_Participants_Previous_Year__c, 
                                                                p.Id, (
                                                                Select Id, 
                                                                Total_Participants__c, 
                                                                Programme_Name__c,
                                                                CreatedDate,
                                                                Financial_Year__c
                                                                From Participation_Data__r) 
                                                                From Participation_Activity_Profile_Data__c p
                                                                where p.Id IN : setIds];
        String currentFiscalYear = [SELECT FiscalYearSettings.Name FROM Period WHERE Type = 'Year' AND StartDate <= TODAY AND EndDate >= TODAY].FiscalYearSettings.Name;                                                        
        for(Participation_Activity_Profile_Data__c objPA : lstPA) {
            Decimal decPreviousYear = 0;
            Decimal decThisYear = 0;                       
            for(Participation_Data__c objPD : objPA.Participation_Data__r) {
            if(objPD.Financial_Year__c != NULL) {
                String strFinancialYear = objPD.Financial_Year__c;
                strFinancialYear = strFinancialYear.deleteWhitespace();
                system.debug('strFinancialYear '+strFinancialYear );
                String[] arrFinancialYear = strFinancialYear.split('-');
                system.debug('arrFinancialYear'+arrFinancialYear);
                
                    if(((integer.valueof(arrFinancialYear[1]) == integer.valueof(currentFiscalYear)))
                    && objPD.Total_Participants__c != null){
                        decThisYear = decThisYear + objPD.Total_Participants__c;
                    }
                    
                    if(((integer.valueof(arrFinancialYear[1]) == integer.valueof(currentFiscalYear)-1))
                    && objPD.Total_Participants__c != null){
                        decPreviousYear = decPreviousYear + objPD.Total_Participants__c;
                    }               
                }
            }
            objPA.Total_Participants_Previous_Year__c = decPreviousYear;
            objPA.Total_Participants_This_Year__c = decThisYear;
            
            lstToUpdate.add(objPA);
        }
        if(!lstToUpdate.isEmpty()){
            update lstToUpdate;
        }
    }
}