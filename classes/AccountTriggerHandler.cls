public with sharing class AccountTriggerHandler {

    public static void CreateAccounts(List<Account> accnts){               
        for(Integer i=0;i<accnts.size();i++){
            accnts.get(i).ShippingState = accnts.get(i).BillingState;
        }
    }
}