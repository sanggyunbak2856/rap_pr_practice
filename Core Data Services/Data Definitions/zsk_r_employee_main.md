```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '판매자 루트뷰'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zsk_r_employee_main as select from zemployee_sk
association [0..*] to zsk_r_sales_main as _Sales
                   on $projection.Seller = _Sales.ProcessedBy
{
    key employee_id as EmployeeId,
    seller as Seller,
    name as Name,
    _Sales
}

```