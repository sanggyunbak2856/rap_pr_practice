```abap
@Metadata.layer: #CUSTOMER

@UI:{
  headerInfo:{
    typeName: '자재별 판매 수량',
    typeNamePlural: 'Purchase Orders',
    title: { type: #STANDARD, value: 'MaterialId' }
  },
  presentationVariant: [{ sortOrder: [{ by: 'MaterialId', direction: #ASC }] }]
}

@UI.chart: [{  
    qualifier        : 'ByMaterialDual',
    title            : '자재별 판매 수량 & 금액',
    description      : '자재별 수량과 금액',
    chartType        : #COMBINATION_DUAL,
    dimensions       : [ 'MaterialId' ],
    dimensionAttributes: [ { dimension: 'MaterialId', role: #SERIES } ],
    measures         : [ 'Quantity', 'Price' ],
    measureAttributes: [
      { measure: 'Quantity', role: #AXIS_1 },
      { measure: 'Price', role: #AXIS_2 }
    ]
}]

annotate entity zsk_c_sales_main
    with 
{
      @UI.facet: [{
        id: 'SalesChart',
        purpose: #STANDARD,
        type: #CHART_REFERENCE,          // ★ 차트만 렌더
        label: '판매실적',
        position: 10,
        targetQualifier: 'ByMaterialDual'// ★ 위 chart의 qualifier와 일치
        // targetElement 생략 → 자기 자신 엔티티의 차트를 참조
      }]
    @UI.hidden: true
    SalesId;
    @UI.hidden: true
    PrId;
    @UI.hidden: true
    ItemNo;
    @UI.lineItem: [{ position: 10, label: '품목 번호' }]
    MaterialId;
    @UI.lineItem: [{ position: 20, label: '품목 명' }]
    MaterialName;
    @UI.lineItem: [{ position: 30, label: '단위' }]
    Unit;
    @UI.lineItem: [{ position: 40, label: '판매 수량' }]
    Quantity;
    @UI.lineItem: [{ position: 50, label: '통화키' }]
    Currency;
    @UI.lineItem: [{ position: 60, label: '총 판매 가격' }]
    Price;
    @UI.hidden: true
    BuyerId;
    @UI.lineItem: [{ position: 80, label: '판매자' }]
    ProcessedBy;
    @UI.lineItem: [{ position: 90, label: '판매월' }]
    ReceiveMonth;
}
```