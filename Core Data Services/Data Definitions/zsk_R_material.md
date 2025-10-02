```abap
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '자재 뷰'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsk_R_material as select from zmaterial_sk
{
    key material_id as MaterialId,
    material_name as MaterialName,
    unit as Unit,
    currency as Currency,
    @Semantics.amount.currencyCode: 'Currency'
    price as Price,
    last_changed_at as LastChangedAt,
    last_changed_by as LastChangedBy
}

```