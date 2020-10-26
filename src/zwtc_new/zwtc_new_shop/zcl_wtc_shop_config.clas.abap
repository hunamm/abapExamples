class ZCL_WTC_SHOP_CONFIG definition
  public
  final
  create public .

  "---------------------------------------------------------
  "-- Offers key-value pair store for global configuration.
  "-- Data type for both is string.
public section.

  methods CONSTRUCTOR .
  methods READ_CONFIG_TUPLE
    importing
      !I_NAME type STRING
    returning
      value(R_VALUE) type STRING .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mt_ase_shop_configs TYPE TABLE OF zase_shop_config.
ENDCLASS.



CLASS ZCL_WTC_SHOP_CONFIG IMPLEMENTATION.


  METHOD constructor.
    SELECT * FROM zase_shop_config INTO TABLE @mt_ase_shop_configs.
  ENDMETHOD.


  METHOD read_config_tuple.
    TRY.
        r_value = mt_ase_shop_configs[ name = i_name ]-value.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE ZCX_WTC_SHOP_CONFIG_ERROR.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
