@isTest
private class TestFundingAllocationTrigger {
    
    
    static testMethod void testUpdateStrategicAreaMethod(){
        
        //Create Strategic Area
        Strategic_Area__c strategicAreaObject = new Strategic_Area__c();
        strategicAreaObject.Name = 'Test Strategic Area';
        strategicAreaObject.Start_Date__c = date.today();
        strategicAreaObject.End_Date__c = date.today().addDays(5);
        insert strategicAreaObject;
        
        //Create Funding
       /* Funding__c fundingObject = new Funding__c();
        fundingObject.Name = 'Test Funding';
        fundingObject.Source__c = 'Appropriation';
        fundingObject.Start_Date__c = date.today();
        fundingObject.End_Date__c = date.today().addDays(5);
        fundingObject.Status__c = 'Approved';
        fundingObject.Funding__c = 100000;
        insert fundingObject;
     */   
        //Test 01 - Check Budget is null on Strategic Area
        Test.startTest();
        List<Strategic_Area__c> insertedStrategicArea = [select Budget__c from Strategic_Area__c where id=:strategicAreaObject.id];
        System.assertEquals(insertedStrategicArea[0].Budget__c,null);
                
        //Creating Draft Funding Allocation
   /*     Funding_Allocation__c fundingAllocationObject = new Funding_Allocation__c();
        fundingAllocationObject.Funding__c = fundingObject.id;
        //fundingAllocationObject.Strategic_Area__c = strategicAreaObject.id;
        fundingAllocationObject.Status__c = 'Draft';
        fundingAllocationObject.Funding_Amount__c = 50000;
        insert fundingAllocationObject;
    */    
        //Test 02 - Check Budget is 0 on Strategic Area
        List<Strategic_Area__c> insertedStrategicArea2 = [select Budget__c from Strategic_Area__c where id=:strategicAreaObject.id];
        //System.assertEquals(insertedStrategicArea2[0].Budget__c,0);
  /*      
        //Approve Funding Allocation
        List<Funding_Allocation__c> insertedFundingAllocation = [select Id, Status__c from Funding_Allocation__c where id=:fundingAllocationObject.id];
        insertedFundingAllocation[0].Status__c = 'Approved';        
        update insertedFundingAllocation;
        
        //Test 03 - Check Budget is 50000 on Strategic Area
        List<Strategic_Area__c> insertedStrategicArea3 = [select Budget__c from Strategic_Area__c where id=:strategicAreaObject.id];
        //System.assertEquals(insertedStrategicArea3[0].Budget__c,50000);
        
        //Delete Funding Allocation
        List<Funding_Allocation__c> insertedFundingAllocation2 = [select Id from Funding_Allocation__c where id=:fundingAllocationObject.id];
        delete insertedFundingAllocation2;
        
        //Test 04 - Check Budget is 0 on Strategic Area
        List<Strategic_Area__c> insertedStrategicArea4 = [select Budget__c from Strategic_Area__c where id=:strategicAreaObject.id];
        //System.assertEquals(insertedStrategicArea4[0].Budget__c,0);
        
        //Undelete Funding Allocation
        //List<Funding_Allocation__c> insertedFundingAllocation3 = [select Id from Funding_Allocation__c where id=:fundingAllocationObject.id];
        undelete insertedFundingAllocation2;
        
        //Test 05 - Check Budget is 0 on Strategic Area
        List<Strategic_Area__c> insertedStrategicArea5 = [select Budget__c from Strategic_Area__c where id=:strategicAreaObject.id];
        //System.assertEquals(insertedStrategicArea5[0].Budget__c,50000);
   */      
        Test.stopTest();
    }   
   
}