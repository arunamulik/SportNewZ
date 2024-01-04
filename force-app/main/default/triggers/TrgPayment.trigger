trigger TrgPayment on Payment__c(before insert, before update, after insert, after update, after delete, after undelete) {
    system.debug('RecursionHandler.getRunTimes  --------P---------------' + RecursionHandler.getRunTimes() + '-----Before--------------' + Trigger.isBefore + '---------Insert-------' + Trigger.isInsert + '----------------');
    system.debug('@ Start --TrgPayment CPU Limits >>>>>>>>>>> ' + Limits.getCpuTime());
    public class MyCatchException extends Exception {}


    //IsVariationInititated__c IsVariation = IsVariationInititated__c.getInstance(UserInfo.getProfileId());
    //added on 10/08/2018 static variable used to keep it as per user transaction and not org.
    Boolean isVariationInitiatied = RecursionHandler.TrgVariationBypass;
    /*if(IsVariation != null){
        // system.debug('CS Value ----------------------'+IsVariation.Variation_Inititated__c); 
         isVariationInitiatied = IsVariation.Variation_Inititated__c;
    }*/
    system.debug('>>>>>>>>>>>>>>>>>>>>>>>>' + isVariationInitiatied);
    system.debug('PaymentTriggerhandler.getCatch>>>>>>>>>>>>>>>>>>>>>>>>' + PaymentTriggerhandler.getCatch);
    system.debug(PaymentTriggerhandler.getCatch);
    system.debug(Integer.valueOf(Label.Cpu_Time_Limit));
    system.debug('Integer.valueOf(Label.Cpu_Time_Limit)>>>>' + Limits.getCpuTime());
    if (Limits.getCpuTime() < Integer.valueOf(Label.Cpu_Time_Limit)) {
        if (RecursionHandler.getRunTimes() < 16 && !isVariationInitiatied) {
            // Added by JTan 19/06/2017 begins
            /* if(Trigger.isBefore && Trigger.isUpdate && !isVariationInitiatied ){
                system.debug('Inside this>>>>>');
                PaymentTriggerhandler.checkVariationCondition(Trigger.new,trigger.oldMap);
            }*/


            if (Trigger.isBefore) {
                PaymentTriggerhandler.validatePayments(Trigger.new);
                PaymentTriggerhandler.updateOldRecordType(Trigger.new);
            }
            // Added by JTan 19/06/2017 ends
            if (Trigger.IsBefore && Trigger.IsInsert) {
                PaymentTriggerhandler.updatePartner(Trigger.new);
            }
            //Payment is inserted or deleted
            if (Trigger.isAfter) {

                if (Trigger.IsInsert || Trigger.isUndelete) {
                    PaymentTriggerhandler.processPayments(Trigger.new);
                }
                // Added on 1st July 2015 to check if payment status is schedule then need to enforce initiative mandatory fields to be entered
                // Added on 7th July 2015
                // If investment schedule status is "Signed" then enforced to enter payment status to "Scheduled" and send for payment to checked
                if (Trigger.IsInsert) {
                    //Changes for Port 112
                    PaymentTriggerhandler.updateInvestmentSchedule(Trigger.new);
                    PaymentTriggerhandler.validateStatusToScheduled(Trigger.newMap);
                    //Added on 14/7/2015
                    PaymentTriggerhandler.validateInitiativePlannedAmt(Trigger.newMap, null);
                }
                if (Trigger.isDelete) {
                    PaymentTriggerhandler.processPayments(Trigger.old); //pass old id to get partner
                }
                //Payment initiative? or payment date is updated
                if (Trigger.isUpdate) {

                    //system.debug('@7--TrgPayment CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
                    //Changes for PORT-112
                    List < Payment__c > paymentlst = PaymentTriggerhandler.filterPaymentPlan(Trigger.newMap, Trigger.oldMap);
                    if (paymentlst != null && !paymentlst.isEmpty()) {
                        try {

                            PaymentTriggerhandler.updateInvestmentSchedule(paymentlst);
                            if (PaymentTriggerhandler.getCatch) {
                                throw new MyCatchException('First exception');
                            }

                        } catch (Exception e) {
                            PaymentTriggerhandler.createLog(e, 'updateInvestmentSchedule');

                        }
                    }
                    try {

                        PaymentTriggerHandler.updatedPayments(Trigger.oldMap, Trigger.new);
                        if (PaymentTriggerhandler.getCatch) {
                            throw new MyCatchException('First exception');
                        }
                    } catch (Exception e) {

                        PaymentTriggerhandler.createLog(e, 'updatedPayments');
                    }

                    // Added on 1st July 2015 to check if payment status is schedule then need to enforce initiative mandatory fields to be entered
                    PaymentTriggerhandler.onPaymentStatusChanedToSchedule(Trigger.newMap, Trigger.oldMap);

                    // If investment schedule status is "Signed" then enforced to enter payment status to "Scheduled" and send for payment to checked
                    //if (Trigger.isUpdate){
                    //system.debug('@8--TrgPayment CPU Limits >>>>>>>>>>> '+Limits.getCpuTime());
                    try {

                        PaymentTriggerhandler.validateStatusToScheduled(Trigger.newMap);
                        if (PaymentTriggerhandler.getCatch) {
                            throw new MyCatchException('First exception');
                        }
                    } catch (Exception e) {

                        PaymentTriggerhandler.createLog(e, 'validateStatusToScheduled');
                    }

                    //Added on 14/7/2015
                    System.Debug('Debug :: Validation Method called :: New map' + Trigger.newMap);
                    System.Debug('Debug :: Validation Method called :: Old map' + Trigger.oldMap);
                    PaymentTriggerhandler.validateInitiativePlannedAmt(Trigger.newMap, Trigger.oldMap);
                    //Update variation

                    try {

                        PaymentTriggerhandler.updateVariation(Trigger.newMap, Trigger.oldMap);
                        if (PaymentTriggerhandler.getCatch) {
                            throw new MyCatchException('First exception');
                        }
                    } catch (Exception e) {

                        PaymentTriggerhandler.createLog(e, 'updateVariation');
                    }

                    //}
                }
            }
            system.debug('@END --TrgPayment CPU Limits >>>>>>>>>>> ' + Limits.getCpuTime());
            RecursionHandler.setRunTimes();
        }
    }
}