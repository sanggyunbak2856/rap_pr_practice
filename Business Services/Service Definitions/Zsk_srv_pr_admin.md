```abap
@EndUserText.label: '서비스'
define service Zsk_srv_pr_admin {
  expose ZSK_C_PR_HDR_ADMIN as Header;
  expose ZSK_C_PR_ITM_ADMIN as Item;
}
```