/* Class Name   : LoopOverInitiative
* Description  : This class contains methods get Requirement Records for Initiavtive
* Created By   : Prajwal
* Created On   : 06-Oct-2022

* Modification Log:  
* --------------------------------------------------------------------------------------------------------------------------------------
* Developer                Date                   Modification ID      Description 
* ---------------------------------------------------------------------------------------------------------------------------------------
* Prajwal Ganeshe			06-Oct-2022				SSE-162				Get the requirement records and return to the flow
*/
public class LoopOverInitiative {
					
    @InvocableMethod(label = 'SendRequirementCollection GetDedupedInitiative'
                  description = 'returns Deduped Requirement Collection.')
    
    
    public static List<List < Requirement__c >> getDedupedRequirements(List<List< Initiative__c >> InitiativeRequirements) {
    
        List<Requirement__c> rilist = new List<Requirement__c>();
        List<List<Requirement__c>> newrilist = new List<List<Requirement__c>>();
        Set<ID>  setinid = new Set<ID>();
        Set<String> SobjectFields = Schema.getGlobalDescribe().get('Requirement__c').getDescribe().fields.getMap().keySet();   
        List<String> fieldsInList = new List<String>(SobjectFields);
        for (List <Initiative__c> ReqObj: InitiativeRequirements) {
        
            for (Initiative__c innerReq: ReqObj) {
            	
                setinid.add(innerReq.Id);
            }
        
        }
        
        rilist = Database.query('SELECT ' + String.join(fieldsInList, ',') + ' FROM Requirement__c WHERE Initiative__c =: setinid');
        if(rilist.size()>0)
        {
            newrilist.add(rilist);
        }
        return newrilist;
    
    }
}