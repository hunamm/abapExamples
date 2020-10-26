class ZCL_WTC_RULE_ITEM_ID definition
  public
  inheriting from ZCL_WTC_RULE_ITEM_BASE
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !I_ITEM_ID type ZASE_SHOP_ITEM_ID
      !I_REQ_QUANTITY type ZASE_SHOP_ITEM_QUANTITY
      !I_REBATE type ZASE_SHOP_ITEM_REBATE .

  methods APPLY
    redefinition .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA m_item_id      TYPE ZASE_shop_item_id.
    DATA m_req_quantity TYPE ZASE_shop_item_quantity.
    DATA m_rebate       TYPE ZASE_shop_item_rebate.
ENDCLASS.



CLASS ZCL_WTC_RULE_ITEM_ID IMPLEMENTATION.


  METHOD apply.
    IF i_cart_item-id = m_item_id AND
       i_cart_item-quantity >= m_req_quantity.
      r_rebate = m_rebate.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).
    m_item_id      = i_item_id.
    m_req_quantity = i_req_quantity.
    m_rebate       = i_rebate.
  ENDMETHOD.
ENDCLASS.
