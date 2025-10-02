```abap
@EndUserText.label : '판매자 테이블'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zemployee_sk {

  key client      : abap.clnt not null;
  key employee_id : sysuuid_x16 not null;
  seller          : abap.char(12);
  name            : abap.char(20);

}
```