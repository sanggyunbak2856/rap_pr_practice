```abap
@EndUserText.label : 'Draft table for entity ZSK_R_PR_ITM'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zpr_itm_sk_draft {

  key mandt     : mandt not null;
  key prid      : sysuuid_x16 not null;
  key itemno    : sysuuid_x16 not null;
  materialid    : abap.char(8);
  unit          : abap.unit(3);
  @Semantics.quantity.unitOfMeasure : 'zpr_itm_sk_draft.unit'
  quantity      : abap.quan(13,3);
  currency      : abap.cuky;
  @Semantics.amount.currencyCode : 'zpr_itm_sk_draft.currency'
  price         : abap.curr(15,2);
  lastchangedat : abp_lastchange_tstmpl;
  lastchangedby : abp_lastchange_user;
  "%admin"      : include sych_bdl_draft_admin_inc;

}
```