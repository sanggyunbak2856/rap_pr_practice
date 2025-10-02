```abap
@EndUserText.label : '구매요청아이템'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zpr_itm_sk {

  key client      : abap.clnt not null;
  key pr_id       : sysuuid_x16 not null;
  key item_no     : sysuuid_x16 not null;
  material_id     : abap.char(8);
  unit            : abap.unit(3);
  @Semantics.quantity.unitOfMeasure : 'zpr_itm_sk.unit'
  quantity        : abap.quan(13,3);
  currency        : abap.cuky;
  @Semantics.amount.currencyCode : 'zpr_itm_sk.currency'
  price           : abap.curr(15,2);
  last_changed_at : abp_lastchange_tstmpl;
  last_changed_by : abp_lastchange_user;

}
```