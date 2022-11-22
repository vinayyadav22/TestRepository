trigger AccountUpdate on Opportunity (After insert,After Update) {
  Map<Id,Opportunity> newOpty = new Map<Id,Opportunity>();
    for(Opportunity opp:trigger.new) {
        newOpty.put(opp.AccountId, opp);
    }
    system.debug('newOpty----->'+newOpty);
    
    List<Account> accList=[SELECT Id,Name,Phone,(SELECT accountId,phone__c from Opportunities) FROM Account where Id IN:newOpty.keyset()];
    for(Account ac:accList) {
        ac.Phone =newOpty.get(ac.Id).phone__c;
    }
    update accList;
}