CLASS ltc_compute_rebate DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA m_cut TYPE REF TO zcl_wtc_rebate_engine.

    METHODS setup.
    METHODS no_rebate_for_empty_cart FOR TESTING.
    METHODS rebate_for_one_item_in_cart FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_compute_rebate IMPLEMENTATION.

  METHOD setup.
    "Given
    DATA(rules) = VALUE zcl_wtc_rebate_engine=>tt_rules(
      ( NEW zcl_wtc_rule_item_id( i_item_id = 1  i_req_quantity = 2  i_rebate = 5 ) ) ).

    m_cut = NEW zcl_wtc_rebate_engine( rules ).
  ENDMETHOD.

  METHOD no_rebate_for_empty_cart.
    "Given
    DATA(cart_items) = VALUE zase_shop_cart( ).

    "When
    m_cut->compute_rebate( CHANGING c_cart_items = cart_items ).

    "Then
    cl_abap_unit_assert=>assert_initial( m_cut->get_total_rebate_amount( ) ).
  ENDMETHOD.

  METHOD rebate_for_one_item_in_cart.
    "Given
    DATA(cart_items) = VALUE zase_shop_cart( ( id = 11 quantity = 1 )
                                            ( id = 1 quantity = 2 )
                                            ( id = 2 quantity = 3 ) ).
    DATA(cart_items_exp) = cart_items.
    cart_items_exp[ 2 ]-rebate_amount = 5.

    "When
    m_cut->compute_rebate( CHANGING c_cart_items = cart_items ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cart_items
                                        exp = cart_items_exp ).
  ENDMETHOD.

ENDCLASS.
