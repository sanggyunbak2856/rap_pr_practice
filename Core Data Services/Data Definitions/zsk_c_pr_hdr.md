```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '구매요청헤더 projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity zsk_c_pr_hdr 
provider contract transactional_query
as projection on zsk_r_pr_hdr
{
    key PrId,
    @Search.defaultSearchElement: true
    @Consumption.valueHelpDefinition: [{ 
        entity: {
            name: 'zsk_r_status',
            element: 'Status'
        }
     }]
    @ObjectModel.text.element: [ 'StatusText' ]
    @UI.textArrangement: #TEXT_ONLY
    Status,
    _Status.Description as StatusText,
    @Consumption.valueHelpDefinition: [{ 
        entity: {
            name: 'I_Currency',
            element: 'Currency'
        }
     }]
    Currency,
    @Semantics.amount.currencyCode: 'Currency'
    TotalPrice,
    BuyerId,
    Address,
    CreatedAt,
    CreatedBy,
    PurchaseAt,
    ReceiveAt,
    LastChangedAt,
    LastChangedBy,
    Note,
    /* Associations */
    _Item : redirected to composition child ZSK_C_PR_ITM,
    _Status
}

```