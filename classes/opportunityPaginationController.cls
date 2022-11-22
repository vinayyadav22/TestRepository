public with sharing class opportunityPaginationController {

    public class opportunityItemWrapper {       
        public Integer recordStart {get;set;}
        public Integer pageNumber {get;set;}
        public Integer totalRecords {get;set;}
        public Integer recordEnd {get;set;}
        public Integer pageSize {get;set;}       
        public List<Opportunity> oppList {get;set;}
    }
    
    @Auraenabled
    public static String getOpportunityList(Integer pageSize, Integer pageNumber){
        String jsonObjItm = '';
         
        
        Integer offset = (pageNumber - 1) * pageSize;         
        
        Integer totalRecords = [SELECT COUNT() FROM Opportunity];
        Integer recordEnd = pageSize * pageNumber;
         
        opportunityItemWrapper oppObj =  new opportunityItemWrapper();  
        oppObj.pageNumber = pageNumber;
        oppObj.pageSize = pageSize;        
        oppObj.recordStart = offset + 1;
        oppObj.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        oppObj.totalRecords = totalRecords;
        oppObj.oppList = [SELECT Id, Name FROM Opportunity LIMIT :pageSize OFFSET :offset];
        jsonObjItm = JSON.serialize(oppObj);
        return jsonObjItm;
    }

}