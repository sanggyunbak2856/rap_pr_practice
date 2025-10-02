```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '판매실적 projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zsk_c_sales_main 
as projection on zsk_r_sales_main
{
    key SalesId,
    PrId,
    ItemNo,
    MaterialId,
    _Material.MaterialName as MaterialName,
    Unit,
    @Aggregation.default: #SUM
    @Semantics.quantity.unitOfMeasure: 'Unit'
    Quantity,
    Currency,
    @Aggregation.default: #SUM
    @Semantics.amount.currencyCode: 'Currency'
    Price,
    BuyerId,
    ProcessedBy,
    ReceiveMonth,
    /* Associations */
    _Material,
    _Employee
}
```