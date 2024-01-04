public class DedupeRequirements {
 /*   
    @InvocableMethod(label = 'SendRequirementCollection GetDedupedRequirements'
                     description = 'returns Deduped Requirement Collection.')
    
    
    public static List < List < RequirementInitiative__c >> getDedupedRequirements(List<List< RequirementInitiative__c >> InitiativeRequirements) {
        
        //System.debug('InitiativeRequirements###'+InitiativeRequirements.size())
        List<InitiativePayment__c> listtoaddIR=new List<InitiativePayment__c>();
        List<AggregateResult> paymentList = new List<AggregateResult>();
        List<Id> initiativeIdForPayment=new List<Id>();
        List < List < RequirementInitiative__c >> deduped = new List < List <RequirementInitiative__c>> ();
        List < RequirementInitiative__c > dedupedRequirements = new List < RequirementInitiative__c > ();
        Date MyDate,theDate;
        String myString;
        
        //checking for duplicates
        List<RequirementInitiative__c> rilist=new List<RequirementInitiative__c>();//new
        Map<Id,RequirementInitiative__c> maprilist=new Map<Id,RequirementInitiative__c>();//new
        List<InitiativePayment__c> iplist=new List<InitiativePayment__c>();
        
        Set<Id> initiativeIds=new Set<Id>();
        for (List <RequirementInitiative__c> ReqObj: InitiativeRequirements) {
            for (RequirementInitiative__c innerReq: ReqObj) {
                
                initiativeIds.add(innerReq.Initiative__c);
            }
            
        }
        //Changes by Prajwal 6/10/2022
        iplist=[select Id, Initiative__c from InitiativePayment__c where Initiative__c IN: initiativeIds];//new
        rilist=[select Id, Initiative__c from RequirementInitiative__c where Initiative__c IN: initiativeIds];//new
        
        if(!rilist.isEmpty())
        {
            System.debug('**rilist :- '+rilist );
            delete rilist;
        }
        
        
        // Foreach iterate over the collection
        for (List <RequirementInitiative__c> ReqObj: InitiativeRequirements) {
            
            //System.debug('ReqObj###'+ReqObj.size());
            
            Map < String, RequirementInitiative__c > names = new Map < String, RequirementInitiative__c > ();
            Id checkReqId;
            //List<String> names=new List<String>();
            
            System.debug('Mapril****'+maprilist);
            System.debug('NamesForNull****'+names);
            System.debug('ReqObj****'+ReqObj);
            for (RequirementInitiative__c innerReq: ReqObj) {
                
                system.debug('innerReq###' + innerReq);
                //System.debug('dedupedRequirements###'+dedupedRequirements);
                System.debug('NAmes****'+names);
                
                if (names.isEmpty()) {
                    
                    names.put(String.ValueOf(innerReq.Requirement_Name__c), innerReq);
                    MyDate=names.get(innerReq.Requirement_Name__c).Due_Date__c;
                    names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=String.valueOf(DateTime.newInstance(MyDate.year(),MyDate.month(),MyDate.day()).format('d MMM yyyy'));
                    names.get(innerReq.Requirement_Name__c).Status_Combine__c=names.get(innerReq.Requirement_Name__c).Status__c;
                    
                } else if (!names.containsKey(innerReq.Requirement_Name__c)) {
                    
                    names.put(String.ValueOf(innerReq.Requirement_Name__c), innerReq);
                    
                    MyDate=names.get(innerReq.Requirement_Name__c).Due_Date__c;
                    
                    //names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=String.valueOf(names.get(innerReq.Requirement_Name__c).Due_Date__c);
                    names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=String.valueOf(DateTime.newInstance(MyDate.year(),MyDate.month(),MyDate.day()).format('d MMM yyyy'));
                    names.get(innerReq.Requirement_Name__c).Status_Combine__c=names.get(innerReq.Requirement_Name__c).Status__c;
                    
                } else if (names.containsKey(innerReq.Requirement_Name__c)) {
                    
                    checkReqId = names.get(innerReq.Requirement_Name__c).Requirement__c;
                    
                    
                    if (innerReq.Requirement__c != checkReqId) {
                        
                        MyDate=innerReq.Due_Date__c;
                        //names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=String.valueOf(names.get(innerReq.Requirement_Name__c).Due_Date__c);
                        names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c+'\n'+String.valueOf(DateTime.newInstance(MyDate.year(),MyDate.month(),MyDate.day()).format('d MMM yyyy')); 
                       names.get(innerReq.Requirement_Name__c).Status_Combine__c=names.get(innerReq.Requirement_Name__c).Status_Combine__c+'\n'+innerReq.Status__c;
                        
                        innerReq.Requirement_Name__c = null;
                        innerReq.Description__c = null;
                        //dedupedRequirements.add(innerReq);
                    }
                    // names.put(String.ValueOf(innerReq.Requirement_Name__c), innerReq);
                    
                }                    
                //*********************** Code for RequirementPayment *****************************
                
                initiativeIdForPayment.add(innerReq.Initiative__c);
                
                
            }
            
            dedupedRequirements.addall(names.values());
            deduped.add(dedupedRequirements);
            
            //code for inserting in InitiativePayment object---IPC Start
            
            
            
            if(!rilist.isEmpty())
            {
                System.debug('**iplist :- '+iplist );
                delete iplist;
            }
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
            //IPC End
        
        return deduped;
        
    }
  */  
    @InvocableMethod(label = 'SendRequirementCollection GetDedupedRequirements'
                     description = 'returns Deduped Requirement Collection.')
    
    
    public static List < List < RequirementInitiative__c >> getDedupedRequirements(List<List< RequirementInitiative__c >> InitiativeRequirements) {
        
        //System.debug('InitiativeRequirements###'+InitiativeRequirements.size())
        List<InitiativePayment__c> listtoaddIR=new List<InitiativePayment__c>();
        List<AggregateResult> paymentList = new List<AggregateResult>();
        Map<Id,List<RequirementInitiative__c>> invVsReqList = new Map<Id,List<RequirementInitiative__c>>();
        List<Id> initiativeIdForPayment=new List<Id>();
        List < List < RequirementInitiative__c >> deduped = new List < List <RequirementInitiative__c>> ();
        List < RequirementInitiative__c > dedupedRequirements = new List < RequirementInitiative__c > ();
        Date MyDate,theDate;
        String myString;
        
        //checking for duplicates
        List<RequirementInitiative__c> rilist=new List<RequirementInitiative__c>();//new
        Map<Id,RequirementInitiative__c> maprilist=new Map<Id,RequirementInitiative__c>();//new
        List<InitiativePayment__c> iplist=new List<InitiativePayment__c>();
        
        Set<Id> initiativeIds=new Set<Id>();
        for (List <RequirementInitiative__c> ReqObj: InitiativeRequirements) {
            for (RequirementInitiative__c innerReq: ReqObj) {
                if(!invVsReqList.containsKey(innerReq.Initiative__c)){
                    invVsReqList.put(innerReq.Initiative__c,new List<RequirementInitiative__c>{innerReq});
                }else{
                    invVsReqList.get(innerReq.Initiative__c).add(innerReq);
                }
                initiativeIds.add(innerReq.Initiative__c);
            }
            
        }
        //Changes by Prajwal 6/10/2022
        iplist=[select Id, Initiative__c from InitiativePayment__c where Initiative__c IN: initiativeIds];//new
        rilist=[select Id, Initiative__c from RequirementInitiative__c where Initiative__c IN: initiativeIds];//new
        
        if(!rilist.isEmpty())
        {
            System.debug('**rilist :- '+rilist );
            delete rilist;
        }
        if(!rilist.isEmpty())
        {
            System.debug('**iplist :- '+iplist );
            delete iplist;
        }
        
System.debug('invVsReqList****'+invVsReqList);
        // Foreach iterate over the collection
        for (Id i: invVsReqList.KeySet()) {
            
            //System.debug('ReqObj###'+ReqObj.size());
            
            Id checkReqId;
            //List<String> names=new List<String>();
                    Map < String, RequirementInitiative__c > names = new Map < String, RequirementInitiative__c > ();
            
            System.debug('Mapril****'+maprilist);
            System.debug('NamesForNull****'+names);
            //System.debug('ReqObj****'+ReqObj);
            for (RequirementInitiative__c innerReq: invVsReqList.get(i)) {
                
                system.debug('innerReq###' + innerReq);
                //System.debug('dedupedRequirements###'+dedupedRequirements);
                System.debug('NAmes****'+names);
                
                if (names.isEmpty()) {
                    
                    names.put(String.ValueOf(innerReq.Requirement_Name__c), innerReq);
                    MyDate=names.get(innerReq.Requirement_Name__c).Due_Date__c;
                    names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=String.valueOf(DateTime.newInstance(MyDate.year(),MyDate.month(),MyDate.day()).format('d MMM yyyy'));
                    names.get(innerReq.Requirement_Name__c).Status_Combine__c=names.get(innerReq.Requirement_Name__c).Status__c;
                    
                } else if (!names.containsKey(innerReq.Requirement_Name__c)) {
                    
                    names.put(String.ValueOf(innerReq.Requirement_Name__c), innerReq);
                    
                    MyDate=names.get(innerReq.Requirement_Name__c).Due_Date__c;
                    
                    //names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=String.valueOf(names.get(innerReq.Requirement_Name__c).Due_Date__c);
                    names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=String.valueOf(DateTime.newInstance(MyDate.year(),MyDate.month(),MyDate.day()).format('d MMM yyyy'));
                    names.get(innerReq.Requirement_Name__c).Status_Combine__c=names.get(innerReq.Requirement_Name__c).Status__c;
                    
                } else if (names.containsKey(innerReq.Requirement_Name__c)) {
                    
                    checkReqId = names.get(innerReq.Requirement_Name__c).Requirement__c;
                    
                    
                    if (innerReq.Requirement__c != checkReqId) {
                        
                        MyDate=innerReq.Due_Date__c;
                        //names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=String.valueOf(names.get(innerReq.Requirement_Name__c).Due_Date__c);
                        names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c=names.get(innerReq.Requirement_Name__c).Due_Date_Combine__c+'\n'+String.valueOf(DateTime.newInstance(MyDate.year(),MyDate.month(),MyDate.day()).format('d MMM yyyy')); 
                       names.get(innerReq.Requirement_Name__c).Status_Combine__c=names.get(innerReq.Requirement_Name__c).Status_Combine__c+'\n'+innerReq.Status__c;
                        
                        innerReq.Requirement_Name__c = null;
                        innerReq.Description__c = null;
                        //dedupedRequirements.add(innerReq);
                    }
                    // names.put(String.ValueOf(innerReq.Requirement_Name__c), innerReq);
                    
                }                    
                //*********************** Code for RequirementPayment *****************************
                
                initiativeIdForPayment.add(innerReq.Initiative__c);
                
                
            }
            
            dedupedRequirements.addall(names.values());   
            //code for inserting in InitiativePayment object---IPC Start
        }
        
        if(dedupedRequirements.size()>0){
            deduped.add(dedupedRequirements);
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
            //IPC End
        
        return deduped;
        
    }
    
    
}