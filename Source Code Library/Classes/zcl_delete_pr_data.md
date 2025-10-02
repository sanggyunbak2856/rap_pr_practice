```abap
CLASS zcl_delete_pr_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_delete_pr_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " 구매요청아이템 전체 삭제
    DELETE FROM zpr_itm_sk.

    " 구매요청 헤더 전체 삭제
    DELETE FROM zpr_hdr_sk.

    " 판매실적 전체 삭제
    DELETE FROM zsales_sk.



  ENDMETHOD.
ENDCLASS.
```