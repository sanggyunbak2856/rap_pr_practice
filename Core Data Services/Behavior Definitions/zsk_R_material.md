```abap
managed implementation in class zbp_sk_r_material unique;
strict ( 2 );

define behavior for zsk_R_material //alias <alias_name>
persistent table zmaterial_sk
lock master
authorization master ( instance )
//etag master <field_name>
{
  create;
  update;
  delete;
}
```