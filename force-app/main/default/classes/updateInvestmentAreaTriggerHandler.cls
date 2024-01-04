/*
* @ Author :- Navneet Rajput
* @ Date :- 15/6/2015
* @ Description :- 
* @ Change History :-  
*/
public with sharing class updateInvestmentAreaTriggerHandler {
	 
	 public static boolean isExecuted =false;
	 
	 public static boolean isDateMatched(Date pDate,Date sDate, Date eDate){
         system.debug('Inside updateInvestmentAreaTriggerHandler isDateMatched() method');
	 		boolean isTrue =false;
	 		Date startdate = Date.newInstance(sDate.year(),sDate.month(),sDate.day());
	 		system.debug('startdate >>>>>>>>>>>'+startdate);
	 		Date endDate = Date.newInstance(eDate.year(),eDate.month(),eDate.day());
	 		Date priceDate = Date.newInstance(pDate.year(),pDate.month(),pDate.day()); 
	 		system.debug('priceDate >>>>>>>>>> '+priceDate);
	 		system.debug('end Date >>>>>>>>>> '+endDate);
	 		system.debug('Start Date >>>>>>>>>> '+startDate);
	 	
	 		if (priceDate >=startdate && priceDate <= endDate){
	 			isTrue = true;
	 			system.debug('Its SUCCESS ############### ');
	 		}
	 		return isTrue; 
	 }
	 
	 public static void addPaymentToInvArea(List<Payment__c> payList){
                  system.debug('Inside updateInvestmentAreaTriggerHandler addPaymentToInvArea() method');

	 	isExecuted = true;
         //upsert payList;
         try
         {
	 		upsert payList;
         }
         catch(Exception e){
             System.debug(e);
         }
	 	system.debug('After Update >>>>>>>>>> '+payList);
	 }
}