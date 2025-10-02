```abap
@EndUserText.label : '구매요청헤더'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zpr_hdr_sk {

  key client      : abap.clnt not null;
  key pr_id       : sysuuid_x16 not null;
  status          : abap.char(1);
  currency        : abap.cuky;
  @Semantics.amount.currencyCode : 'zpr_hdr_sk.currency'
  total_price     : abap.curr(15,2);
  buyer_id        : abap.char(12);
  address         : abap.char(60);
  created_at      : abp_creation_tstmpl;
  created_by      : abp_creation_user;
  purchase_at     : abap.datn;
  receive_at      : abap.datn;
  last_changed_at : abp_lastchange_tstmpl;
  last_changed_by : abp_lastchange_user;
  note            : abap.char(255);

}
```