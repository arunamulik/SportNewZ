public class Activity_dashboardPageController {
    public static decimal malePercentCount=0;
    public static decimal femalePercentCount=0;
    
    
    @AuraEnabled
    public static List<DataSet> getBy_ORGGOVERENED(Integer fyear){
        List<AggregateResult> result_governed =  [Select Count(Id) cnt, By_OrgGoverned__c,Is_Activity_Deleted__c 
        FROM Activity__c 
        where Is_Activity_Deleted__c=false
        AND CALENDAR_YEAR( Due_Date__c)=:fyear 
        group by By_OrgGoverned__c,Is_Activity_Deleted__c ];
        decimal total;String status;
        List<DataSet> dataSet = new List<DataSet>();
        List<Activity__c> Activity1 = [SELECT Id  FROM Activity__c ];
        for(AggregateResult ar:result_governed){
            if(ar.get('By_OrgGoverned__c')==null){
                status='No Option Selected';
                total =0; 
            }
            else{
                status =  (String)ar.get('By_OrgGoverned__c') ;
                total =(decimal)ar.get('cnt'); 
            }
            // decimal total1= Activity1.size();
            //decimal Percentage1=(total*100)/total1;
            // decimal Percentage12 =Percentage1.round();
            
            dataSet.add(new DataSet(status ,total));
            
        }
        System.debug('dataSet'+dataSet);
        return dataSet ; 
    }
    
    @AuraEnabled
    public static List<DataSet> getBy_ActivityGMDgoverned(Integer fyear){
        List<AggregateResult> result_governed =  [Select Count(Id) cnt, By_ActivityGMDgoverned__c,Is_Activity_Deleted__c 
        FROM  Activity__c 
        where Is_Activity_Deleted__c=false
        AND CALENDAR_YEAR(Due_Date__c )=:fyear 
        group by By_ActivityGMDgoverned__c,Is_Activity_Deleted__c ];
        decimal total;String status;
        List<DataSet> dataSet = new List<DataSet>();
        List<Activity__c> Activity1 = [SELECT Id  FROM Activity__c ];
        for(AggregateResult ar:result_governed){
            if(ar.get('By_ActivityGMDgoverned__c')==null){
                status='No Option Selected';
                total =(decimal)ar.get('cnt'); 
            }
            else{
                status =  (String)ar.get('By_ActivityGMDgoverned__c') ;
                total =(decimal)ar.get('cnt'); 
            }
            //  decimal total1= Activity1.size();
            // decimal Percentage1=(total*100)/total1;
            // decimal Percentage12 =Percentage1.round();
            
            dataSet.add(new DataSet(status ,total));
            
        }
        System.debug('dataSet'+dataSet);
        return dataSet ; 
    }
    @AuraEnabled
    public static List<DataSet> getBy_ActivityGMDdelivered(Integer fyear){
        List<AggregateResult> result_delivered =  [Select Count(Id) cnt, By_ActivityGMDdelivered__c,Is_Activity_Deleted__c  
        FROM Activity__c 
        where Is_Activity_Deleted__c=false 
        AND CALENDAR_YEAR(Due_Date__c )=:fyear 
        group by By_ActivityGMDdelivered__c,Is_Activity_Deleted__c  ];
        List<DataSet> dataSet = new List<DataSet>();
        String status;decimal total;
        List<Activity__c> Activity1 = [SELECT Id  FROM Activity__c ];
        for(AggregateResult ar:result_delivered){
            if(ar.get('By_ActivityGMDdelivered__c')==null){
                status = 'No Option Selected';
                total =(decimal)ar.get('cnt'); 
            }
            else{
                status =  (String)ar.get('By_ActivityGMDdelivered__c') ;
                total =(decimal)ar.get('cnt'); 
            }
            //decimal total1= Activity1.size();
            //decimal Percentage1=(total*100)/total1;
            //decimal Percentage12 =Percentage1.round();
            
            dataSet.add(new DataSet(status ,total));
        }
        return dataSet ; 
    }
    @AuraEnabled
    public static List<DataSet> getBy_ActivityGMDmanaged(Integer fyear){
        List<AggregateResult> result_managed =  [Select Count(Id) cnt, By_ActivityGMDmanaged__c,Is_Activity_Deleted__c 
        FROM Activity__c 
        where Is_Activity_Deleted__c=false 
        AND CALENDAR_YEAR(Due_Date__c)=:fyear
        group by By_ActivityGMDmanaged__c,Is_Activity_Deleted__c ];
        List<DataSet> dataSet = new List<DataSet>();
        String status;decimal total;
        List<Activity__c> Activity1 = [SELECT Id  FROM Activity__c ];
        for(AggregateResult ar:result_managed){
            if(ar.get('By_ActivityGMDmanaged__c')==null){
                status =  'No Option Selected';
                total =(decimal)ar.get('cnt'); 
            }
            else{
                status =  (String)ar.get('By_ActivityGMDmanaged__c') ;
                total =(decimal)ar.get('cnt'); 
            }
            //decimal total1= Activity1.size();
            // decimal Percentage1=(total*100)/total1;
            // decimal Percentage12 =Percentage1.round();
            
            dataSet.add(new DataSet(status ,total));
            
        }
        System.debug('dataSet result_managed'+dataSet);
        return dataSet ; 
    }
    @AuraEnabled 
    public static List<Activity__c> get_MaleAndFemaleValues(Integer fyear){
        List<Activity__c> ActivityLst = new  List<Activity__c>();
        List<DataSet1> dataSet1 = new List<DataSet1>();
        decimal femaleCount=0, MaleCount=0; list<String> Name1=new list<String>() ;
        List<Activity__c> AggregateResultList = [select Name,GenderOfParticipants_Tane__c,GenderOfParticipants_Wahine__c,Is_Activity_Deleted__c 
        from Activity__c 
        where (GenderOfParticipants_Tane__c >0 or GenderOfParticipants_Wahine__c>0 ) 
        AND Is_Activity_Deleted__c=false
        AND CALENDAR_YEAR( Due_Date__c)=:fyear]; 
        for(Activity__c aggr:AggregateResultList){ 
            /*if(aggr.GenderOfParticipants_Tane__c==null)
{
aggr.GenderOfParticipants_Tane__c=0;

}
if(aggr.GenderOfParticipants_Wahine__c==null)
{
aggr.GenderOfParticipants_Wahine__c=0;

} */
            Name1.add((string)aggr.Name);
            system.debug('Name1'+Name1);
            MaleCount =(decimal)aggr.GenderOfParticipants_Tane__c+MaleCount; 
            system.debug('MaleCount'+MaleCount);
            femaleCount =(decimal)aggr.GenderOfParticipants_Wahine__c+femaleCount; 
            system.debug('femaleCount'+femaleCount);
            
        } 
        
        dataSet1.add(new DataSet1(Name1,MaleCount,femaleCount));
        system.debug(dataSet1+'dataSet1');
        return AggregateResultList;
    }
    @AuraEnabled 
    public static List<Activity__c> get_MaleAndFemalePercentValues(Integer fyear){
        List<Activity__c> ActivityLst = new  List<Activity__c>();
        List<DataSet1> dataSet1 = new List<DataSet1>();
        decimal femaleCount=0, MaleCount=0; list<String> Name1=new list<String>() ;
        List<Activity__c> AggregateResultList = [select Name,GenderOfParticipants_Tane__c,GenderOfParticipants_Wahine__c,Is_Activity_Deleted__c 
        from Activity__c 
        WHERE Is_Activity_Deleted__c=false
        AND CALENDAR_YEAR(Due_Date__c )=:fyear]; 
        decimal total = AggregateResultList.size();
        for(Activity__c aggr:AggregateResultList){ 
            if(aggr.GenderOfParticipants_Tane__c==null)
            {
                aggr.GenderOfParticipants_Tane__c=0;
                
            }
            if(aggr.GenderOfParticipants_Wahine__c==null)
            {
                aggr.GenderOfParticipants_Wahine__c=0;
                
            } 
            Name1.add((string)aggr.Name);
            system.debug('Name1'+Name1);
            MaleCount =(decimal)aggr.GenderOfParticipants_Tane__c+MaleCount; 
            malePercentCount =(malePercentCount+MaleCount)/total*100;
            system.debug('MaleCount'+MaleCount);
            femaleCount =(decimal)aggr.GenderOfParticipants_Wahine__c+femaleCount; 
            femalePercentCount=(femalePercentCount+femaleCount)/total*100;
            system.debug('femaleCount'+femaleCount);
            
        } 
        system.debug('malePercentCount'+malePercentCount);
        system.debug('femalePercentCount'+femalePercentCount);
        
        dataSet1.add(new DataSet1(Name1,malePercentCount,femalePercentCount));
        system.debug(dataSet1+'aggregate percent');
        return AggregateResultList;
    }
    
    
    @AuraEnabled
    public static list<DataSet3> getAgeOfParticipants(Integer fyear){
        List<DataSet3> dataSet = new List<DataSet3>();
        List<Activity__c> Activity1_AgeOfParticipants =  [SELECT Id , AgeOfParticipants_Mokopuna__c, AgeOfParticipants_Taiohi__c, 
        AgeOfParticipants_Rangatahi13_19__c,AgeOfParticipants_Matua_20_39__c,
        AgeOfParticipants_Pakeke40_59__c,AgeOfParticipants_Kaum_tua__c 
        FROM Activity__c 
        where (AgeOfParticipants_Mokopuna__c!=null) 
        AND  (AgeOfParticipants_Taiohi__c!=null)
         AND  (AgeOfParticipants_Rangatahi13_19__c!=null) 
         AND (AgeOfParticipants_Matua_20_39__c!=null) 
         AND  (AgeOfParticipants_Pakeke40_59__c!=null)   
         AND  (AgeOfParticipants_Kaum_tua__c!=null) 
         AND Is_Activity_Deleted__c=false  
         AND CALENDAR_YEAR( Due_Date__c)=:fyear];
        System.debug('Activity1_AgeOfParticipants'+Activity1_AgeOfParticipants);
        List<Activity__c> Activity1 = [SELECT Id  FROM Activity__c ];
        list<String> Status=new list<String>();
        Status.add('Mokopuna (0-4)');
        Status.add('Tamariki (5-12)');
        Status.add('Rangatahi (13-19)');
       // Status.add('Rangatahi (16-19)');
        Status.add('Matua (20-39)');
        Status.add('Pakeke (40-59)');
        Status.add('Kaumatua (60+)');
        
        list<decimal> totallst=new list<decimal>();
        list<decimal> totallst1=new list<decimal>();
        decimal total2=0,total1=0,total3=0,total4=0,total5=0,total6=0,total7=0;  
        decimal  sum=0;
        for(Activity__c ar:Activity1_AgeOfParticipants){
            if(ar.AgeOfParticipants_Mokopuna__c==null)
            {
                ar.AgeOfParticipants_Mokopuna__c=0;
                
            }
            if(ar.AgeOfParticipants_Taiohi__c==null)
            {
                ar.AgeOfParticipants_Taiohi__c=0;
                
            }
            if(ar.AgeOfParticipants_Rangatahi13_19__c==null)
            {
                ar.AgeOfParticipants_Rangatahi13_19__c=0;
                
            }
            /*if(ar.AgeOfParticipants_Rangatahi16_19__c==null)
            {
                ar.AgeOfParticipants_Rangatahi16_19__c=0;
                
            }*/
            if(ar.AgeOfParticipants_Pakeke40_59__c==null)
            {
                ar.AgeOfParticipants_Pakeke40_59__c=0;
                
            }
            if(ar.AgeOfParticipants_Matua_20_39__c==null)
            {
                ar.AgeOfParticipants_Matua_20_39__c=0;
                
            }
            if(ar.AgeOfParticipants_Kaum_tua__c==null)
            {
                ar.AgeOfParticipants_Kaum_tua__c=0;
                
            }
            total1 =ar.AgeOfParticipants_Mokopuna__c+total1; 
            total2 =total2+ar.AgeOfParticipants_Taiohi__c; 
            total3 =total3+ar.AgeOfParticipants_Rangatahi13_19__c;  
            //total4 =total4+ar.AgeOfParticipants_Rangatahi16_19__c;
            total5 =total5+ar.AgeOfParticipants_Matua_20_39__c; 
            total6 =total6+ar.AgeOfParticipants_Pakeke40_59__c;  
            total7 =total7+ar.AgeOfParticipants_Kaum_tua__c; 
        }
        
        
        decimal TotalAgeOfParticipants = total1+total2+total3+total5+total6+total7;
        
        decimal AgeOfParticipants_Mokopuna=(total1*100);
        AgeOfParticipants_Mokopuna = AgeOfParticipants_Mokopuna.divide(TotalAgeOfParticipants, 3);
        
        decimal AgeOfParticipants_Taiohi=(total2*100);
        AgeOfParticipants_Taiohi=AgeOfParticipants_Taiohi.divide(TotalAgeOfParticipants, 3);
        
        decimal AgeOfParticipants_Rangatahi13_19=(total3*100);
        AgeOfParticipants_Rangatahi13_19=AgeOfParticipants_Rangatahi13_19.divide(TotalAgeOfParticipants, 3);
        
        //decimal AgeOfParticipants_Rangatahi16_19=(total4*100);
        //AgeOfParticipants_Rangatahi16_19=AgeOfParticipants_Rangatahi16_19.divide(TotalAgeOfParticipants, 3);
        
        decimal AgeOfParticipants_Matua_20_39=(total5*100);
        AgeOfParticipants_Matua_20_39=AgeOfParticipants_Matua_20_39.divide(TotalAgeOfParticipants, 3);

        decimal AgeOfParticipants_Pakeke40_59=(total6*100);
        AgeOfParticipants_Pakeke40_59=AgeOfParticipants_Pakeke40_59.divide(TotalAgeOfParticipants, 3);
        
        //decimal AgeOfParticipants_Pakeke_20_39=(total6*100);
        //AgeOfParticipants_Pakeke_20_39=AgeOfParticipants_Pakeke_20_39.divide(TotalAgeOfParticipants, 3);


        
        decimal AgeOfParticipants_Kaum_tua=(total7*100);
        AgeOfParticipants_Kaum_tua=AgeOfParticipants_Kaum_tua.divide(TotalAgeOfParticipants, 3);
        
        
        totallst.add(AgeOfParticipants_Mokopuna);
        totallst.add(AgeOfParticipants_Taiohi);
        totallst.add(AgeOfParticipants_Rangatahi13_19);
        //totallst.add(AgeOfParticipants_Rangatahi16_19);
        totallst.add(AgeOfParticipants_Pakeke40_59);
       totallst.add(AgeOfParticipants_Matua_20_39);
        totallst.add(AgeOfParticipants_Kaum_tua);
        
        
        
        totallst1.add(total1);
        totallst1.add(total2);
        totallst1.add(total3);
        //totallst1.add(total4);
        totallst1.add(total5);
        totallst1.add(total6);
        totallst1.add(total7);
        integer i=0;
        while(i<6)
        {        dataSet.add(new DataSet3(Status[i] ,totallst[i],totallst1[i]));
         i++;
        }
        return dataSet ; 
    }
    @AuraEnabled
    public static List<DataSet> getEthnicityOfParticipants(Integer fyear){
        List<Activity__c> Activity1_EthnicityOfParticipants =  [SELECT Id, EthnicityOfParticipants_Non_M_ori__c, EthnicityOfParticipants_M_ori__c,
        Is_Activity_Deleted__c 
        FROM Activity__c 
        WHERE Is_Activity_Deleted__c=false
        AND CALENDAR_YEAR(Due_Date__c )=:fyear];
        List<DataSet> dataSet = new List<DataSet>();
        list<String> status=new list<String>();
        status.add('Māori');
        status.add('Non Māori');
        List<Activity__c> Activity1 = [SELECT Id,Is_Activity_Deleted__c  FROM Activity__c WHERE Is_Activity_Deleted__c=false ];
        list<decimal> totallst=new list<decimal>();
        decimal total2=0,total1=0;  
        decimal  sum=0;
        for(Activity__c ar:Activity1_EthnicityOfParticipants){
            if(ar.EthnicityOfParticipants_Non_M_ori__c==null)
            {
                ar.EthnicityOfParticipants_Non_M_ori__c=0;
                
            }
            if(ar.EthnicityOfParticipants_M_ori__c==null)
            {
                ar.EthnicityOfParticipants_M_ori__c=0;
                
            }
            total1 =ar.EthnicityOfParticipants_M_ori__c+total1; 
            total2 =total2+ar.EthnicityOfParticipants_Non_M_ori__c; 
            System.debug('totaffffffffffffffffffffffl2>>>>>>>>>>'+total1);
            System.debug('dataSetfffffffffffffffffffff>>>>>>'+total2);
        }
        System.debug('total2'+total1);
        totallst.add(total1);
        totallst.add(total2);
        integer i=0;
        while(i<2)
        {        dataSet.add(new DataSet(status[i] ,totallst[i]));
         i++;
        }
        System.debug('dataSetffffffffffffffff'+dataSet);
        return dataSet ; 
    }
    
    public class DataSet{
        public DataSet(String name ,decimal y){
            this.name  = name ; 
            this.y = y ;
        }
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public decimal  y {get;set;}
        
        
    }
    public class DataSet1{
        public DataSet1(list<String> name ,decimal count,decimal count2){
            this.name  = name ; 
            this.count = count ;
            this.count2=count2;
            
        }
        
        @AuraEnabled
        public list<String> name {get;set;}
        @AuraEnabled
        public decimal  count {get;set;}
        @AuraEnabled
        public decimal  count2 {get;set;}  
    }
    public class DataSet2{
        public DataSet2(list<String> name , list<integer> y){
            this.name  = name ; 
            this.y = y ; }
        
        @AuraEnabled
        public list<String> name {get;set;}
        @AuraEnabled
        public list<integer> y {get;set;}
        
    }
    public class DataSet3{
        public DataSet3(String name ,decimal y,decimal count2){
            this.name  = name ; 
            this.y = y ;
            this.count2=count2;
            
        }
        
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public decimal  y {get;set;}
        @AuraEnabled
        public decimal  count2 {get;set;}  
    }
    @AuraEnabled 
    public static String fetchUser(){
        User u = [select id,Name,FirstName from User where id =: userInfo.getUserId()];
        
        List<Activity__c> relatedUsersActivity = [SELECT Id, OwnerId, Name, HOP_Outcome__c,Is_Activity_Deleted__c FROM Activity__c where OwnerId =: u.id AND Is_Activity_Deleted__c=false];
        system.debug('8==>'+relatedUsersActivity);
        
        String returnData = u.FirstName+':'+relatedUsersActivity.Size();
        
        return returnData;
    }
    
    @AuraEnabled 
    public static String getVideoOrImage(){
        Landing_Page_Image_Video__c landingPageBG = [SELECT Id, Embed_Video__c, Background_Image__c, Partner_Logo__c FROM Landing_Page_Image_Video__c];
        system.debug('17==>'+landingPageBG.Background_Image__c);
        return landingPageBG.Embed_Video__c+'==>'+landingPageBG.Background_Image__c +'==>'+landingPageBG.Partner_Logo__c;
    }
    
    @AuraEnabled
    public static Activity__c saveActivity (Activity__c act) {
        String  msg;
        try{
            List<Activity__c> lstAct = new List<Activity__c>();
            if(act.By_OrgGoverned__c == '--Select--' ){
                act.By_OrgGoverned__c = '';
            }
            if(act.By_ActivityGMDgoverned__c == '--Select--' ){
                act.By_ActivityGMDgoverned__c = '';
            }
            if(act.By_ActivityGMDmanaged__c == '--Select--' ){
                act.By_ActivityGMDmanaged__c = '';
            }
            if(act.By_ActivityGMDdelivered__c == '--Select--' ){
                act.By_ActivityGMDdelivered__c = '';
            }
            if(act.Through_TypeActNgaTaonga__c == '--Select--' ){
                act.Through_TypeActNgaTaonga__c = '';
            }
            if(act.Through_TypeActNgaKemu__c == '--Select--' ){
                act.Through_TypeActNgaKemu__c = '';
            }
            if(act.Through_TypeActNgaMahi__c == '--Select--' ){
                act.Through_TypeActNgaMahi__c = '';
            }
            if(act.Through_typeActHakinakina__c == '--Select--' ){
                act.Through_typeActHakinakina__c = '';
            }
            if(act.Through_typeActLandO__c == '--Select--' ){
                act.Through_typeActLandO__c = '';
            }
            if(act.InOn_LocateActMaunga__c == '--Select--' ){
                act.InOn_LocateActMaunga__c = '';
            }
            if(act.InOn_LocateActAwa__c == '--Select--' ){
                act.InOn_LocateActAwa__c = '';
            }
            if(act.InOn_LocateActMarae__c == '--Select--' ){
                act.InOn_LocateActMarae__c = '';
            }
            if(act.InOn_LocateActKohanga__c == '--Select--' ){
                act.InOn_LocateActKohanga__c = '';
            }
            if(act.InOn_LocateActKura__c == '--Select--' ){
                act.InOn_LocateActKura__c = '';
            }
            if(act.InOn_LocateActWahi__c == '--Select--' ){
                act.InOn_LocateActWahi__c = '';
            }
            if(act.InOn_LocateActSRC__c == '--Select--' ){
                act.InOn_LocateActSRC__c = '';
            }
            if(act.InOn_LocateActSRC2__c == '--Select--' ){
                act.InOn_LocateActSRC2__c = '';
            }
            if(act.InOn_SignificanceLocation__c == '--Select--' ){
                act.InOn_SignificanceLocation__c = '';
            }
            if(act.With_UseOfTeReo__c == '--Select--' ){
                act.With_UseOfTeReo__c = '';
            }
            if(act.With_PrposeTeRaoIntegral__c == '--Select--' ){
                act.With_PrposeTeRaoIntegral__c = '';
            }
            if(act.With_SignificanceTeRao__c == '--Select--' ){
                act.With_SignificanceTeRao__c = '';
            }
            if(act.With_PrposeTeReoAwareness__c == '--Select--' ){
                act.With_PrposeTeReoAwareness__c = '';
            }
            if(act.With_PrposeTeReaoKnowledge__c == '--Select--' ){
                act.With_PrposeTeReaoKnowledge__c = '';
            }
            if(act.With_PrposeTeReaoExtendAct__c == '--Select--' ){
                act.With_PrposeTeReaoExtendAct__c = '';
            }
            if(act.With_PrposeTikangaRaiseAwareness__c == '--Select--' ){
                act.With_PrposeTikangaRaiseAwareness__c = '';
            }
            if(act.With_PrposeTikangaBuildKnowledge__c == '--Select--' ){
                act.With_PrposeTikangaBuildKnowledge__c = '';
            }
            if(act.With_PrposeTikangaOppApply__c == '--Select--' ){
                act.With_PrposeTikangaOppApply__c = '';
            }
            if(act.With_PrposeTikangaIntegral__c == '--Select--' ){
                act.With_PrposeTikangaIntegral__c = '';
            }
            if(act.With_SigniOfTikanga__c == '--Select--' ){
                act.With_SigniOfTikanga__c = '';
            }
            
            lstAct.add(act);
            system.debug('27==>'+lstAct);
            
            upsert act;
            return act;
        } catch(Exception e){
            
            
            msg= e.getMessage();
            system.debug('96==>'+msg);  
            throw new AuraHandledException('Error Exception happend'+msg); //e.getMessage()
            
        }
        
    }
    @AuraEnabled
    public static Activity__c SaveChangeReqandMail (Activity__c act) {
        List<Activity__c> lstAct = new List<Activity__c>();
        lstAct.add(act);
        system.debug('27==>'+lstAct);
        for(Activity__c ac : lstAct){
            
        }
        upsert act;
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> sendEmailTo = new List<String>();
        String userName = UserInfo.getUserName();
        system.debug('userName'+userName);
        User activeUser = [SELECT Email,Name FROM User WHERE User.Name = 'Dnyanesh Gawali'];
        
        Activity__c accList = [select id,Change_Request_Reason__c from Activity__c where Activity__c.Name = 'Test 2'];
        String userEmail = 'tushar.shinde@aress.com';
        sendEmailTo.add(userEmail);
        mail.setToAddresses(sendEmailTo);
        mail.setReplyTo(userEmail);
        mail.setSubject('Mail Regarding Change Request');
        string body = '<html><body>';
        body +='<br> Change Request';
        body += '<br>' ;
        body += activeUser.Name;
        body += '<br>' ;
        body += accList.Change_Request_Reason__c;
        body += '</body></html>';
        mail.setHtmlBody(body);
        mails.add(mail);
        Messaging.sendEmail(mails);
        
        /*  List<Approval.ProcessSubmitRequest> lstprocess=new List<Approval.ProcessSubmitRequest>();
if(accList.Raraunga_Kaunga_Question1__c !=Null)
{
approval.ProcessSubmitRequest aprlPrcs = new Approval.ProcessSubmitRequest();     
aprlPrcs .setComments('Submitting record for approval.');
aprlPrcs.setObjectId(accList.id);
lstprocess.add(aprlPrcs);
}
List<Approval.ProcessResult> resultlist = Approval.process(lstprocess);*/ 
        return act;
    }
    
    @AuraEnabled        
    public static Map<String, List<Activity__c>> getselectOptions(String objectType, String fieldName, Integer fyear){
        
        return ActivityOnboardingLandingPageController.getselectOptions(objectType,fieldName,fyear);
     
    }
    
    @AuraEnabled        
    public static Activity__c showSelectedActivity(string id){
        system.debug('71==>'+id);
        Activity__c actSelected = [select id,Name,HOP_Outcome__c, Due_Date__c, Description__c, Expectations_of_Impact__c,Change_Request_Reason__c,
                                   By_OrgGoverned__c,
                                   Is_Read_Only__c,COVID_19_ALERT_LEVEL__c,
                                   //Initiative__c,
                                   By_ActivityGMDgoverned__c, 
                                   By_ActivityGMDmanaged__c,
                                   By_ActivityGMDdelivered__c, 
                                   Participation_NoOfParticipants__c,
                                   Particaipation_WhanauType_Marae__c,
                                   Particaipation_WhanauType_Hapu__c,
                                   Particaipation_WhanauType_lwi__c,
                                   Particaipation_WhanauType_Wh_nau__c,
                                   Particaipation_WhanauType_Waka__c,
                                   Particaipation_WhanauType_KohangaPunaReo__c,
                                   Particaipation_WhanauType_Kura_Kaupapa__c,
                                   Particaipation_WhanauType_Whare_Kura__c,
                                   Particaipation_WhanauType_Whare_Wananga__c,
                                   Particaipation_WhanauType_Kaupapa_H_kina__c	,
                                   Particaipation_WhanauType_Other__c,
                                   Particaipation_WhanauType_Whanau_Whaikah__c,
                                   Particaipation_WhanauType_Mana_Tipua__c,
                                   NoOfGroups_Marae__c,
                                   NoOfGroups_Hapu__c,
                                   NoOfGroups_Iwi__c,
                                   NoOfGroups_Wh_nau__c,
                                   NoOfGroups_Waka__c,
                                   NoOfGroups_KohangaPuna__c,
                                   NoOfGroups_Kura_Kaupapa__c,
                                   NoOfGroups_Whare_Kura__c,
                                   NoOfGroups_Whare_Wananga__c,
                                   NoOfGroups_Kaupapa_H_kinakina__c,
                                   NoOfGroups_Other__c,
                                   Through_typeActNgaTaonga__c,
                                   Through_TypeActNgaKemu__c,
                                   Through_TypeActNgaMahi__c,
                                   Through_typeActHakinakina__c,
                                   Through_typeActLandO__c,
                                   InOn_LocateActMaunga__c,
                                   InOn_LocateActAwa__c,
                                   InOn_LocateActMarae__c,
                                   InOn_LocateActKohanga__c,
                                   InOn_LocateActKura__c,
                                   InOn_LocateActWahi__c,
                                   InOn_LocateActSRC__c,
                                   InOn_LocateActSRC2__c,
                                   InOn_SignificanceLocation__c,
                                   With_UseOfTeReo__c,
                                   With_PrposeTeReoAwareness__c,
                                   With_PrposeTeReaoKnowledge__c,
                                   With_PrposeTeReaoExtendAct__c,
                                   With_PrposeTeReaoOther__c,
                                   With_PrposeTeRaoIntegral__c,
                                   With_SignificanceTeRao__c,
                                   With_PrposeTikangaRaiseAwareness__c,
                                   With_PrposeTikangaBuildKnowledge__c,
                                   With_PrposeTikangaOppApply__c,
                                   With_PrposeTikangaOther__c,
                                   With_PrposeTikangaIntegral__c,
                                   With_SigniOfTikanga__c,
                                   Particaipation_WhanauType_Total__c,
                                   NoOfGroups_Total__c,
                                   AgeOfParticipants_Mokopuna__c,
                                   AgeOfParticipants_Taiohi__c,
                                   AgeOfParticipants_Rangatahi13_19__c,
                                   AgeOfParticipants_Matua_20_39__c,
                                   AgeOfParticipants_Pakeke40_59__c,
                                   AgeOfParticipants_Kaum_tua__c,
                                   AgeOfParticipants_DidNotRespond__c,
                                   AgeOfParticipants_Total__c,
                                   GenderOfParticipants_Tane__c,
                                   GenderOfParticipants_Wahine__c,
                                   GenderOfParticipants_DidNotRespond__c,
                                   GenderOfParticipants_Total__c,
                                   EthnicityOfParticipants_M_ori__c,
                                   EthnicityOfParticipants_Non_M_ori__c,
                                   EthnicityOfParticipants_DidNotRespond__c,
                                   EthnicityOfParticipants_Total__c,
                                   DiamensionBy_DescRichText__c,
                                   DiamensionThrough_DescRichText__c,
                                   DiamensionInOn_DescRichText__c,
                                   DiamensionWith_DescRichText__c,
                                   DiamensionFor_DescRichText__c,
                                   Diamension_By_Score__c,
                                   Diamension_Thorugh_Score__c,
                                   Diamension_InOn_Score__c,
                                   Diamension_With_Score__c,
                                   Diamension_For_Score__c,
                                   /* Completed_Date__c,  Raraunga_Kaunga_Question1__c,
Raraunga_Kaunga_Question2__c,
Raraunga_Kaunga_Question3__c,
Raraunga_Kaunga_Question4__c,
Raraunga_Kaunga_Question5__c,
Save_and_Complete_Question1__c,
Save_and_Complete_Question2__c,
Save_and_Complete_Question3__c,
Save_and_Complete_Question4__c,
Save_and_Complete_Question5__c,*/Is_Activity_Deleted__c
                                   from Activity__c where id =: id AND Is_Activity_Deleted__c=false ];
        if(actSelected.Participation_NoOfParticipants__c == null){
            actSelected.Participation_NoOfParticipants__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Marae__c == null){
            actSelected.Particaipation_WhanauType_Marae__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Hapu__c == null){
            actSelected.Particaipation_WhanauType_Hapu__c=0;
        }
        if(actSelected.Particaipation_WhanauType_lwi__c == null){
            actSelected.Particaipation_WhanauType_lwi__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Wh_nau__c == null){
            actSelected.Particaipation_WhanauType_Wh_nau__c=0;
        }
        if(actSelected.Particaipation_WhanauType_KohangaPunaReo__c == null){
            actSelected.Particaipation_WhanauType_KohangaPunaReo__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Kura_Kaupapa__c == null){
            actSelected.Particaipation_WhanauType_Kura_Kaupapa__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Whare_Kura__c == null){
            actSelected.Particaipation_WhanauType_Whare_Kura__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Whare_Wananga__c == null){
            actSelected.Particaipation_WhanauType_Whare_Wananga__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Kaupapa_H_kina__c == null){
            actSelected.Particaipation_WhanauType_Kaupapa_H_kina__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Other__c == null){
            actSelected.Particaipation_WhanauType_Other__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Whanau_Whaikah__c == null){
            actSelected.Particaipation_WhanauType_Whanau_Whaikah__c=0;
        }
        if(actSelected.Particaipation_WhanauType_Mana_Tipua__c == null){
            actSelected.Particaipation_WhanauType_Mana_Tipua__c=0;
        }
        if(actSelected.AgeOfParticipants_Mokopuna__c == null){
            actSelected.AgeOfParticipants_Mokopuna__c=0;
        }
        if(actSelected.AgeOfParticipants_Taiohi__c == null){
            actSelected.AgeOfParticipants_Taiohi__c=0;
        }
        if(actSelected.AgeOfParticipants_Rangatahi13_19__c == null){
            actSelected.AgeOfParticipants_Rangatahi13_19__c=0;
        }
        /*if(actSelected.AgeOfParticipants_Rangatahi16_19__c == null){
            actSelected.AgeOfParticipants_Rangatahi16_19__c=0;
        }*/
        /*if(actSelected.AgeOfParticipants_Pakeke_20_39__c == null){
            actSelected.AgeOfParticipants_Pakeke_20_39__c=0;
        }*/

        if(actSelected.AgeOfParticipants_Matua_20_39__c == null){
            actSelected.AgeOfParticipants_Matua_20_39__c=0;
        }
        if(actSelected.AgeOfParticipants_Pakeke40_59__c == null){
            actSelected.AgeOfParticipants_Pakeke40_59__c=0;
        }
        if(actSelected.AgeOfParticipants_Kaum_tua__c == null){
            actSelected.AgeOfParticipants_Kaum_tua__c=0;
        }
        if(actSelected.AgeOfParticipants_DidNotRespond__c == null){
            actSelected.AgeOfParticipants_DidNotRespond__c=0;
        }
        if(actSelected.GenderOfParticipants_Tane__c == null){
            actSelected.GenderOfParticipants_Tane__c=0;
        }
        if(actSelected.GenderOfParticipants_Wahine__c == null){
            actSelected.GenderOfParticipants_Wahine__c=0;
        }
        if(actSelected.GenderOfParticipants_DidNotRespond__c == null){
            actSelected.GenderOfParticipants_DidNotRespond__c=0;
        }
        if(actSelected.EthnicityOfParticipants_M_ori__c == null){
            actSelected.EthnicityOfParticipants_M_ori__c=0;
        }
        if(actSelected.EthnicityOfParticipants_Non_M_ori__c == null){
            actSelected.EthnicityOfParticipants_Non_M_ori__c=0;
        }
        if(actSelected.EthnicityOfParticipants_DidNotRespond__c == null){
            actSelected.EthnicityOfParticipants_DidNotRespond__c=0;
        }
        
        system.debug('73==>'+actSelected);
        return actSelected;
    }
    
    @AuraEnabled 
    public static List<String> getbyOrgGovernedPicklist(String objectType, String fieldName){
        
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(fieldName).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        system.debug('40==>'+pickListValuesList);
        for(String pickVal : pickListValuesList){
            system.debug('44=>>'+pickVal);
        }
        return pickListValuesList;
        
    }
    
    @AuraEnabled 
    public static List<Activity__c> get_TotalParticipants(Integer fyear){
        List<Activity__c> ActivityLst = [select id,Name,
                                         Participation_NoOfParticipants__c,Is_Activity_Deleted__c
                                         from Activity__c 
                                         where Participation_NoOfParticipants__c > 0 
                                         AND Is_Activity_Deleted__c=false
                                         AND CALENDAR_YEAR( Due_Date__c)=:fyear];
        for(Activity__c act:ActivityLst){
            if(act.Participation_NoOfParticipants__c==null)
            {
                act.Participation_NoOfParticipants__c=0;  
            } 
        }
        
        
        return ActivityLst;
    }
    @AuraEnabled
    public static List<DataSet> get_With_PrposeTeReo(Integer fyear){
        List<Activity__c> Activity1_With_PrposeTeReo =  [SELECT Id, With_PrposeTeReoAwareness__c, With_PrposeTeReaoKnowledge__c, 
        With_PrposeTeReaoExtendAct__c,Is_Activity_Deleted__c 
        FROM Activity__c 
        WHERE Is_Activity_Deleted__c=false 
        AND CALENDAR_YEAR(Due_Date__c )=:fyear];
        List<DataSet> dataSet = new List<DataSet>();
        list<String> Status=new list<String>();
        Status.add('Raise awareness');
        Status.add('Build knowledge');
        Status.add('Extended activity');
        List<Activity__c> Activity1 = [SELECT Id  FROM Activity__c ];
        list<Integer> totallst=new list<Integer>();
        Integer total2=0,total1=0,total3=0;  
        
        for(Activity__c ar:Activity1_With_PrposeTeReo){
            if(ar.With_PrposeTeReoAwareness__c==null)
            {
                ar.With_PrposeTeReoAwareness__c='0';
                
            }
            if(ar.With_PrposeTeReaoKnowledge__c==null)
            {
                ar.With_PrposeTeReaoKnowledge__c='0';
                
            }
            if(ar.With_PrposeTeReaoExtendAct__c==null)
            {
                ar.With_PrposeTeReaoExtendAct__c='0';
                
            }
            total1 =Integer.valueOf(ar.With_PrposeTeReoAwareness__c)+total1; 
            total2 =Integer.valueOf(ar.With_PrposeTeReaoKnowledge__c)+total2; 
            total3 =Integer.valueOf(ar.With_PrposeTeReaoExtendAct__c)+total3; 
        }
        totallst.add(total1);
        totallst.add(total2);
        totallst.add(total3);
        integer i=0;
        while(i<3)
        {        dataSet.add(new DataSet(Status[i] ,totallst[i]));
         i++;
        }
        return dataSet; 
    } 
    @AuraEnabled
    public static List<DataSet> get_With_PrposeTikanga(Integer fyear){
        List<Activity__c> Activity1_With_PrposeTikanga =  [SELECT Id, With_PrposeTikangaRaiseAwareness__c, With_PrposeTikangaBuildKnowledge__c, 
        With_PrposeTikangaOppApply__c,Is_Activity_Deleted__c 
        FROM Activity__c 
        WHERE Is_Activity_Deleted__c=false 
        AND CALENDAR_YEAR( Due_Date__c)=:fyear];
        List<DataSet> dataSet = new List<DataSet>();
        List<Activity__c> Activity1 = [SELECT Id,Is_Activity_Deleted__c  FROM Activity__c WHERE Is_Activity_Deleted__c=false ];
        list<String> Status=new list<String>();
        Status.add('Raise awareness');
        Status.add('Build knowledge');
        Status.add('Opportunity to Apply');
        list<Integer> totallst=new list<Integer>();
        Integer total2=0,total1=0,total3=0;  
        
        for(Activity__c ar:Activity1_With_PrposeTikanga){
            if(ar.With_PrposeTikangaRaiseAwareness__c==null)
            {
                ar.With_PrposeTikangaRaiseAwareness__c='0';
                
            }
            
            if(ar.With_PrposeTikangaBuildKnowledge__c==null)
            {
                ar.With_PrposeTikangaBuildKnowledge__c='0';
                
            }
            if(ar.With_PrposeTikangaOppApply__c==null)
            {
                ar.With_PrposeTikangaOppApply__c='0';
                
            }            
            total1 =Integer.valueOf(ar.With_PrposeTikangaRaiseAwareness__c)+total1; 
            total2 =Integer.valueOf(ar.With_PrposeTikangaBuildKnowledge__c)+total2; 
            total3 =Integer.valueOf(ar.With_PrposeTikangaOppApply__c)+total3; 
        }
        totallst.add(total1);
        totallst.add(total2);
        totallst.add(total3);
        integer i=0;
        while(i<3)
        {        dataSet.add(new DataSet(Status[i] ,totallst[i]));
         i++;
        }
        return dataSet ; 
    } 
    @AuraEnabled
    public static List<DataSet3> getNoOfGroups(Integer fyear){
        List<DataSet3> dataSet = new List<DataSet3>();
        list<String> Status=new list<String>();
        
        Status.add('Marae');
        Status.add('Hapū');
        Status.add('Iwi');
        Status.add('Whānau');
        Status.add('Waka'); 
        Status.add('Kohanga / Puna Reo'); 
        Status.add('Kura Kaupapa');
        Status.add('Whare Kura');
        Status.add('Whare Wānanga'); 
        Status.add('Kaupapa Hākinakina');
        Status.add('Whānau Whaikaha');
        Status.add('Mana Tipua');
        Status.add('');
        /*  List<Activity__c> Activity1_NoOfGroups =  [SELECT Id, NoOfGroups_Marae__c, NoOfGroups_Hapu__c, NoOfGroups_Iwi__c, NoOfGroups_Wh_nau__c,
NoOfGroups_Waka__c, NoOfGroups_KohangaPuna__c, NoOfGroups_Kura_Kaupapa__c, NoOfGroups_Whare_Kura__c,
NoOfGroups_Whare_Wananga__c, NoOfGroups_Kaupapa_H_kinakina__c FROM Activity__c  ];*/
        
        List<Activity__c> Activity1_NoOfGroups =  [SELECT Id, Particaipation_WhanauType_Marae__c, Particaipation_WhanauType_Hapu__c, 
        Particaipation_WhanauType_lwi__c, Particaipation_WhanauType_Wh_nau__c,
                                                   Particaipation_WhanauType_Waka__c, Particaipation_WhanauType_KohangaPunaReo__c, 
                                                   Particaipation_WhanauType_Kura_Kaupapa__c, Particaipation_WhanauType_Whare_Kura__c,
                                                   Particaipation_WhanauType_Whare_Wananga__c, Particaipation_WhanauType_Kaupapa_H_kina__c,
                                                   	Particaipation_WhanauType_Whanau_Whaikah__c,Particaipation_WhanauType_Mana_Tipua__c,
                                                    Is_Activity_Deleted__c	 
                                                   FROM Activity__c 
                                                   WHERE  Is_Activity_Deleted__c=false 
                                                   AND CALENDAR_YEAR( Due_Date__c)=:fyear]; 
        
        
        System.debug('Activity1_NoOfGroups'+Activity1_NoOfGroups);
        List<Activity__c> Activity1 = [SELECT Id,Is_Activity_Deleted__c  FROM Activity__c WHERE  Is_Activity_Deleted__c=false];
        
        list<decimal> totallst=new list<decimal>();
        list<decimal> totallst1=new list<decimal>();
        decimal total1=0,total2=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0,total9=0,total10=0,total11=0,total_mt=0;  
        
        for(Activity__c ar:Activity1_NoOfGroups){
            if(ar.Particaipation_WhanauType_Marae__c==null)
            {
                ar.Particaipation_WhanauType_Marae__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Hapu__c==null)
            {
                ar.Particaipation_WhanauType_Hapu__c=0;
                
            }
            if(ar.Particaipation_WhanauType_lwi__c==null)
            {
                ar.Particaipation_WhanauType_lwi__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Wh_nau__c==null)
            {
                ar.Particaipation_WhanauType_Wh_nau__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Kura_Kaupapa__c==null)
            {
                ar.Particaipation_WhanauType_Kura_Kaupapa__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Whare_Kura__c==null)
            {
                ar.Particaipation_WhanauType_Whare_Kura__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Whare_Wananga__c==null)
            {
                ar.Particaipation_WhanauType_Whare_Wananga__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Kaupapa_H_kina__c==null)
            {
                ar.Particaipation_WhanauType_Kaupapa_H_kina__c=0;
                
            }
            if(ar.Particaipation_WhanauType_KohangaPunaReo__c==null)
            {
                ar.Particaipation_WhanauType_KohangaPunaReo__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Waka__c==null)
            {
                ar.Particaipation_WhanauType_Waka__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Whanau_Whaikah__c==null)
            {
                ar.Particaipation_WhanauType_Whanau_Whaikah__c=0;
                
            }
            if(ar.Particaipation_WhanauType_Mana_Tipua__c==null)
            {
                ar.Particaipation_WhanauType_Mana_Tipua__c=0;
                
            }
            
            total1 =ar.Particaipation_WhanauType_Marae__c+total1; 
            total2 =total2+ar.Particaipation_WhanauType_Hapu__c; 
            total3 =total3+ar.Particaipation_WhanauType_lwi__c;  
            total4 =total4+ar.Particaipation_WhanauType_Wh_nau__c;
            total5 =total5+ar.Particaipation_WhanauType_Waka__c; 
            total6 =total6+ar.Particaipation_WhanauType_KohangaPunaReo__c;  
            total7 =total7+ar.Particaipation_WhanauType_Kura_Kaupapa__c; 
            total8 =total8+ar.Particaipation_WhanauType_Whare_Kura__c; 
            total9 =total9+ar.Particaipation_WhanauType_Whare_Wananga__c; 
            total10 =total10+ar.Particaipation_WhanauType_Kaupapa_H_kina__c; 
            total11=total11+ar.Particaipation_WhanauType_Whanau_Whaikah__c;
            total_mt=total_mt+ar.Particaipation_WhanauType_Mana_Tipua__c;
        }
        
        system.debug('86==>'+total1);
        decimal TotalForwhanau = total1+total2+total3+total4+total5+total6+total7+total8+total9+total10+total11+total_mt;
        system.debug('TotalForwhanau==>'+TotalForwhanau);
        
        decimal Particaipation_WhanauType_Marae=(total1*100);
        Particaipation_WhanauType_Marae = Particaipation_WhanauType_Marae.divide(TotalForwhanau, 3);
        system.debug('total1==>'+total1);
        system.debug('Particaipation_WhanauType_Marae==>'+Particaipation_WhanauType_Marae);
        
        decimal Particaipation_WhanauType_Hapu=(total2*100);
        Particaipation_WhanauType_Hapu=Particaipation_WhanauType_Hapu.divide(TotalForwhanau, 3);
        
        decimal Particaipation_WhanauType_lwi=(total3*100);
        Particaipation_WhanauType_lwi=Particaipation_WhanauType_lwi.divide(TotalForwhanau, 3);
        
        decimal Particaipation_WhanauType_Wh_nau=(total4*100);
        Particaipation_WhanauType_Wh_nau=Particaipation_WhanauType_Wh_nau.divide(TotalForwhanau, 3);
        
        decimal Particaipation_WhanauType_Waka=(total5*100);
        Particaipation_WhanauType_Waka=Particaipation_WhanauType_Waka.divide(TotalForwhanau, 3);
        
        decimal Particaipation_WhanauType_KohangaPunaReo=(total6*100);
        Particaipation_WhanauType_KohangaPunaReo=Particaipation_WhanauType_KohangaPunaReo.divide(TotalForwhanau, 3);
        
        decimal Particaipation_WhanauType_Kura_Kaupapa=(total7*100);
        Particaipation_WhanauType_Kura_Kaupapa=Particaipation_WhanauType_Kura_Kaupapa.divide(TotalForwhanau, 3);
        
        decimal Particaipation_WhanauType_Whare_Kura=(total8*100);
        Particaipation_WhanauType_Whare_Kura=Particaipation_WhanauType_Whare_Kura.divide(TotalForwhanau, 3);
        
        decimal Particaipation_WhanauType_Whare_Wananga=(total9*100);
        Particaipation_WhanauType_Whare_Wananga=Particaipation_WhanauType_Whare_Wananga.divide(TotalForwhanau, 3);
        
        decimal Particaipation_WhanauType_Kaupapa_H_kina=(total10*100);
        Particaipation_WhanauType_Kaupapa_H_kina=Particaipation_WhanauType_Kaupapa_H_kina.divide(TotalForwhanau, 3);

        decimal Particaipation_WhanauType_Whanau_Whaikah=(total11*100);
        Particaipation_WhanauType_Whanau_Whaikah=Particaipation_WhanauType_Whanau_Whaikah.divide(TotalForwhanau, 3);

        decimal Mana_Tipua=(total_mt*100);
        Mana_Tipua=Mana_Tipua.divide(TotalForwhanau, 3);
        
        totallst.add(Particaipation_WhanauType_Marae);
        totallst.add(Particaipation_WhanauType_Hapu);
        totallst.add(Particaipation_WhanauType_lwi);
        totallst.add(Particaipation_WhanauType_Wh_nau);
        totallst.add(Particaipation_WhanauType_Waka);
        totallst.add(Particaipation_WhanauType_KohangaPunaReo);
        totallst.add(Particaipation_WhanauType_Kura_Kaupapa);
        totallst.add(Particaipation_WhanauType_Whare_Kura);
        totallst.add(Particaipation_WhanauType_Whare_Wananga);
        totallst.add(Particaipation_WhanauType_Kaupapa_H_kina);
        totallst.add(Particaipation_WhanauType_Whanau_Whaikah);
        totallst.add(Mana_Tipua);
              
        totallst1.add(total1);
        totallst1.add(total2);
        totallst1.add(total3);
        totallst1.add(total4);
        totallst1.add(total5);
        totallst1.add(total6);
        totallst1.add(total7);
        totallst1.add(total8);
        totallst1.add(total9);
        totallst1.add(total10);
        totallst1.add(total11);
        totallst1.add(total_mt);
       
       integer i=0;
        while(i<12)
        {
            dataSet.add(new DataSet3(Status[i] ,totallst[i],totallst1[i]));
            i++;
        }
        dataSet.add(new DataSet3('',null,null));
        return dataSet; 
    }
    @AuraEnabled
    public static List<DataSet3> getInOn_LocateAct(Integer fyear){
        List<DataSet3> dataSet = new List<DataSet3>();
        list<String> status=new list<String>();
        status.add('Maunga');
        status.add('Awa');
        status.add('Marae');
        status.add('Kohanga');
        status.add('Kura');
        status.add('Wahi');
        status.add('SRC');
        status.add('SRC2');
        List<Activity__c> Activity1_InOn_LocateAct =  [SELECT Id, InOn_LocateActMaunga__c, InOn_LocateActAwa__c, InOn_LocateActMarae__c,
                                                       InOn_LocateActKohanga__c,
                                                       InOn_LocateActSRC__c, InOn_LocateActSRC2__c, InOn_LocateActWahi__c,Is_Activity_Deleted__c, 
                                                       InOn_LocateActKura__c 
                                                       FROM Activity__c 
                                                       WHERE Is_Activity_Deleted__c=false 
                                                       AND CALENDAR_YEAR( Due_Date__c)=:fyear];
        System.debug('Activity1_NoOfGroups'+Activity1_InOn_LocateAct.size());
        List<Activity__c> Activity1 = [SELECT Id,Is_Activity_Deleted__c  
        FROM Activity__c 
        WHERE Is_Activity_Deleted__c=false
        AND CALENDAR_YEAR(Due_Date__c )=:fyear];
        list<decimal> totallst=new list<decimal>();
        list<decimal> totallst1=new list<decimal>();
        Integer total2=0,total1=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0,total9=0,total10=0;  
        
        for(Activity__c ar:Activity1_InOn_LocateAct){
            if(ar.InOn_LocateActMaunga__c==null)
            {
                ar.InOn_LocateActMaunga__c='0';
                
            }
            if(ar.InOn_LocateActAwa__c==null)
            {
                ar.InOn_LocateActAwa__c='0';
                
            }
            if(ar.InOn_LocateActMarae__c==null)
            {
                ar.InOn_LocateActMarae__c='0';
                
            }
            if(ar.InOn_LocateActKohanga__c==null)
            {
                ar.InOn_LocateActKohanga__c='0';
                
            }if(ar.InOn_LocateActSRC__c==null)
            {
                ar.InOn_LocateActSRC__c='0';
                
            }
            if(ar.InOn_LocateActSRC2__c==null)
            {
                ar.InOn_LocateActSRC2__c='0';
                
            }
            if(ar.InOn_LocateActWahi__c==null)
            {
                ar.InOn_LocateActWahi__c='0';
                
            }if(ar.InOn_LocateActKura__c==null)
            {
                ar.InOn_LocateActKura__c='0';
                
            }
            
            total1 =Integer.valueOf(ar.InOn_LocateActMaunga__c)+total1; 
            total2 =total2+Integer.valueOf(ar.InOn_LocateActAwa__c); 
            total3 =total3+Integer.valueOf(ar.InOn_LocateActMarae__c);  
            total4 =total4+Integer.valueOf(ar.InOn_LocateActKohanga__c);
            total5 =total5+Integer.valueOf(ar.InOn_LocateActKura__c); 
            total6 =total6+Integer.valueOf(ar.InOn_LocateActWahi__c);  
            total7 =total7+Integer.valueOf(ar.InOn_LocateActSRC__c); 
            total8 =total8+Integer.valueOf(ar.InOn_LocateActSRC2__c);   
        }
        //calculate average
        Integer TotalAverage =Activity1_InOn_LocateAct.size();
        
        decimal totalAvg1=(total1);
        totalAvg1=totalAvg1.divide(TotalAverage, 3);
        
        decimal totalAvg2=(total2);
        totalAvg2=totalAvg2.divide(TotalAverage, 3);
        
        decimal totalAvg3=(total3);
        totalAvg3=totalAvg3.divide(TotalAverage, 3);
        
        decimal totalAvg4=(total4);
        totalAvg4=totalAvg4.divide(TotalAverage, 3);
        
        decimal totalAvg5=(total5);
        totalAvg5=totalAvg5.divide(TotalAverage, 3);
        
        decimal totalAvg6=(total6);
        totalAvg6=totalAvg6.divide(TotalAverage, 3);
        
        decimal totalAvg7=(total7);
        totalAvg7=totalAvg7.divide(TotalAverage, 3);
        
        decimal totalAvg8=(total8);
        totalAvg8=totalAvg8.divide(TotalAverage, 3);
        //system.debug('totalAvg8'+totalAvg8);
        //calculate percent
        Integer TotalForINON=total1+total2+total3+total4+total5+total6+total7+total8;
        system.debug('TotalForINON==>'+TotalForINON);
        
        decimal InOn_LocateActMaunga=(total1*100);
        InOn_LocateActMaunga=InOn_LocateActMaunga.divide(TotalForINON, 3);
        system.debug('total1==>'+total1);
        system.debug('InOn_LocateActMaunga==>'+InOn_LocateActMaunga);
        
        decimal InOn_LocateActAwa=(total2*100);
        InOn_LocateActAwa=InOn_LocateActAwa.divide(TotalForINON, 3);
        
        decimal InOn_LocateActMarae=(total3*100);
        InOn_LocateActMarae=InOn_LocateActMarae.divide(TotalForINON, 3);
        
        decimal InOn_LocateActKohanga=(total4*100);
        InOn_LocateActKohanga=InOn_LocateActKohanga.divide(TotalForINON, 3);
        
        decimal InOn_LocateActKura=(total5*100);
        InOn_LocateActKura=InOn_LocateActKura.divide(TotalForINON, 3);
        
        decimal InOn_LocateActWahi=(total6*100);
        InOn_LocateActWahi=InOn_LocateActWahi.divide(TotalForINON, 3);
        
        decimal InOn_LocateActSRC=(total7*100);
        InOn_LocateActSRC=InOn_LocateActSRC.divide(TotalForINON, 3);
        
        decimal InOn_LocateActSRC2=(total8*100);
        InOn_LocateActSRC2=InOn_LocateActSRC2.divide(TotalForINON, 3);
        
        totallst.add(InOn_LocateActMaunga);
        totallst.add(InOn_LocateActAwa);
        totallst.add(InOn_LocateActMarae);
        totallst.add(InOn_LocateActKohanga);
        totallst.add(InOn_LocateActKura);
        totallst.add(InOn_LocateActWahi);
        totallst.add(InOn_LocateActSRC);
        totallst.add(InOn_LocateActSRC2);
        
        totallst1.add(totalAvg1);
        totallst1.add(totalAvg2);
        totallst1.add(totalAvg3);
        totallst1.add(totalAvg4);
        totallst1.add(totalAvg5);
        totallst1.add(totalAvg6);
        totallst1.add(totalAvg7);
        totallst1.add(totalAvg8);
        
        integer i=0;
        while(i<8)
        {        dataSet.add(new DataSet3(status[i] ,totallst[i],totallst1[i]));
         i++;
        }
        
        return dataSet ; 
    }
    @AuraEnabled
    public static Map<String, List<String>> getActivityDiamension(Integer fyear){
        List<Activity__c> ActivityDiamension =  [SELECT Id,Name, Diamension_For_Score__c, Diamension_With_Score__c, Diamension_InOn_Score__c, 
        Diamension_Thorugh_Score__c, Diamension_By_Score__c,Is_Activity_Deleted__c 
        FROM Activity__c 
        WHERE Is_Activity_Deleted__c=false
        AND CALENDAR_YEAR(Due_Date__c )=:fyear];
        list<String> totallst=new list<String>();
        list<String> totallst1=new list<String>();
        Map<String, List<String>> mapofHOPact = new Map<String, List<String>>();
        integer total=0,total1=0; string total12; 
        decimal  sum=0;
        for(Activity__c ar:ActivityDiamension){
            if(ar.Diamension_For_Score__c==null)
            {
                ar.Diamension_For_Score__c='0';
                
            }
            if(ar.Diamension_With_Score__c==null)
            {
                ar.Diamension_With_Score__c='0';
                
            }
            if(ar.Diamension_InOn_Score__c==null)
            {
                ar.Diamension_InOn_Score__c='0';
                
            }
            if(ar.Diamension_Thorugh_Score__c==null)
            {
                ar.Diamension_Thorugh_Score__c='0';
                
            }
            if(ar.Diamension_By_Score__c==null)
            {
                ar.Diamension_By_Score__c='0';
                
            }
            
            
            
            System.debug('totallst232323>>>>>>>>>>>>>>>>>>>'+totallst);  
            
        }
        if(!ActivityDiamension.isEmpty()){
            
            for(Activity__c c:ActivityDiamension){
                totallst=new list<String>();
                //system.debug('55======>'+c.By_ActivityGMDdelivered__c);
                if(!mapofHOPact.containsKey(c.Name)){
                    
                    total=Integer.valueof(c.Diamension_By_Score__c)+Integer.valueof(c.Diamension_Thorugh_Score__c)+Integer.valueof(c.Diamension_InOn_Score__c)+Integer.valueof(c.Diamension_With_Score__c)+Integer.valueof(c.Diamension_For_Score__c);
                    total12=String.valueof(total);
                    
                    totallst.add(c.Diamension_For_Score__c);
                    system.debug('c.Diamension_For_Score__c==>'+c.Diamension_For_Score__c);
                    totallst.add(c.Diamension_With_Score__c);
                    totallst.add(c.Diamension_InOn_Score__c);
                    totallst.add(c.Diamension_Thorugh_Score__c);
                    totallst.add(c.Diamension_By_Score__c);
                    totallst.add(total12);
                    mapofHOPact.put(c.Name,totallst);
                    
                    
                }
                system.debug('54sdd==>'+mapofHOPact);
            }
        }
        
        
        return  mapofHOPact; 
    }
    
    @AuraEnabled
    public static Account fetchUserdata(){
        // return[select Id,Name,Sport_Logo__c from User where id =: userInfo.getUserId()];
        system.debug('contactId==>');
        User  contactIds = [select Id,ContactId	 from User where ContactId != null and  Id =: userInfo.getUserId()];//ContactId !=: null and
        system.debug('contactId==>'+contactIds.ContactId);
        Contact AccountIds =  [select Id,AccountId from Contact where AccountId != null and Id =: contactIds.ContactId];//AccountId != null and
        system.debug('AccountIds==>'+AccountIds);
        return [select Partner_Logo__c from Account where Id =: AccountIds.AccountId];
        
    }
    @AuraEnabled
    public static List<DataSet> LinkstoHOPoutcomes(Integer fyear){
        List<DataSet> dataSet = new List<DataSet>();
        list<String> status=new list<String>();
        //Status.add('Kaiwhakahaere participating as Leaders in their community');
        //Status.add('Increased opportunities to participate in sport and traditional physical recreation');
        //Status.add('Development and revitalisation of sport and traditional physical recreation');
        
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get('Activity__c');
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get('HOP_Outcome__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        system.debug('40==>'+pickListValuesList);
        for(String pickVal : pickListValuesList){
            Status.add(pickVal);
        }
        /*Status.add(pickListValuesList[0]);
Status.add(pickListValuesList[1]);
Status.add(pickListValuesList[2]);
Status.add(pickListValuesList[3]);*/
        
        
        
        List<Activity__c> Activity1_LinkstoHOPoutcomes = [SELECT Id, HOP_Outcome__c,Is_Activity_Deleted__c 
        FROM Activity__c 
        WHERE Is_Activity_Deleted__c=false
        AND CALENDAR_YEAR(Due_Date__c )=:fyear];
        
        
        List<Activity__c> Activity1 = [SELECT Id,Is_Activity_Deleted__c  FROM Activity__c WHERE Is_Activity_Deleted__c=false];
        list<decimal> totallst=new list<decimal>();
        Integer total0=0,total2=0,total1=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0,total9=0,total10=0,total11=0,
            total12=0,total13=0,total14=0,total15=0;  
        
        for(Activity__c ar : Activity1_LinkstoHOPoutcomes){
            if(ar.HOP_Outcome__c==status[0])
            {
                total0=0;
                
            }
            if(ar.HOP_Outcome__c==status[1]){
                total1 =1 + total1;
                system.debug('total1-->'+total1);
            }
            if(ar.HOP_Outcome__c==status[2]){
                total2 =total2+1;
                system.debug('total2-->'+total2);
            }
            if(ar.HOP_Outcome__c==status[3]){
                total3 =total3+1;
                system.debug('total3-->'+total3);
            }  
            if(status.size()>4){
                if(ar.HOP_Outcome__c==status[4]){
                    total4 =total4+1;
                }
            }
            if(status.size()>5){
                if(ar.HOP_Outcome__c==status[5]){
                    total5 =total5+1;
                }
            }
            
            if(status.size()>6){
                if(ar.HOP_Outcome__c==status[6]){
                    total6 =total6+1;
                }
            }
            if(status.size()>7){
                if(ar.HOP_Outcome__c==status[7]){
                    total7 =total7+1;
                }
            }
            
            if(status.size()>8){
                if(ar.HOP_Outcome__c==status[8]){
                    total8 =total8+1;
                }
            }
            if(status.size()>9){
                if(ar.HOP_Outcome__c==status[9]){
                    total9 =total9+1;
                }
            }
            if(status.size()>10){
                if(ar.HOP_Outcome__c==status[10]){
                    total10 =total10+1;
                }
            }
            if(status.size()>11){
                if(ar.HOP_Outcome__c==status[11]){
                    total11 =total11+1;
                }
            }
            if(status.size()>12){
                if(ar.HOP_Outcome__c==status[12]){
                    total12 =total12+1;
                }
            }
            if(status.size()>13){
                if(ar.HOP_Outcome__c==status[13]){
                    total13 =total13+1;
                }
            }
            if(status.size()>14){
                if(ar.HOP_Outcome__c==status[14]){
                    total14 =total14+1;
                }
            }
            if(status.size()>15){
                if(ar.HOP_Outcome__c==status[15]){
                    total15 =total15+1;
                }
            }
            
        }
        
        Integer TotalForHOP=total1+total2+total3+total4+total5+total6+total7+total8+total9+total10+total11+
            total12+total13+total14+total15;
        system.debug('TotalForHOP==>'+TotalForHOP);
        /*//decimal firstPickval=((total1*100)/TotalForHOP);
// Decimal d = 5;
// d = d.divide(3, 30);
//System.debug('>>> ' + d);*/
        decimal Pickval4,Pickval5,Pickval6,Pickval7,Pickval8,Pickval9,Pickval10,Pickval11,Pickval12,Pickval13,Pickval14,Pickval15;
        decimal firstPickval=(total1*100);
        firstPickval=firstPickval.divide(TotalForHOP, 3);
        
        decimal SecondPickval=(total2*100);
        SecondPickval=SecondPickval.divide(TotalForHOP, 3);
        
        decimal ThirdPickval=(total3*100);
        ThirdPickval=ThirdPickval.divide(TotalForHOP, 3);
        
        if(status.size()>4){
            Pickval4=(total4*100);
            Pickval4=Pickval4.divide(TotalForHOP, 3);
        }
        if(status.size()>5){
            Pickval5=(total5*100);
            Pickval5=Pickval5.divide(TotalForHOP, 3);
        }
        if(status.size()>6){
            Pickval6=(total6*100);
            Pickval6=Pickval6.divide(TotalForHOP, 3);
        }
        if(status.size()>7){
            Pickval7=(total7*100);
            Pickval7=Pickval7.divide(TotalForHOP, 3);
        }
        if(status.size()>8){
            Pickval8=(total8*100);
            Pickval8=Pickval8.divide(TotalForHOP, 3);
        }
        if(status.size()>9){
            Pickval9=(total9*100);
            Pickval9=Pickval9.divide(TotalForHOP, 3);
        }
        if(status.size()>10){
            Pickval10=(total10*100);
            Pickval10=Pickval10.divide(TotalForHOP, 3);
        }
        if(status.size()>11){
            Pickval11=(total11*100);
            Pickval11=Pickval11.divide(TotalForHOP, 3);
        }
        if(status.size()>12){
            Pickval12=(total12*100);
            Pickval12=Pickval12.divide(TotalForHOP, 3);
        }
        if(status.size()>13){
            Pickval13=(total13*100);
            Pickval13=Pickval13.divide(TotalForHOP, 3);
        }
        if(status.size()>14){
            Pickval14=(total14*100);
            Pickval14=Pickval14.divide(TotalForHOP, 3);
        }
        if(status.size()>15){
            Pickval15=(total15*100);
            Pickval15=Pickval15.divide(TotalForHOP, 3);
        }
        
        
        totallst.add(total0);
        totallst.add(firstPickval);
        totallst.add(SecondPickval);
        totallst.add(ThirdPickval);
        if(status.size()>4){
            totallst.add(Pickval4);
        }
        if(status.size()>5){
            totallst.add(Pickval5);
        }
        if(status.size()>6){
            totallst.add(Pickval6);
        }
        if(status.size()>7){
            totallst.add(Pickval7);
        }
        if(status.size()>8){
            totallst.add(Pickval8);
        }
        if(status.size()>9){
            totallst.add(Pickval9);
        }
        if(status.size()>10){
            totallst.add(Pickval10);
        }
        if(status.size()>11){
            totallst.add(Pickval11);
        }
        if(status.size()>12){
            totallst.add(Pickval12);
        }
        if(status.size()>13){
            totallst.add(Pickval13);
        }
        if(status.size()>14){
            totallst.add(Pickval14);
        }
        if(status.size()>15){
            totallst.add(Pickval15);
        }
        
        system.debug('totallst'+ThirdPickval);
        integer i=0;
        
        while(i<status.size())
        {        
            dataSet.add(new DataSet(status[i] ,totallst[i]));
            i++;
        }
        system.debug('ddddddddd'+dataSet);
        return dataSet ; 
        
    }
    @AuraEnabled 
    public static Boolean isApprovedActivities(string id){
        system.debug('id==>'+id);
        List<Activity__c> activity = [SELECT id,Name,Is_Read_Only__c,OwnerId,Is_Activity_Deleted__c FROM Activity__c where id =:id AND Is_Activity_Deleted__c=false];
        if(activity.size()>0){
            if(activity[0].Is_Read_Only__c == true){
                system.debug('activity[0].Is_Read_Only__c'+activity[0].Is_Read_Only__c);
                activity[0].Is_Read_Only__c=false;
                update activity;
                system.debug('activity[0].Is_Read_Only__c'+activity[0].Is_Read_Only__c);
                return false;
            }
            else{
                return true;
            }
        }
        else{
            return true;
        }
        
    }
    @AuraEnabled
    public static void deleteSelectedActivity (string id) {
        
        List<Activity__c> lstAct = [select Id,Is_Activity_Deleted__c from Activity__c where Id=:id AND Is_Activity_Deleted__c=false];
        
        system.debug('27==>'+lstAct);
        
        delete lstAct;
    }
    
}