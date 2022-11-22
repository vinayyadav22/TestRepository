@isTest
public class AccountTriggerTest {
    @isTest
    static void TestCreateAccountInBulk(){
        List<Account> accntList = new List<Account>();
        for(Integer i=0;i<200;i++){
            Account account = new Account(Name='Test Accnt '+ i,BillingState='CA');
            accntList.add(account);
        }
        Test.startTest();
        insert accntList;
        Test.stopTest();
        
        List<Account> verifyAccnt = [SELECT Id FROM Account WHERE ShippingState='CA' AND BillingState='CA'];
        System.assertEquals(200, verifyAccnt.size());
    }
}