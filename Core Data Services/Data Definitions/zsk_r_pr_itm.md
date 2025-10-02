```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '구매요청아이템 view'
@Metadata.ignorePropagatedAnnotations: true
define view entity zsk_r_pr_itm as select from zpr_itm_sk
association to parent zsk_r_pr_hdr as _Header
            on $projection.PrId = _Header.PrId
association [1..1] to zsk_R_material as _Material
                   on $projection.MaterialId = _Material.MaterialId
{
    key pr_id as PrId,
    key item_no as ItemNo,
    material_id as MaterialId,
    unit as Unit,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    quantity as Quantity,
    currency as Currency,
    @Semantics.amount.currencyCode: 'Currency'
    price as Price,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    _Header,
    _Material
}

```