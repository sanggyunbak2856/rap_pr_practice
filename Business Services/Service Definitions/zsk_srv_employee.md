```abap
@EndUserText.label: '판매실적'
define service Zsk_srv_employee {
  expose zsk_c_employee_main as Employee;
  expose zsk_c_sales_main    as Sales;
}
```