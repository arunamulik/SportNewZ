public class communityaccess {
   public static Boolean hasCommunityAccess {get;set;}
   
   public static Boolean getCommunityAccess(String communityName) {
      /* List<PermissionSetAssignment> pset = [SELECT AssigneeId,PermissionSet.Name 
                                             FROM PermissionSetAssignment WHERE PermissionSet.Name = 'Te_Whetu_Rehua' 
                                             and AssigneeId =: UserInfo.getUserId()];
           system.debug('pset==>'+pset);
           if(pset.size() > 0) {
                    return true;
           }
       return false;*/
       List<Network> networks = [select Id from Network where Name=:communityName];
       if(networks.size() > 0) {           
           List<NetworkMember> nm = [select MemberId from NetworkMember where NetworkId=:networks[0].Id and MemberId =: UserInfo.getUserId()];
           if(nm.size() > 0) {  
               return true;
           }
       }
       return false;
   }
   
   public static void checkUserHasTWRAccess() {
       hasCommunityAccess = getCommunityAccess('Sport NZ TWR');
   } 
   @Auraenabled
   public static Boolean checkUserHasAccessToTWR() {
       return getCommunityAccess('Sport NZ TWR');

   } 
   @Auraenabled
   public static Boolean checkUserHasKahiwiAccess() {
       return getCommunityAccess('Sport NZ Partner Portal');

   } 
    
  /* public static Boolean checkUserHasNoMoiriAccess() {
          List<PermissionSetAssignment> pset = [SELECT AssigneeId,PermissionSet.Name 
                                             FROM PermissionSetAssignment WHERE PermissionSet.Name = 'No_Maori_Initiatives' 
                                             and AssigneeId =: UserInfo.getUserId()];
           system.debug('pset==>'+pset);
           if(pset.size() > 0) {
                    return true;
           }
       return false;
   } */
}