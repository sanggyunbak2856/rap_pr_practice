```abap
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sales child'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsk_r_sales_childf as select from zsales_sk
association [1..1] to zsk_R_material as _Material
                   on $projection.MaterialId = _Material.MaterialId
association [1..1] to zsk_c_employee_main as _Employee
                   on $projection.ProcessedBy = _Employee.Seller
{
    key sales_id as SalesId,
    pr_id as PrId,
    item_no as ItemNo,
    material_id as MaterialId,
    unit as Unit,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    quantity as Quantity,
    currency as Currency,
    @Semantics.amount.currencyCode: 'Currency'
    price as Price,
    buyer_id as BuyerId,
    processed_by as ProcessedBy,
    receive_month as ReceiveMonth,
    _Material,
    _Employee
}
```