global class InitiativeStatusChangeScheduler implements Schedulable{

    public static String croneStr = '0 0 20-8 ? * * *';  //execute after NZ working hours 

    global static String scheduleBatch() {
        InitiativeStatusChangeScheduler SC = new InitiativeStatusChangeScheduler(); 
        return System.schedule('Initiative Job', croneStr, SC);
    }

    global void execute(SchedulableContext sc) {

        InitiativeStatusChangeBatch iniJob = new InitiativeStatusChangeBatch();
        ID batchprocessid = Database.executeBatch(iniJob,100);    
        system.debug('batchprocessid >>>>>>>>>> '+batchprocessid);       
    }
     
}