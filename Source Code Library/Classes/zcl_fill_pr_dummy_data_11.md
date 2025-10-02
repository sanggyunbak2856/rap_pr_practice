```abap
CLASS zcl_fill_pr_dummy_data_11 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fill_pr_dummy_data_11 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : prhd TYPE TABLE OF zpr_hdr_sk,
           prit TYPE TABLE OF zpr_itm_sk.

    DELETE FROM zpr_hdr_sk.
    DELETE FROM zpr_itm_sk.

    prhd = VALUE #(
        (
            pr_id = cl_system_uuid=>create_uuid_x16_static(  )
            status =  'A'
            currency = 'KRW'
            total_price = 25
            buyer_id = sy-uname
            address = 'seoul'
        )
        (
            pr_id = cl_system_uuid=>create_uuid_x16_static(  )
            status =  'B'
            currency = 'KRW'
            total_price = 10
            buyer_id = sy-uname
            address = 'seoul'
        )
        (
            pr_id = cl_system_uuid=>create_uuid_x16_static(  )
            status =  'B'
            currency = 'KRW'
            total_price = 10
            buyer_id = 'DUMMYDUMMY11'
            address = 'seoul'
        )
     ).

     prit = VALUE #(
        (
            pr_id = prhd[ 1 ]-pr_id
            item_no = '000001'
            material_id = 'MAT00001'
            unit = 'EA'
            quantity = 1
            price = 10
            currency = 'KRW'
        )
        (
            pr_id = prhd[ 1 ]-pr_id
            item_no = '000002'
            material_id = 'MAT00003'
            unit = 'EA'
            quantity = 1
            price = 15
            currency = 'KRW'
        )
        (
            pr_id = prhd[ 2 ]-pr_id
            item_no = '000001'
            material_id = 'MAT00003'
            unit = 'EA'
            quantity = 1
            price = 15
            currency = 'KRW'
        )
        (
            pr_id = prhd[ 3 ]-pr_id
            item_no = '000001'
            material_id = 'MAT00003'
            unit = 'EA'
            quantity = 1
            price = 15
            currency = 'KRW'
        )
     ).

     INSERT zpr_hdr_sk FROM TABLE @prhd.
     INSERT zpr_itm_sk FROM TABLE @prit.

     DELETE FROM zsales_sk.

     commit work.

  ENDMETHOD.
ENDCLASS.
```