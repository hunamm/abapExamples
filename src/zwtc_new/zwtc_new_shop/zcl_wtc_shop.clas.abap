class ZCL_WTC_SHOP definition
  public
  final
  create public .

public section.

  interfaces ZIF_WTC_SHOP .

  methods CONSTRUCTOR .
PROTECTED SECTION.
  PRIVATE SECTION.

    DATA:
      m_cart    TYPE REF TO ZCL_WTC_SHOP_CART,
      m_catalog TYPE REF TO ZCL_WTC_SHOP_CATALOG.
    METHODS build_new_empty_cart.

ENDCLASS.



CLASS ZCL_WTC_SHOP IMPLEMENTATION.


  METHOD build_new_empty_cart.
    m_cart = NEW ZCL_WTC_SHOP_CART( ).

    "TODO: instantiate the rebate engine and set reference to it here
  ENDMETHOD.


  METHOD constructor.
    m_catalog = NEW ZCL_WTC_SHOP_CATALOG( ).
    build_new_empty_cart( ).
  ENDMETHOD.


  METHOD zif_wtc_shop~add_item_to_cart.
    m_cart->add_item( m_catalog->get_item( i_id ) ).
  ENDMETHOD.


  METHOD zif_wtc_shop~buy_cart.
    DATA(payment_processor) = NEW ZCL_WTC_SHOP_PAYMENTPROCESSOR( ).
    rv_success = payment_processor->pay(
        i_email_sender = NEW ZCL_WTC_SHOP_EMAIL_SENDER( )
        i_value        = zif_wtc_shop~get_final_price( )
    ).
    IF rv_success = abap_true.
      build_new_empty_cart( ).
    ENDIF.
  ENDMETHOD.


  METHOD zif_wtc_shop~get_cart.
    r_cart = m_cart->get_cart( ).
  ENDMETHOD.


  METHOD zif_wtc_shop~get_catalog.
    r_catalog = m_catalog->get_catalog( ).
  ENDMETHOD.


  METHOD zif_wtc_shop~get_final_price.
    "TODO: should also subtract the rebate amount
    r_result = zif_wtc_shop~get_total_price( ).
  ENDMETHOD.


  METHOD zif_wtc_shop~get_global_rebate.
    "TODO: return the global rebate
  ENDMETHOD.


  METHOD zif_wtc_shop~get_global_rebate_reason.
    "TODO: return the global rebate reason
  ENDMETHOD.


  METHOD zif_wtc_shop~get_names_of_active_rules.

  ENDMETHOD.


  METHOD zif_wtc_shop~get_total_price.
    r_total_price = m_cart->get_standard_total( ).
  ENDMETHOD.


  METHOD zif_wtc_shop~remove_item_from_cart.
    m_cart->remove_item( i_cart_item ).
  ENDMETHOD.
ENDCLASS.
