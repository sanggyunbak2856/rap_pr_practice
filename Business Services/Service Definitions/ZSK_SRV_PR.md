```abap
@EndUserText.label: '구매요청 서비스'
define service ZSK_SRV_PR {
  expose zsk_c_pr_hdr as Header;
  expose ZSK_C_PR_ITM as Item;
}
```