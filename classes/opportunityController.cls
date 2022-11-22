public class opportunityController {
    @AuraEnabled
    public static List <Opportunity> getOpportunityData(){
        List<Opportunity> oppList = new  List<Opportunity>(); 
      oppList=[SELECT StageName,MSA_SOW_Closure_date__c,Total_TCS__c,Take_action__c from Opportunity];
        return oppList;
    }
}