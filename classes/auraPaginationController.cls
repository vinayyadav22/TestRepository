public class auraPaginationController {
  @AuraEnabled
    public static List <Contact> getContactData(){
        List<Contact> contactList = new  List<Contact>(); 
      contactList=[SELECT Id, Name, MobilePhone,Email,Owner.Name FROM Contact LIMIT 100];
        return contactList;
    }
}