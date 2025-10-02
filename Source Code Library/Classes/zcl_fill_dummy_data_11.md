```abap
CLASS zcl_fill_dummy_data_11 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fill_dummy_data_11 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : material TYPE TABLE OF zmaterial_sk,
           status   TYPE TABLE OF zprstatus_sk,
           stock    TYPE TABLE OF zstock_sk,
           employee TYPE TABLE OF zemployee_sk.

    DATA : qty TYPE zstock_sk-quantity VALUE 100.

    stock = VALUE #(
        (
            material_id = 'MAT00001'
            unit = 'EA'
            quantity = qty
        )
        (
            material_id = 'MAT00002'
            unit = 'EA'
            quantity = qty
        )
        (
            material_id = 'MAT00003'
            unit = 'EA'
            quantity = qty
        )
    ).

    material = VALUE #(
        (
            material_id = 'MAT00001'
            material_name = '펜'
            unit = 'EA'
            price = '10'
            currency = 'KRW'
         )
         (
            material_id = 'MAT00002'
            material_name = '노트'
            unit = 'EA'
            price = '20'
            currency = 'KRW'
         )
         (
            material_id = 'MAT00003'
            material_name = '테이프'
            unit = 'EA'
            price = '15'
            currency = 'KRW'
         )
     ).

     status = VALUE #(
        (
            status = 'A'
            description = '주문접수'
        )
        (
            status = 'B'
            description = '주문처리중'
        )
        (
            status = 'C'
            description = '출고완료'
        )
     ).

     employee = VALUE #(
        (
            employee_id = cl_system_uuid=>create_uuid_x16_static(  )
            seller = 'ADV-B-11'
            name = '박상균'
        )
        (
            employee_id = cl_system_uuid=>create_uuid_x16_static(  )
            seller = 'BDV-B-11'
            name = '김김김'
        )
     ).

     DELETE FROM zstock_sk.
     DELETE FROM zmaterial_sk.
     DELETE FROM zprstatus_sk.
     DELETE FROM zemployee_sk.

     INSERT zmaterial_sk FROM TABLE @material.
     INSERT zprstatus_sk FROM TABLE @status.
     INSERT zstock_sk FROM TABLE @stock.
     INSERT zemployee_sk FROM TABLE @employee.

     COMMIT WORK.
  ENDMETHOD.
ENDCLASS.
```