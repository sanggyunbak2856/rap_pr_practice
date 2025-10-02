```abap
@EndUserText.label : '자재'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zmaterial_sk {

  key client      : abap.clnt not null;
  key material_id : abap.char(8) not null;
  material_name   : abap.char(60);
  unit            : abap.unit(3);
  currency        : abap.cuky;
  @Semantics.amount.currencyCode : 'zmaterial_sk.currency'
  price           : abap.curr(15,2);
  last_changed_at : abp_lastchange_tstmpl;
  last_changed_by : abp_lastchange_user;

}
```