@RestResource(urlMapping='/MFITUpdateActivity/*')
global with sharing class MFITUpdateActivity {
    private static final String RESPONSE_SUCCESS = 'Success';
    private static final String RESPONSE_ERROR = 'Error';
    
    @HTTPPost
    global static List<MessageResponseClass> updateActivity(List<twrActivityToUpdate>activityToUpdate) {
        Set<String> activityReferenceIdSet =  new Set<String>();
        List<MessageResponseClass> lstResponse = new List<MessageResponseClass>();
        
        Map<String, Integer> mapActivityIDParticipationNoOfParticipants = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeofparticipantsdidnotrespond = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsMokopuna = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsRangatahi13_15 = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsRangatahi16_19 = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsRangatahi13_19 = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsPakeke20_39 = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsMatua20_39 = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsPakeke40_59 = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsKaumatua = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDAgeOfParticipantsTaiohi = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDGenderOfParticipantsDidNotRespond = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDGenderOfParticipantsTane = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDGenderOfParticipantsWahine = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDEthnicityOfParticipantsDidNotRespond = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDEthnicityOfParticipantsMaori = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDEthnicityOfParticipantsNonMaori = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeMarae = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeHapu = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypelwi = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeWhnau = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeKohangaPunaReo = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeKuraKaupapa = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeWhareKura = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeWhareWananga = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeKaupapaHkina = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeOther = new Map<String, Integer>();
        Map<String, Integer> mapActivityIDParticaipationWhanauTypeTotal = new Map<String, Integer>();
        //
                
        List<Activity__C> activityListToUpdate = new List<Activity__C>();
        
        try {
            for (twrActivityToUpdate activityInfo : activityToUpdate) {
                if(String.isNotBlank(activityInfo.activityID)) {
                    activityReferenceIdSet.add(activityInfo.activityID);
                    System.debug('activityInfo.activityID###'+activityInfo.activityID);
                    System.debug('activityInfo.participationNoOfParticipants###'+activityInfo.participationNoOfParticipants);
                    mapActivityIDParticipationNoOfParticipants.put(activityInfo.activityID, activityInfo.participationNoOfParticipants);
                    mapActivityIDAgeofparticipantsdidnotrespond.put(activityInfo.activityID, activityInfo.ageofparticipantsdidnotrespond);
                    mapActivityIDAgeOfParticipantsMokopuna.put(activityInfo.activityID, activityInfo.ageOfParticipantsMokopuna);
                    mapActivityIDAgeOfParticipantsRangatahi13_15.put(activityInfo.activityID, activityInfo.ageOfParticipantsRangatahi13_15);
                    mapActivityIDAgeOfParticipantsRangatahi16_19.put(activityInfo.activityID, activityInfo.ageOfParticipantsRangatahi16_19);
                    mapActivityIDAgeOfParticipantsRangatahi13_19.put(activityInfo.activityID, activityInfo.ageOfParticipantsRangatahi13_19);
                    mapActivityIDAgeOfParticipantsPakeke20_39.put(activityInfo.activityID, activityInfo.ageOfParticipantsPakeke20_39);
                    mapActivityIDAgeOfParticipantsMatua20_39.put(activityInfo.activityID, activityInfo.ageOfParticipantsMatua20_39);
                    mapActivityIDAgeOfParticipantsPakeke40_59.put(activityInfo.activityID, activityInfo.ageOfParticipantsPakeke40_59);
                    mapActivityIDAgeOfParticipantsKaumatua.put(activityInfo.activityID, activityInfo.ageOfParticipantsKaumatua);
                    mapActivityIDAgeOfParticipantsTaiohi.put(activityInfo.activityID, activityInfo.ageOfParticipantsTaiohi);
                    mapActivityIDGenderOfParticipantsDidNotRespond.put(activityInfo.activityID, activityInfo.genderOfParticipantsDidNotRespond);
                    mapActivityIDGenderOfParticipantsTane.put(activityInfo.activityID, activityInfo.genderOfParticipantsTane);
                    mapActivityIDGenderOfParticipantsWahine.put(activityInfo.activityID, activityInfo.genderOfParticipantsWahine);
                    mapActivityIDEthnicityOfParticipantsDidNotRespond.put(activityInfo.activityID, activityInfo.ethnicityOfParticipantsDidNotRespond);
                    mapActivityIDEthnicityOfParticipantsMaori.put(activityInfo.activityID, activityInfo.ethnicityOfParticipantsMaori);
                    mapActivityIDEthnicityOfParticipantsNonMaori.put(activityInfo.activityID, activityInfo.ethnicityOfParticipantsNonMaori);
                    mapActivityIDParticaipationWhanauTypeMarae.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeMarae);
                    mapActivityIDParticaipationWhanauTypeHapu.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeHapu);
                    mapActivityIDParticaipationWhanauTypelwi.put(activityInfo.activityID, activityInfo.particaipationWhanauTypelwi);
                    mapActivityIDParticaipationWhanauTypeWhnau.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeWhnau);
                    mapActivityIDParticaipationWhanauTypeKohangaPunaReo.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeKohangaPunaReo);
                    mapActivityIDParticaipationWhanauTypeKuraKaupapa.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeKuraKaupapa);
                    mapActivityIDParticaipationWhanauTypeWhareKura.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeWhareKura);
                    mapActivityIDParticaipationWhanauTypeWhareWananga.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeWhareWananga);
                    mapActivityIDParticaipationWhanauTypeKaupapaHkina.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeKaupapaHkina);
                    mapActivityIDParticaipationWhanauTypeOther.put(activityInfo.activityID, activityInfo.particaipationWhanauTypeOther);
                    
                    /*
                     
                    service Integer ;
        webservice Integer ;
        webservice Integer ;
        webservice Integer ;
        webservice Integer ;
        webservice Integer ;
        webservice Integer ;
        webservice Integer ;
        webservice Integer ;
        webservice Integer ;
        webservice Integer ;*/
                    
                    
                }
            }
            system.debug('activityReferenceIdSet' + activityReferenceIdSet);
            
            // Check if activityId is valid
            for (Activity__c activityObj : [ SELECT Id,
                                            Name
                                            FROM 
                                            Activity__c 
                                            WHERE 
                                            Id IN :activityReferenceIdSet
                                           ])
            {
                System.debug('activityObj###'+activityObj);
                System.debug('activityObj.Name###'+activityObj.Name);
                activityObj.Participation_NoOfParticipants__c = Integer.valueOf(mapActivityIDParticipationNoOfParticipants.get(activityObj.Id));
                activityObj.AgeOfParticipants_DidNotRespond__c = Integer.valueOf(mapActivityIDAgeofparticipantsdidnotrespond.get(activityObj.Id));
                activityObj.AgeOfParticipants_Mokopuna__c = Integer.valueOf(mapActivityIDAgeOfParticipantsMokopuna.get(activityObj.Id));
                activityObj.AgeOfParticipants_Rangatahi13_15__c = Integer.valueOf(mapActivityIDAgeOfParticipantsRangatahi13_15.get(activityObj.Id));
                activityObj.AgeOfParticipants_Rangatahi16_19__c = Integer.valueOf(mapActivityIDAgeOfParticipantsRangatahi16_19.get(activityObj.Id));
                activityObj.AgeOfParticipants_Rangatahi13_19__c = Integer.valueOf(mapActivityIDAgeOfParticipantsRangatahi13_19.get(activityObj.Id));
                activityObj.AgeOfParticipants_Pakeke_20_39__c = Integer.valueOf(mapActivityIDAgeOfParticipantsPakeke20_39.get(activityObj.Id));
                activityObj.AgeOfParticipants_Matua_20_39__c = Integer.valueOf(mapActivityIDAgeOfParticipantsMatua20_39.get(activityObj.Id));
                activityObj.AgeOfParticipants_Pakeke40_59__c = Integer.valueOf(mapActivityIDAgeOfParticipantsPakeke40_59.get(activityObj.Id));
                activityObj.AgeOfParticipants_Kaum_tua__c = Integer.valueOf(mapActivityIDAgeOfParticipantsKaumatua.get(activityObj.Id));
                activityObj.AgeOfParticipants_Taiohi__c = Integer.valueOf(mapActivityIDAgeOfParticipantsTaiohi.get(activityObj.Id));
                activityObj.GenderOfParticipants_DidNotRespond__c = Integer.valueOf(mapActivityIDGenderOfParticipantsDidNotRespond.get(activityObj.Id));
                activityObj.GenderOfParticipants_Tane__c = Integer.valueOf(mapActivityIDGenderOfParticipantsTane.get(activityObj.Id));
                activityObj.GenderOfParticipants_Wahine__c = Integer.valueOf(mapActivityIDGenderOfParticipantsWahine.get(activityObj.Id));
                activityObj.EthnicityOfParticipants_DidNotRespond__c = Integer.valueOf(mapActivityIDEthnicityOfParticipantsDidNotRespond.get(activityObj.Id));
                activityObj.EthnicityOfParticipants_M_ori__c = Integer.valueOf(mapActivityIDEthnicityOfParticipantsMaori.get(activityObj.Id));
                activityObj.EthnicityOfParticipants_Non_M_ori__c = Integer.valueOf(mapActivityIDEthnicityOfParticipantsNonMaori.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_Marae__c	= Integer.valueOf(mapActivityIDParticaipationWhanauTypeMarae.get(activityObj.Id));
				activityObj.Particaipation_WhanauType_Hapu__c	= Integer.valueOf(mapActivityIDParticaipationWhanauTypeHapu.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_lwi__c = Integer.valueOf(mapActivityIDParticaipationWhanauTypelwi.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_Wh_nau__c= Integer.valueOf(mapActivityIDParticaipationWhanauTypeWhnau.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_KohangaPunaReo__c= Integer.valueOf(mapActivityIDParticaipationWhanauTypeKohangaPunaReo.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_Kura_Kaupapa__c= Integer.valueOf(mapActivityIDParticaipationWhanauTypeKuraKaupapa.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_Whare_Kura__c= Integer.valueOf(mapActivityIDParticaipationWhanauTypeWhareKura.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_Whare_Wananga__c= Integer.valueOf(mapActivityIDParticaipationWhanauTypeWhareWananga.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_Kaupapa_H_kina__c= Integer.valueOf(mapActivityIDParticaipationWhanauTypeKaupapaHkina.get(activityObj.Id));
                activityObj.Particaipation_WhanauType_Other__c= Integer.valueOf(mapActivityIDParticaipationWhanauTypeOther.get(activityObj.Id));
               
                   //
                System.debug('Updating');
                activityListToUpdate.add(activityObj);
                
            }
            
            if(!activityListToUpdate.isEmpty()) {
                Map<String, MessageResponseClass> mapActiviyIdVsSuccessResponse = new Map<String, MessageResponseClass>();
                
                Database.SaveResult[] lstUpdateAcitivtyId = Database.update(activityListToUpdate, true);
                System.debug('lstUpdateAcitivtyId###'+lstUpdateAcitivtyId);
                
                for(integer i=0; i<lstUpdateAcitivtyId.size(); i++) {
                    String activityId = lstUpdateAcitivtyId[i].getId();
                    
                    if (lstUpdateAcitivtyId[i].isSuccess()) {
                        MessageResponseClass objResponse = getResponse(RESPONSE_SUCCESS,  
                                                                       activityId,
                                                                       201,
                                                                       RESPONSE_SUCCESS);
                        mapActiviyIdVsSuccessResponse.put(activityId, objResponse);
                        lstResponse.addAll(mapActiviyIdVsSuccessResponse.values());
                        
                    } else {
                        MessageResponseClass objResponse = getResponse(RESPONSE_ERROR,  
                                                                       activityId,
                                                                       500,
                                                                       RESPONSE_ERROR);
                        mapActiviyIdVsSuccessResponse.put(activityId, objResponse);
                        lstResponse.addAll(mapActiviyIdVsSuccessResponse.values());
                    }
                } 
            }
        } catch (Exception e) {
            System.debug('exp####'+e);
            String error = e.getMessage();
            lstResponse.add(getResponse(RESPONSE_ERROR,  
                                        '', 
                                        502,
                                        error));
        }
        return lstResponse;
    }
    
    public static MessageResponseClass getResponse(String strMsg, 
                                                   String strActivityId, 
                                                   Integer strResponseCode,
                                                   String strActivityStatus) {   
                                                       MessageResponseClass objMsg = new MessageResponseClass();
                                                       objMsg.responseCode = strResponseCode;
                                                       objMsg.responseStatus = strActivityStatus;
                                                       objMsg.responseMessage = strMsg;
                                                       //objMsg.orderReferenceNo = strOrderRefNo;
                                                       objMsg.activityId = strActivityId;
                                                       return objMsg;
                                                   }
    
    global class MessageResponseClass {
        webservice Integer responseCode;    
        webservice String responseStatus;
        webservice String responseMessage;
        webservice String activityId; 
    }
    
    global class twrActivityToUpdate {
        webservice string activityID;
        webservice Integer participationNoOfParticipants;
        webservice Integer ageofparticipantsdidnotrespond;
        webservice Integer ageOfParticipantsMokopuna;
        webservice Integer ageOfParticipantsRangatahi13_15;
        webservice Integer ageOfParticipantsRangatahi16_19;
        webservice Integer ageOfParticipantsRangatahi13_19;
        webservice Integer ageOfParticipantsPakeke20_39;
        webservice Integer ageOfParticipantsMatua20_39;
        webservice Integer ageOfParticipantsPakeke40_59;
        webservice Integer ageOfParticipantsKaumatua;
        webservice Integer ageOfParticipantsTaiohi;
        webservice Integer genderOfParticipantsDidNotRespond;
        webservice Integer genderOfParticipantsTane;
        webservice Integer genderOfParticipantsWahine;
        webservice Integer ethnicityOfParticipantsDidNotRespond;
        webservice Integer ethnicityOfParticipantsMaori;
        webservice Integer ethnicityOfParticipantsNonMaori;
        
        webservice Integer particaipationWhanauTypeMarae;
        webservice Integer particaipationWhanauTypeHapu;
        webservice Integer particaipationWhanauTypelwi;
        webservice Integer particaipationWhanauTypeWhnau;
        webservice Integer particaipationWhanauTypeKohangaPunaReo;
        webservice Integer particaipationWhanauTypeKuraKaupapa;
        webservice Integer particaipationWhanauTypeWhareKura;
        webservice Integer particaipationWhanauTypeWhareWananga;
        webservice Integer particaipationWhanauTypeKaupapaHkina;
        webservice Integer particaipationWhanauTypeOther;
        
    }
}