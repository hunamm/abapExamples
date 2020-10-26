CLASS ltc_rule_item_id DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA m_cut TYPE REF TO zcl_wtc_rule_item_id.

    METHODS setup.
    METHODS initial_item_no_rebate FOR TESTING RAISING cx_static_check.
    METHODS fitting_item_few_qty_no_rebate FOR TESTING RAISING cx_static_check.
    METHODS fitting_item_ok_qty_get_rebate FOR TESTING RAISING cx_static_check.
    METHODS fit_item_multi_qty_get_rebate FOR TESTING RAISING cx_static_check.

ENDCLASS.



CLASS ltc_rule_item_id IMPLEMENTATION.

  method setup.
    "Given
    m_cut = NEW #( i_item_id = 1
                   i_req_quantity = 2
                   i_rebate = 5 ).
  endmethod.

  METHOD initial_item_no_rebate.
    "When
    DATA(rebate_amount) = m_cut->apply( VALUE #( ) ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = rebate_amount
                                        exp = 0 ).
  ENDMETHOD.

  METHOD fitting_item_few_qty_no_rebate.
    "When
    DATA(rebate_amount) = m_cut->apply( VALUE #( id = 1 quantity = 1 ) ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = rebate_amount
                                        exp = 0 ).
  ENDMETHOD.

  METHOD fitting_item_ok_qty_get_rebate.
    "When
    DATA(rebate_amount) = m_cut->apply( VALUE #( id = 1 quantity = 2 ) ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = rebate_amount
                                        exp = 5 ).
  ENDMETHOD.

  METHOD fit_item_multi_qty_get_rebate.
    "When
    DATA(rebate_amount) = m_cut->apply( VALUE #( id = 1 quantity = 20 ) ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = rebate_amount
                                        exp = 5 ).
  ENDMETHOD.

ENDCLASS.
