```abap
@Metadata.layer: #CUSTOMER
@UI:{
    headerInfo:{ typeName: 'Purchase Order Item',
    typeNamePlural: 'Purchase Order Items',
    title: { type: #STANDARD, value: 'PrId' } },
    presentationVariant: [{ sortOrder: [{ by: 'ItemNo', direction: #ASC }] }]
}
annotate view ZSK_C_PR_ITM
    with 
{

    @UI.facet: 
  [{ 
      id: 'Item',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'Item Details',
      position: 10 
  }]
  
    @UI: { 
    lineItem: [{ 
        position: 10, 
        label: '구매요청번호' 
        }],
    identification: [{ 
        position: 10, 
        label: '구매요청번호' 
        }]
    }
    PrId;
    
    @UI: { 
    lineItem: [{ 
        position: 20, 
        label: '아이템 번호'
        }],
    identification: [{ 
        position: 20, 
        label: '아이템 번호'
        }]
     }
    ItemNo;
    
    @UI: { 
    lineItem: [{ 
        position: 30, 
        label: '품목 번호' 
        }],
    identification: [{ 
        position: 30, 
        label: '품목 번호' 
        }]
  }
    MaterialId;
    
    @UI: { 
    lineItem: [{ 
        position: 35, 
        label: '품목 이름' ,
        cssDefault.width: '10'
        }],
    identification: [{ 
        position: 35, 
        label: '품목 이름' 
        }]
  }
    MaterialName;
    
    @UI: { 
    lineItem: [{ 
        position: 40, 
        label: '단위' 
        }],
    identification: [{ 
        position: 40, 
        label: '단위' 
        }]
  }
    Unit;
    
    @UI: { 
    lineItem: [{ 
        position: 50, 
        label: '수량' 
        }],
    identification: [{ 
        position: 50, 
        label: '수량' 
        }]
  }
    Quantity;
    
    @UI: { 
    lineItem: [{ 
        position: 60, 
        label: '통화' 
        }],
    identification: [{ 
        position: 60, 
        label: '통화' 
        }]
  }
    Currency;
    
    @UI: { 
    lineItem: [{ 
        position: 70, 
        label: '가격' 
        }],
    identification: [{ 
        position: 70, 
        label: '가격' 
        }]
  }
    Price;
    
    @UI.hidden: true
    LastChangedAt;
    
    @UI.hidden: true
    LastChangedBy;
    
}
```