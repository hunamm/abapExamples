INTERFACE zif_wtc_shop
PUBLIC .
  METHODS:
    buy_cart
      IMPORTING
        i_paymentprocessor TYPE REF TO zcl_wtc_shop_paymentprocessor OPTIONAL
      RETURNING
        VALUE(rv_success)  TYPE abap_bool,
    add_item_to_cart
      IMPORTING
        i_id TYPE int4,
    remove_item_from_cart
      IMPORTING
        i_cart_item TYPE zase_shop_cart_item,
    get_cart
      RETURNING
        VALUE(r_cart) TYPE zase_shop_cart,
    get_catalog
      RETURNING
        VALUE(r_catalog) TYPE zase_shop_item_table,
    get_global_rebate
      RETURNING
        VALUE(r_global_rebate) TYPE zase_shop_item_rebate,
    get_global_rebate_reason
      RETURNING
        VALUE(r_global_rebate_reason) TYPE zase_shop_item_rebate_reason,
    get_total_price
      RETURNING
        VALUE(r_total_price) TYPE zase_shop_item_price,
    get_final_price
      RETURNING
        VALUE(r_result) TYPE zase_shop_final_price,
    get_names_of_active_rules
      RETURNING
        VALUE(r_active_rule_names) TYPE zase_shop_rules_table.
ENDINTERFACE.
