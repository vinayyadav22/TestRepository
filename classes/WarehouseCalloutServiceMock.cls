public class WarehouseCalloutServiceMock {
     private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';

    
    class Equipment{
        public Id id{get;set;}
        public boolean replacement{get;set;}
        public Integer quantity{get;set;}
        public String name{get;set;}
        public Decimal maintenanceperiod{get;set;}
        public Decimal lifespan{get;set;}
        public Decimal cost{get;set;}
        public String sku{get;set;}
    }
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true) public static void runWarehouseEquipmentSync(){
        
Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug(response);
        if(response.getStatusCode() == 200){
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            List<Product2> LstProduct = new List<Product2>();
            for(Object o : results)
            {
                Map<String, Object> mapobj = (Map<String, Object>)o;
                Product2 product = new Product2();
                Integer maintenanceperiod = (Integer)mapobj.get('maintenanceperiod');
                Integer Lifespan = (Integer)mapobj.get('lifespan');
                Integer Cost = (Integer)mapobj.get('cost');
                Boolean replacement = (Boolean)mapobj.get('replacement');
                Integer quantity = ((Integer)mapobj.get('qIntegerntity'));
                product.Name = (String)mapobj.get('name');
                product.Maintenance_Cycle__c = Integer.valueof(maintenanceperiod);
                product.Cost__c = Cost;
                product.Current_Inventory__c = quantity;
                product.Lifespan_Months__c = Lifespan;
                product.Replacement_Part__c = replacement;
                product.Warehouse_SKU__c = (String) mapobj.get('sku');
                product.ProductCode = (String)mapobj.get('_id'); 
                LstProduct.add(product);
            }
            System.debug(LstProduct);
            upsert LstProduct;
        

        }

    }

}