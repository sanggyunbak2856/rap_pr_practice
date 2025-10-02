```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '구매요청아이템 view 어드민'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZSK_C_PR_ITM_ADMIN as projection on zsk_r_pr_itm
{
    key PrId,
    key ItemNo,
    MaterialId,
    Unit,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    Quantity,
    Currency,
    @Semantics.amount.currencyCode: 'Currency'
    Price,
    LastChangedAt,
    LastChangedBy,
    /* Associations */
    _Header : redirected to parent ZSK_C_PR_HDR_ADMIN,
    _Material
}
```