```abap
CLASS lhc_zsk_r_pr_itm DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS updatePriceOnCreate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zsk_r_pr_itm~updatePriceOnCreate.

ENDCLASS.

CLASS lhc_zsk_r_pr_itm IMPLEMENTATION.

  METHOD updatePriceOnCreate.


    DATA : lv_total_price TYPE zsk_r_pr_hdr-TotalPrice VALUE 0,
           lt_material TYPE TABLE OF zsk_r_material,
           lt_itm_update TYPE TABLE FOR UPDATE zsk_r_pr_itm.

    " 아이템 값이 생성될 때 헤더의 총 가격 업데이트 하는 determination
    READ ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
      ENTITY zsk_r_pr_itm
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(itm_results).

    SELECT MaterialId, Price
      INTO CORRESPONDING FIELDS OF TABLE @lt_material
      FROM zsk_r_material.

    " 더해칠 총 금액 계산
    LOOP AT itm_results ASSIGNING FIELD-SYMBOL(<itm_result>).

        READ TABLE lt_material INTO DATA(ls_material) WITH KEY MaterialId = <itm_result>-MaterialId.

        lv_total_price += ls_material-Price.

        APPEND VALUE #(
            %tky = <itm_result>-%tky
            Price = <itm_result>-Quantity * ls_material-Price
        ) TO lt_itm_update.

    ENDLOOP.

    " 아이템 생성시 아이템의 총 가격 업데이트
    MODIFY ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
      ENTITY zsk_r_pr_itm
      UPDATE
      FIELDS ( Price )
      WITH lt_itm_update.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zsk_r_pr_hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zsk_r_pr_hdr RESULT result.
    METHODS setdefaultvalue FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zsk_r_pr_hdr~setdefaultvalue.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zsk_r_pr_hdr RESULT result.
    METHODS setprocessstatus FOR MODIFY
      IMPORTING keys FOR ACTION zsk_r_pr_hdr~setprocessstatus.
    METHODS setshippingstatus FOR MODIFY
      IMPORTING keys FOR ACTION zsk_r_pr_hdr~setshippingstatus.
    METHODS checkaddress FOR VALIDATE ON SAVE
      IMPORTING keys FOR zsk_r_pr_hdr~checkaddress.

ENDCLASS.

CLASS lhc_zsk_r_pr_hdr IMPLEMENTATION.

  METHOD get_instance_authorizations.

  ENDMETHOD.

  METHOD setDefaultValue.

    DATA : lt_update TYPE TABLE FOR UPDATE zsk_r_pr_hdr.

    " 값을 읽어 기본값을 세팅하기
    READ ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
      ENTITY zsk_r_pr_hdr
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(hdr_results).

    LOOP AT hdr_results ASSIGNING FIELD-SYMBOL(<hdr_result>).

        APPEND VALUE #(
            %tky = <hdr_result>-%tky
            BuyerId = sy-uname
            Status = 'A'
            Currency = 'KRW'
            TotalPrice = 0
            PurchaseAt = sy-datum
        ) TO lt_update.

    ENDLOOP.

    MODIFY ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
      ENTITY zsk_r_pr_hdr
      UPDATE
      FIELDS ( BuyerId Status Currency TotalPrice PurchaseAt )
      WITH lt_update.

  ENDMETHOD.

  METHOD get_instance_features.

    " 값을 읽어서 구매요청상태를 보고 update, delete 설정

    READ ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
      ENTITY zsk_r_pr_hdr
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(hdr_results).

    LOOP AT hdr_results ASSIGNING FIELD-SYMBOL(<hdr_result>).

      APPEND VALUE #(
        %tky = <hdr_result>-%tky
      )
      TO result ASSIGNING FIELD-SYMBOL(<result>).

      case <hdr_result>-Status.
        when 'A'.
        <result>-%action-setProcessStatus = if_abap_behv=>fc-o-enabled.
        <result>-%action-setShippingStatus = if_abap_behv=>fc-o-disabled.
        <result>-%update = if_abap_behv=>fc-o-enabled.
        <result>-%delete = if_abap_behv=>fc-o-enabled.

        when 'B'.
        <result>-%action-setProcessStatus = if_abap_behv=>fc-o-disabled.
        <result>-%action-setShippingStatus = if_abap_behv=>fc-o-enabled.
        <result>-%update = if_abap_behv=>fc-o-disabled.
        <result>-%delete = if_abap_behv=>fc-o-disabled.

        when 'C'.
        <result>-%action-setProcessStatus = if_abap_behv=>fc-o-disabled.
        <result>-%action-setShippingStatus = if_abap_behv=>fc-o-disabled.
        <result>-%update = if_abap_behv=>fc-o-disabled.
        <result>-%delete = if_abap_behv=>fc-o-disabled.

      endcase.

    ENDLOOP.

  ENDMETHOD.

  METHOD setProcessStatus.

    " 주문 접수 상태를 B로 변경한다 ( 권한 확인은 다이나믹 컨트롤에서 )
    LOOP AT keys INTO DATA(key).

        MODIFY ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
          ENTITY zsk_r_pr_hdr
          UPDATE
          FIELDS ( Status )
          WITH VALUE #( (
            PrId = key-PrId
            Status = 'B'
          ) ).

    ENDLOOP.

  ENDMETHOD.

  METHOD setShippingStatus.

    " 구매요청 아이템의 수량을 읽어와서
    " 재고 수량과 비교한 뒤
    " 재고가 있으면 출고한다 ( 하나라도 재고 부족이면 출고 안한다 )
    " 출고시 판매실적 테이블에 값을 넣어 반영한다

    DATA : lt_stock TYPE TABLE OF zstock_sk,
           lt_stock_update TYPE TABLE OF zstock_sk,
           lt_material TYPE TABLE OF zmaterial_sk,
           ls_material TYPE zmaterial_sk.

    " 판매실적 테이블
    DATA : lt_sales TYPE TABLE OF zsales_sk,
           ls_sales TYPE zsales_sk.

    " 아이템 읽기
    READ ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
      ENTITY zsk_r_pr_hdr BY \_Item
      FIELDS ( PrId MaterialId Quantity ItemNo Price )
      WITH CORRESPONDING #( keys )
      RESULT DATA(itm_results).

    " 헤더 읽기
    READ ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
      ENTITY zsk_r_pr_hdr
      FIELDS ( PrId BuyerId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(hdr_results).

    " 재고 수량 읽기
    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE @lt_stock
      FROM zstock_sk.

    " 자재 마스터 읽기
    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE @lt_material
      FROM zmaterial_sk.

    LOOP AT itm_results ASSIGNING FIELD-SYMBOL(<itm_result>).

        CLEAR : ls_material.
        READ TABLE lt_stock INTO DATA(ls_stock) WITH KEY material_id = <itm_result>-MaterialId.
        READ TABLE lt_material INTO ls_material WITH KEY material_id = <itm_result>-MaterialId.

        if ls_stock-quantity < <itm_result>-quantity.

          " 재고 수량 부족시 부족하다고 메시지 출력 후 메소드 종료
          APPEND VALUE #(
            PrId = <itm_result>-PrId
          ) TO failed-zsk_r_pr_hdr.

          APPEND VALUE #(
            PrId = <itm_result>-PrId
            %msg = new zcm_prprac_b11(
                textid = zcm_prprac_b11=>out_of_stock
                severity = if_abap_behv_message=>severity-error
            )
          ) TO reported-zsk_r_pr_hdr.

          return.

        else.
             " 재고 수량 넉넉하면 재고 업데이트 값 생성
            DATA(lv_new_quantity) = ls_stock-quantity - <itm_result>-quantity.
            ls_stock-quantity = lv_new_quantity.
            MODIFY TABLE lt_stock FROM ls_stock TRANSPORTING quantity.
            APPEND ls_stock TO lt_stock_update.

            " 판매 실적 테이블에 넣을 값 만들기
            CLEAR ls_sales.
            ls_sales = VALUE #(
                sales_id = cl_system_uuid=>create_uuid_x16_static(  )
                pr_id = <itm_result>-PrId
                item_no = <itm_result>-ItemNo
                material_id = <itm_result>-MaterialId
                unit = ls_material-unit
                quantity = <itm_result>-Quantity
                currency = ls_material-currency
                price = <itm_result>-quantity * ls_material-price
                buyer_id = hdr_results[ 1 ]-BuyerId
                processed_by = sy-uname
                receive_month = sy-datum
            ).

            APPEND ls_sales TO lt_sales.

        endif.

    ENDLOOP.

    " 재고 db에 반영
    MODIFY zstock_sk FROM TABLE lt_stock_update.

    " 상태값, 출고시간 변경
    LOOP AT keys INTO DATA(key).

        MODIFY ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
          ENTITY zsk_r_pr_hdr
          UPDATE
          FIELDS ( Status ReceiveAt )
          WITH VALUE #( (
            PrId = key-PrId
            Status = 'C'
            ReceiveAt = sy-datum
          ) ).

    ENDLOOP.

    " 출고시 판매실적 테이블에 값 넣기
    MODIFY zsales_sk FROM TABLE lt_sales.

  ENDMETHOD.

  METHOD checkAddress.

    READ ENTITIES OF zsk_r_pr_hdr IN LOCAL MODE
      ENTITY zsk_r_pr_hdr
      FIELDS ( Address )
      WITH CORRESPONDING #( keys )
      RESULT DATA(hdr_results).

    LOOP AT hdr_results ASSIGNING FIELD-SYMBOL(<hdr_result>).

        if <hdr_result>-Address IS INITIAL.

            APPEND VALUE #(
                %tky = <hdr_result>-%tky
            ) TO failed-zsk_r_pr_hdr.

            APPEND VALUE #(
                %tky = <hdr_result>-%tky
                %msg = new ZCM_PRPRAC_B11(
                    textid = ZCM_PRPRAC_B11=>no_address
                    severity = IF_ABAP_BEHV_MESSAGE=>severity-error
                )
            ) TO reported-zsk_r_pr_hdr.

        endif.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
```