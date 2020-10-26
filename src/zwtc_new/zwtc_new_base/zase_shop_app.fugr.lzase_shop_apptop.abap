FUNCTION-POOL ZASE_SHOP_APP.                 "MESSAGE-ID ..

INCLUDE lzase_shop_appd01.                  " Local class definition

DATA:
  ok_code               TYPE sy-ucomm,
  pai_ok_code           TYPE sy-ucomm,
  user_notification(60) TYPE c,
  global_rebate         TYPE zase_shop_item_rebate,
  global_rebate_reason  TYPE zase_shop_item_rebate_reason,
  total_price           TYPE zase_shop_item_price,
  go_shop_gui           TYPE REF TO lcl_ase_shop_gui,
  final_price           TYPE zase_shop_final_price,
  g_shop                TYPE REF TO zif_wtc_shop.
