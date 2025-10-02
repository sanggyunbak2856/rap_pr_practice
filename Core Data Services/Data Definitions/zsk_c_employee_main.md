```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '판매자 프로젝션'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zsk_c_employee_main as projection on zsk_r_employee_main
{
    key EmployeeId,
    Seller,
    Name,
    _Sales
}
```