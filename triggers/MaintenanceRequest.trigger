trigger MaintenanceRequest on Case (after update) {
List<Case> newrequests = new List<Case>();
List<Product2> equipments = [SELECT Id, Maintenance_cycle__c FROM Product2];
Map<Id, Integer> equip_maintenance = new Map<Id, Integer>();
for(Product2 p: equipments){
    equip_maintenance.put(p.Id, (Integer) p.Maintenance_cycle__c);
}
for(Case c: Trigger.new){
    if((c.Type == 'Routine Maintenance' || c.Type == 'Repair') && c.IsClosed == true ){
        newrequests.add(new Case(Subject = 'New Maintenance Request', Origin = 'Phone', Status = 'New', ProductId = c.ProductId, Vehicle__c = c.Vehicle__c, Date_Due__c = Date.today().addDays(equip_maintenance.get(c.ProductId)) , Date_Reported__c = Date.today()));
    }
}
MaintenanceRequestHelper.updateWorkOrders(newrequests);
}