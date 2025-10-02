```abap
@Metadata.layer: #CUSTOMER
@UI:{
  headerInfo:{
    typeName: 'Purchase Order',
    typeNamePlural: 'Purchase Orders',
    title: { type: #STANDARD, value: 'PrId' }
  },
  presentationVariant: [{ sortOrder: [{ by: 'PrId', direction: #ASC }] }]
}
annotate view zsk_c_pr_hdr
    with 
{
    @UI.facet: [{
      id: 'Header',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'Header Detail',
      position: 10
    }, {
      id: 'Item',
      purpose: #STANDARD,
      type: #LINEITEM_REFERENCE,
      label: 'Item info ',
      position: 20,
      targetElement: '_Item'
    }]
    
    @UI: {
      lineItem:        [{ position: 10, label: '구매요청번호' }],
      identification:  [{ position: 20, label: '구매요청번호' }],
      selectionField:  [{ position: 10 }]
    }
    PrId;
    @UI: {
      lineItem:        [{ position: 20, label: '구매요청상태' }],
      identification:  [{ position: 30, label: '구매요청상태' }]
    }
    @UI.textArrangement: #TEXT_ONLY
    Status;
    @UI.hidden: true
    StatusText;
    @UI: {
      lineItem:        [{ position: 30, label: '통화' }],
      identification:  [{ position: 40, label: '통화' }]
    }
    Currency;
    @UI.hidden : true
    TotalPrice;
    @UI: {
      lineItem:        [{ position: 50, label: '구매자' }],
      identification:  [{ position: 60, label: '구매자' }]
    }
    BuyerId;
    @UI: {
      lineItem:        [{ position: 60, label: '주소' }],
      identification:  [{ position: 70, label: '주소' }]
    }
    Address;
    @UI.hidden: true
    CreatedAt;
    @UI.hidden: true
    CreatedBy;
    @UI: {
      lineItem:        [{ position: 70, label: '구매일' }],
      identification:  [{ position: 80, label: '구매일' }]
    }
    PurchaseAt;
    @UI: {
      lineItem:        [{ position: 80, label: '수령일' }],
      identification:  [{ position: 90, label: '수령일' }]
    }
    ReceiveAt;
    @UI.hidden: true
    LastChangedAt;
    @UI.hidden: true
    LastChangedBy;
    @UI.hidden: true
    Note;
    
}
```