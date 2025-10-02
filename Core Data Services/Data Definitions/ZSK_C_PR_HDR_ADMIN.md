```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '구매요청헤더 root view admin'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZSK_C_PR_HDR_ADMIN 
provider contract transactional_query
as projection on zsk_r_pr_hdr
{
    key PrId,
    @Consumption.valueHelpDefinition: [{ 
        entity: {
            name: 'zsk_r_status',
            element: 'Status'
        }
     }]
    @ObjectModel.text.element: [ 'StatusText' ]
    Status,
    _Status.Description as StatusText,
    Currency,
    @Semantics.amount.currencyCode: 'Currency'
    TotalPrice,
    BuyerId,
    Address,
    CreatedAt,
    CreatedBy,
    ReceiveAt,
    LastChangedAt,
    LastChangedBy,
    Note,
    /* Associations */
    _Item: redirected to composition child ZSK_C_PR_ITM_ADMIN,
    _Status
}
```