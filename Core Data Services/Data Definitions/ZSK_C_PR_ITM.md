```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '구매요청아이템 프로젝션뷰'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZSK_C_PR_ITM 
as projection on zsk_r_pr_itm
{
    key PrId,
    key ItemNo,
    @Search.defaultSearchElement: true
    @Consumption.valueHelpDefinition: [{ 
        entity: {
            name: 'zsk_r_material',
            element: 'MaterialId'
        },
        additionalBinding: [
            {
                localElement: 'Unit',
                element: 'Unit',
                usage: #RESULT
            },
            {
                localElement: 'Currency',
                element: 'Currency',
                usage: #RESULT
            },
            {
                localElement: 'MaterialName',
                element: 'MaterialName',
                usage: #RESULT
            }
        ]
     }]
    MaterialId,
    _Material.MaterialName as MaterialName,
    Unit,
    @Semantics.quantity.unitOfMeasure: 'Unit'
    Quantity,
    Currency,
    @Semantics.amount.currencyCode: 'Currency'
    Price,
    LastChangedAt,
    LastChangedBy,
    /* Associations */
    _Header : redirected to parent zsk_c_pr_hdr,
    _Material
}

```