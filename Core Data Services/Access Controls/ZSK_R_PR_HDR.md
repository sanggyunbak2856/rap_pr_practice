```abap
@EndUserText.label: '구매요청헤더 access control'
@MappingRole: true
define role ZSK_R_PR_HDR {
    grant
        select
            on
                ZSK_R_PR_HDR
                    where
                        BuyerId = 'ADV-B-11';
                        
}
```