```abap
@EndUserText.label : '판매실적'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsales_sk {

  key client    : abap.clnt not null;
  key sales_id  : sysuuid_x16 not null;
  pr_id         : sysuuid_x16;
  item_no       : abap.numc(6);
  material_id   : abap.char(8);
  unit          : abap.unit(3);
  @Semantics.quantity.unitOfMeasure : 'zsales_sk.unit'
  quantity      : abap.quan(13,3);
  currency      : abap.cuky;
  @Semantics.amount.currencyCode : 'zsales_sk.currency'
  price         : abap.curr(15,2);
  buyer_id      : abap.char(12);
  processed_by  : abap.char(12);
  receive_month : abap.char(6);

}
```