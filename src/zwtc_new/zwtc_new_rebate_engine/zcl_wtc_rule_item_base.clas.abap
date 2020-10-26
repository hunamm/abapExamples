class ZCL_WTC_RULE_ITEM_BASE definition
  public
  abstract
  create public .

public section.

  methods APPLY
  abstract
    importing
      !I_CART_ITEM type ZASE_SHOP_CART_ITEM
    returning
      value(R_REBATE) type ZASE_SHOP_ITEM_REBATE .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WTC_RULE_ITEM_BASE IMPLEMENTATION.
ENDCLASS.
