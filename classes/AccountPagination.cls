public   with sharing class AccountPagination { 
     
    @AuraEnabled(cacheable=true) 
    public static AccountWrapper getAccount(Integer pageNumber ,Integer recordToDisplay) { 
        // create an instance of wrapper class. 
        AccountWrapper AccountWrapperObject = new AccountWrapper(); 
        // set the pageSize,Page(Number), total records and accounts List(using OFFSET)    
        AccountWrapperObject.recordToDisplay = recordToDisplay; 
        AccountWrapperObject.pageNumber = pageNumber; 
        AggregateResult[] groupedResults  = [SELECT count(Id)cnt FROM Account]; 
        AccountWrapperObject.totalAccount = Integer.valueof(groupedResults[0].get('cnt')); 
        System.debug('**** Offset '+(pageNumber - 1) * recordToDisplay); 
        AccountWrapperObject.AccountListToDisplay = [SELECT Id, Name,Phone FROM Account ORDER BY Name LIMIT :recordToDisplay OFFSET :(pageNumber - 1) * recordToDisplay]; 
         
        return AccountWrapperObject; 
    } 
     
    // create a wrapper class with @AuraEnabled Properties     
    public class AccountWrapper { 
        @AuraEnabled public Integer recordToDisplay {get;set;} 
        @AuraEnabled public Integer pageNumber {get;set;} 
        @AuraEnabled public Integer totalAccount {get;set;} 
        @AuraEnabled public List<Account> AccountListToDisplay {get;set;} 
    } 
}