*&---------------------------------------------------------------------*
*& Include          LASE_SHOP_APPD01
*&---------------------------------------------------------------------*
* ... Class Definitions ...............................................*

* --- GUI of ASE Shop .................................................*
CLASS lcl_ase_shop_gui DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor
     ,get_global_rebate RETURNING VALUE(r_global_rebate) TYPE zase_shop_item_rebate
     ,get_global_rebate_reason RETURNING VALUE(r_global_rebate_reason) TYPE zase_shop_item_rebate_reason
     ,get_total_price RETURNING VALUE(r_total_price) TYPE zase_shop_item_price
     ,
    get_final_price
      RETURNING
          VALUE(r_result) TYPE zase_shop_final_price,
      buy_cart.

  PRIVATE SECTION.

    CONSTANTS:

* ... Custom Container Controls for ALV Grids Shop and Cart ... *
      c_ccc4_alv_shop         TYPE fieldname VALUE 'CCCONTAINER1',
      c_ccc4_alv_cart         TYPE fieldname VALUE 'CCCONTAINER2',
      c_ccc4_alv_active_rules TYPE fieldname VALUE 'CCCONTAINER3',
* ... Structure Names for ALV Grid Shop and Cart ... *
      c_struc_name_alv_shop   TYPE tabname VALUE 'ZASE_SHOP_ITEM',
      c_struc_name_alv_cart   TYPE tabname VALUE 'ZASE_SHOP_CART_ITEM',
      c_struc_name_alv_rules  TYPE tabname VALUE 'ZASE_SHOP_RULE_TABLE_ITEM'.

    DATA:
      m_alv_shop   TYPE REF TO cl_gui_alv_grid,
      m_shop_items TYPE zase_shop_item_table,
      m_alv_cart   TYPE REF TO cl_gui_alv_grid,
      m_cart_items TYPE zase_shop_cart.

    METHODS:
      create_alv_shop
     ,create_alv_cart
     ,create_alv_grid
        IMPORTING
          i_container_name TYPE fieldname
        RETURNING VALUE(r_alv_grid) TYPE REF TO cl_gui_alv_grid
     ,add_item_to_cart
        FOR EVENT double_click
        OF cl_gui_alv_grid
        IMPORTING
          es_row_no e_column
     ,remove_item_from_cart
        FOR EVENT double_click
        OF cl_gui_alv_grid
        IMPORTING
          es_row_no e_column
     ,refresh_cart_display
     ,
      create_alv_active_rules.

ENDCLASS.

* --- ALV Fieldcatalog ................................................*
CLASS lcl_alv_fieldcatalog DEFINITION.

  PUBLIC SECTION.

    DATA:
      mt_fieldcatalog TYPE lvc_t_fcat
     .

    METHODS:
      constructor
        IMPORTING
          i_structure_name TYPE tabname
     ,set_total_for_column
        IMPORTING
          i_column_name TYPE lvc_fname
     .

  PRIVATE SECTION.

    METHODS:
      customize
        IMPORTING
          i_column_name TYPE lvc_fname
          i_field_name  TYPE lvc_fname
          i_field_value TYPE any
        .
ENDCLASS.

* --- ALV Layout ......................................................*
CLASS lcl_alv_layout DEFINITION.

  PUBLIC SECTION.

    DATA:
      m_layout TYPE lvc_s_layo READ-ONLY
     .

    METHODS:
      disable_toolbar
      .

  PRIVATE SECTION.

    METHODS:
      customize
        IMPORTING
          i_field_name  TYPE lvc_fname
          i_field_value TYPE any
        .
ENDCLASS.
