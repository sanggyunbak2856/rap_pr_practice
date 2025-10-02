```abap
@Metadata.layer: #CUSTOMER
@UI:{
  headerInfo:{
    typeName: 'Sales',
    typeNamePlural: 'Sales',
    title: { type: #STANDARD, value: 'EmployeeId' }
  },
  presentationVariant: [{ sortOrder: [{ by: 'EmployeeId', direction: #ASC }] }]
}
annotate entity zsk_c_employee_main
    with 
{
    @UI.facet: [{
      id: 'Header',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: '사원정보',
      position: 10
    }, {
      id: 'Item',
      purpose: #STANDARD,
      type: #CHART_REFERENCE,
      label: '판매실적 ',
      position: 20,
      targetQualifier: 'ByMaterialDual',
      targetElement: '_Sales'
    }]
    
    @UI.hidden: true
    EmployeeId;
    @UI: {
      lineItem:        [{ position: 10, label: '사원번호' }],
      identification:  [{ position: 10, label: '사원번호' }]
    }
    Seller;
    @UI: {
      lineItem:        [{ position: 20, label: '사원명' }],
      identification:  [{ position: 20, label: '사원명' }]
    }
    Name;
    
}
```