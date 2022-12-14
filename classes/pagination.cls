public with sharing class pagination {

     /**
      * Webkul Software.
      *
      * @category  Webkul
      * @author    Webkul
      * @copyright Copyright (c) 2010-2016 Webkul Software Private Limited (https://webkul.com)
      * @license   https://store.webkul.com/license.html
      */ 
     
     @AuraEnabled
     public list<account> acc;
     
     @AuraEnabled 
     public integer offst;
     
     @AuraEnabled 
     public integer total;
     
     @AuraEnabled 
     public boolean hasprev;
     
     @AuraEnabled 
     public boolean hasnext;
     
     private static integer pagesize=8;
     private static integer offset;
     
     @AuraEnabled
     public static pagination getacc(boolean next,boolean prev,decimal off){
     	offset = (integer)off;
     	list<account> li = new list<account>();
     	integer listlength = [Select count() from account where name!=null];
     	if(!schema.sobjecttype.Account.isaccessible()){
     		li = new list<account>();
     	}else{
	     if(next==false && prev==false){
		 li = [Select id,name,accountSource,AccountNumber,Active__c from account LIMIT :pagesize OFFSET :offset];
	     }else if(next==true && (offset+pagesize)<=listlength){
	          offset=offset+pagesize;
		  li = [Select id,name,accountSource,AccountNumber,Active__c from account LIMIT :pagesize OFFSET :offset];
	     }else if(prev==true && offset>0){
		  offset=offset-pagesize;
		  li = [Select id,name,accountSource,AccountNumber,Active__c from account LIMIT :pagesize OFFSET :offset];
	     }
     	}
     	pagination pg = new pagination();
     	pg.acc = li;
	pg.offst = offset;
	pg.hasprev = hasprev(offset);   
     	pg.hasnext = hasnxt(offset,listlength,pagesize);
     	
     	return pg;
     }
     
     private static boolean hasprev(integer off){
        if(off>0)
            return false;
        return true; 
    }
   
     private static boolean hasnxt(integer off,integer li,integer ps){
        if(off+ps<li)
            return false;
        return true;
    }    
}