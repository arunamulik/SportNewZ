public class DedupePayments {
    
        @InvocableMethod(label = 'SendInitiativeCollection GetDedupedPayments'
                     description = 'returns Deduped Requirement Collection.')
    
    
    public static void getDedupedPayments(List<List< Initiative__c >> InitiativePayments) {
        
        System.debug('InitiativeRequirements###'+InitiativePayments);
        List<InitiativePayment__c> listtoaddIR=new List<InitiativePayment__c>();
        List<AggregateResult> paymentList = new List<AggregateResult>();
        List<Id> initiativeIdForPayment=new List<Id>();
        List < Initiative__c > deduped = new List <Initiative__c> ();
        Initiative__c dedupedRequirements = new Initiative__c ();
        Date MyDate,theDate;
        String myString;
        List<RequirementInitiative__c> rilistdEL=new List<RequirementInitiative__c>();//new
        //checking for duplicates
        List<Initiative__c> rilist=new List<Initiative__c>();//new
        Map<Id,Initiative__c> maprilist=new Map<Id,Initiative__c>();//new
        
        
        Set<Id> initiativeIds=new Set<Id>();
        for (List<Initiative__c> ReqObj: InitiativePayments) {
           for (Initiative__c innerReq: ReqObj) {
            System.debug('innerReq###'+innerReq);
                initiativeIds.add(innerReq.Id);
            
        }
        }
        
        // Foreach iterate over the collection
        for (List<Initiative__c> ReqObj: InitiativePayments) {
            
            //System.debug('ReqObj###'+ReqObj.size());
            
            Map < String, Initiative__c > names = new Map < String, Initiative__c > ();
            Id checkReqId;
             for (Initiative__c innerReq: ReqObj) {
                initiativeIdForPayment.add(innerReq.Id);
             }
        
            
            //code for inserting in InitiativePayment object---IPC Start
            
            List<InitiativePayment__c> iplist=new List<InitiativePayment__c>();
            iplist=[select Id, Initiative__c from InitiativePayment__c where Initiative__c IN: initiativeIds];//new
            if(!iplist.isEmpty())
            {
                System.debug('**iplist :- '+iplist );
                delete iplist;
            }
            
            paymentList = [select Initiative__c, 
                           Financial_Year__c, 
                           sum(Amount__c) Amt 
                           from Payment__c 
                           where Initiative__c IN: initiativeIdForPayment 
                           Group By Initiative__c,Financial_Year__c ];
            System.debug('List Values ******'+ paymentList);
            Map<Id,AggregateResult> paymap=new Map<Id,AggregateResult>();
            
            
            
            System.debug('Map Values ******'+ paymap);
            for(AggregateResult a:paymentList)
            {
                listtoaddIR.add(
                    new InitiativePayment__c(
                        Initiative__c=(ID)a.get('Initiative__c'),
                        Financial_Year__c=(String)a.get('Financial_Year__c'),
                        Amount__c=(decimal)a.get('Amt')
                    )
                );
            }
            
            
            insert listtoaddIR;
            //Added by Prajwal : to delete the RequirementInitiative records if there are no requirements
            rilistdEL=[select Id, Initiative__c from RequirementInitiative__c where Initiative__c IN: initiativeIds];//new
            if(!rilistdEL.isEmpty())
            {
                System.debug('**rilistdEL :- '+rilistdEL );
                delete rilistdEL;
            }
            //IPC End
        }
        
    }

}