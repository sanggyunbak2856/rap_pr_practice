```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '구매요청헤더 root view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zsk_r_pr_hdr 
as select from zpr_hdr_sk
composition [0..*] of zsk_r_pr_itm as _Item
association [1..1] to ZSK_R_STATUS as _Status
                   on $projection.Status = _Status.Status
{
    key pr_id as PrId,
    status as Status,
    currency as Currency,
    @Semantics.amount.currencyCode: 'Currency'
    total_price as TotalPrice,
    buyer_id as BuyerId,
    address as Address,
    @Semantics.systemDate.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    purchase_at as PurchaseAt,
    receive_at as ReceiveAt,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    note as Note,
    _Item,
    _Status
}

```