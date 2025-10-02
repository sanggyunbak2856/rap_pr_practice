```abap
@EndUserText.label: '구매요청헤더 access control'
@MappingRole: true
define role ZSK_C_PR_HDR {
    grant
        select
            on
                ZSK_C_PR_HDR
                    where
                        inheriting conditions from entity zsk_r_pr_hdr;
                        
}
```