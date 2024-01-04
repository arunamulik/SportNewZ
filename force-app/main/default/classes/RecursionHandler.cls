public class RecursionHandler {
    public Static Boolean TrgVariationBypass = false;
    public Static Boolean TrgInitiativeBypassBefore = false;
    public Static Boolean TrgInitiativeBypassAfter = false;
    public Static Boolean TrgInvestmentScheduleBypassInsert = false;
    public Static Boolean TrgInvestmentScheduleBypassUpdate = false;
    public Static Boolean TrgVariationBypassAfterUpdate = false;
    public Static Boolean TrgVariationBypassBeforeInsert = false;
    public Static Boolean TrgStrategicArea = false;
    public static Integer updateInitiative = 0;
    
    public static Integer executionCount = 0;
    public static integer getRunTimes(){
       system.debug('Inside RecursionHandler getRunTimes() method');

        return executionCount;
    }
        
    public static void setRunTimes(){
        system.debug('Inside RecursionHandler setRunTimes() method');

        executionCount++;
        system.debug('Inside RecursionHandler executionCount : '+executionCount);

    }
    
   
    
}