```abap
@EndUserText.label : '구매요청상태'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zprstatus_sk {

  key client  : abap.clnt not null;
  key status  : abap.char(1) not null;
  description : abap.char(50);

}
```