```abap
@EndUserText.label : '재고'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zstock_sk {

  key client      : abap.clnt not null;
  key material_id : abap.char(8) not null;
  unit            : abap.unit(3);
  @Semantics.quantity.unitOfMeasure : 'zstock_sk.unit'
  quantity        : abap.quan(13,3);
  last_changed_at : abp_lastchange_tstmpl;
  last_changed_by : abp_lastchange_user;

}
```