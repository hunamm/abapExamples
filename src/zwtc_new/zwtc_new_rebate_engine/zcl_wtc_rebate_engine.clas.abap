class ZCL_WTC_REBATE_ENGINE definition
  public
  final
  create public .

public section.

  types:
    tt_rules TYPE STANDARD TABLE OF REF TO ZCL_WTC_RULE_ITEM_BASE WITH DEFAULT KEY .

  methods CONSTRUCTOR
    importing
      !I_RULES type TT_RULES optional .
  methods COMPUTE_REBATE
    changing
      !C_CART_ITEMS type ZASE_SHOP_CART .
  methods GET_TOTAL_REBATE_AMOUNT
    returning
      value(R_AMOUNT) type ZASE_SHOP_REBATE_AMOUNT .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA m_rules TYPE tt_rules.
ENDCLASS.



CLASS ZCL_WTC_REBATE_ENGINE IMPLEMENTATION.


  METHOD compute_rebate.
    LOOP AT c_cart_items REFERENCE INTO DATA(cart_item).
      CLEAR cart_item->rebate_amount.
      LOOP AT m_rules INTO DATA(rule).
        DATA(rebate_amount) = rule->apply( i_cart_item = cart_item->* ).
        IF rebate_amount > 0.
          cart_item->rebate_amount = rebate_amount.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.


  METHOD constructor.
    IF i_rules IS NOT INITIAL.
      m_rules = i_rules.
    ELSE.
      "TODO: should be moved to a rules provider class
      m_rules = VALUE #( ( NEW ZCL_WTC_RULE_ITEM_ID( i_item_id = 1  i_req_quantity = 2  i_rebate = 5 ) ) ).
    ENDIF.
  ENDMETHOD.


  METHOD get_total_rebate_amount.

  ENDMETHOD.
ENDCLASS.
