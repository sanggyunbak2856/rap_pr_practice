```abap
@EndUserText.label : 'Draft table for entity ZSK_R_PR_HDR'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zpr_hdr_sk_draft {

  key mandt     : mandt not null;
  key prid      : sysuuid_x16 not null;
  status        : abap.char(1);
  currency      : abap.cuky;
  @Semantics.amount.currencyCode : 'zpr_hdr_sk_draft.currency'
  totalprice    : abap.curr(15,2);
  buyerid       : abap.char(12);
  address       : abap.char(60);
  createdat     : abp_creation_tstmpl;
  createdby     : abp_creation_user;
  purchaseat    : abap.datn;
  receiveat     : abap.datn;
  lastchangedat : abp_lastchange_tstmpl;
  lastchangedby : abp_lastchange_user;
  note          : abap.char(255);
  "%admin"      : include sych_bdl_draft_admin_inc;

}
```