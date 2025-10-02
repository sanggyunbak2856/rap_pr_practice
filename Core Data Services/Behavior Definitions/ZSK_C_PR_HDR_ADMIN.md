```abap
projection;
strict ( 2 );

define behavior for ZSK_C_PR_HDR_ADMIN //alias <alias_name>
{
  use action setProcessStatus;
  use action setShippingStatus;
  use association _Item;
}

define behavior for ZSK_C_PR_ITM_ADMIN //alias <alias_name>
{

  use association _Header;
}
```