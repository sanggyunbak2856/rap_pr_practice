```abap
managed implementation in class zbp_sk_r_pr_hdr unique;
strict ( 2 );
with draft;

define behavior for zsk_r_pr_hdr //alias <alias_name>
persistent table zpr_hdr_sk
draft table zpr_hdr_sk_draft
lock master total etag LastChangedAt
authorization master ( instance )
etag master LastChangedAt
{
  create;
  update(features : instance);
  delete(features : instance);

  field ( readonly, numbering : managed ) PrId;
  field ( readonly : update ) Currency, BuyerId, Status, PurchaseAt, ReceiveAt;
//  field ( mandatory : create ) Address;

  association _Item { create; with draft; }

  // 관리자용
  action( features : instance ) setProcessStatus;
  action( features : instance ) setShippingStatus;

  // 생성시 값 초기화
  determination setDefaultValue on modify { create; }

  // 생성시 주소 갑 확인
  validation checkAddress on save { create; update; field Address; }

  // draft
  draft action Edit;
  draft action Activate;
  draft action Discard;
  draft action Resume;
  draft determine action Prepare;

  mapping for zpr_hdr_sk corresponding {
    Address = address;
    BuyerId = buyer_id;
    CreatedAt = created_at;
    CreatedBy = created_by;
    Currency = currency;
    LastChangedAt = last_changed_at;
    LastChangedBy = last_changed_by;
    Note = note;
    PrId = pr_id;
    PurchaseAt = purchase_at;
    ReceiveAt = receive_at;
    Status = status;
    TotalPrice = total_price;
  }

}

define behavior for zsk_r_pr_itm //alias <alias_name>
persistent table zpr_itm_sk
draft table zpr_itm_sk_draft
lock dependent by _Header
authorization dependent by _Header
etag master LastChangedAt
{
  update;
  delete;
  field ( readonly ) PrId;
  field ( readonly , numbering : managed ) ItemNo;
  association _Header { with draft; }

  determination updatePriceOnCreate on modify { create; field Quantity; }

  side effects {
    field Quantity affects field Price;
  }

  mapping for zpr_itm_sk corresponding {
    Currency = currency;
    ItemNo = item_no;
    LastChangedAt = last_changed_at;
    LastChangedBy = last_changed_by;
    MaterialId = material_id;
    PrId = pr_id;
    Price = price;
    Quantity = quantity;
    Unit = unit;
  }
}
```