*&---------------------------------------------------------------------*
*& Include          LASE_SHOP_APPP01
*&---------------------------------------------------------------------*
* ... Class Implementations ...........................................*

* --- GUI of ASE Shop .................................................*
CLASS lcl_ase_shop_gui IMPLEMENTATION.

  METHOD constructor.
    create_alv_shop( ).
    create_alv_cart( ).
    create_alv_active_rules( ).
  ENDMETHOD.

  METHOD get_global_rebate.
    r_global_rebate = g_shop->get_global_rebate( ).
  ENDMETHOD.

  METHOD get_global_rebate_reason.
    r_global_rebate_reason = g_shop->get_global_rebate_reason( ).
  ENDMETHOD.

  METHOD get_total_price.
    r_total_price = g_shop->get_total_price( ).
  ENDMETHOD.

  METHOD create_alv_shop.
    DATA:
      alv_layout TYPE REF TO lcl_alv_layout
     .
    m_alv_shop = create_alv_grid( i_container_name = c_ccc4_alv_shop ).
    SET HANDLER me->add_item_to_cart FOR m_alv_shop.
    m_shop_items = g_shop->get_catalog( ).
    CREATE OBJECT alv_layout.
    alv_layout->disable_toolbar( ).
    DATA(layout) = alv_layout->m_layout.
    layout-grid_title = 'Product catalog'.

    CALL METHOD m_alv_shop->set_table_for_first_display
      EXPORTING
        i_structure_name = c_struc_name_alv_shop
        is_layout        = layout
      CHANGING
        it_outtab        = m_shop_items.
  ENDMETHOD.

  METHOD create_alv_cart.
    DATA:
      alv_layout TYPE REF TO lcl_alv_layout
     ,alv_fcat   TYPE REF TO lcl_alv_fieldcatalog
     .
    m_alv_cart = create_alv_grid( i_container_name = c_ccc4_alv_cart ).
    SET HANDLER me->remove_item_from_cart FOR m_alv_cart.
    m_cart_items = g_shop->get_cart( ).
    CREATE OBJECT alv_layout.
    alv_layout->disable_toolbar( ).
    CREATE OBJECT alv_fcat EXPORTING i_structure_name = c_struc_name_alv_cart.

    DATA(layout) = alv_layout->m_layout.
    layout-grid_title = 'Cart'.
    layout-col_opt = abap_true.

    LOOP AT alv_fcat->mt_fieldcatalog ASSIGNING FIELD-SYMBOL(<field_catalog>).
      <field_catalog>-colddictxt = 'L'.
      IF <field_catalog>-fieldname = 'REBATE_REASON'.
        <field_catalog>-outputlen = '44'.
      ENDIF.
    ENDLOOP.

    alv_fcat->set_total_for_column( 'STANDARD_TOTAL' ).
    alv_fcat->set_total_for_column( 'REBATE_AMOUNT' ).
    CALL METHOD m_alv_cart->set_table_for_first_display
      EXPORTING
        is_layout       = layout
      CHANGING
        it_fieldcatalog = alv_fcat->mt_fieldcatalog
        it_outtab       = m_cart_items.
  ENDMETHOD.

  METHOD create_alv_grid.
    DATA:
      cccontainer TYPE REF TO cl_gui_custom_container
     .
    CREATE OBJECT cccontainer
      EXPORTING
        container_name = i_container_name.
    CREATE OBJECT r_alv_grid
      EXPORTING
        i_parent = cccontainer.
  ENDMETHOD.

  METHOD add_item_to_cart.
    DATA(catalog_item) = m_shop_items[ es_row_no-row_id ].
    g_shop->add_item_to_cart( CONV #( catalog_item-id ) ).

    refresh_cart_display( ).
* ... Trigger PAI to update global UI fields after this handler method returns control
    cl_gui_cfw=>set_new_ok_code(
      EXPORTING
        new_code = |Dummy|
      IMPORTING
        rc       = DATA(rc)
    ).
  ENDMETHOD.

  METHOD remove_item_from_cart.
    DATA:
      cart_item TYPE zase_shop_cart_item
     ,rc TYPE i
     .
    READ TABLE m_cart_items INTO cart_item INDEX es_row_no-row_id.
    g_shop->remove_item_from_cart( cart_item ).
    refresh_cart_display( ).
* ... Trigger PAI to update global UI fields after this handler method returns control
    cl_gui_cfw=>set_new_ok_code(
      EXPORTING
        new_code = |Dummy|
      IMPORTING
        rc       = rc
    ).
  ENDMETHOD.

  METHOD refresh_cart_display.
    m_cart_items = g_shop->get_cart( ).
    m_alv_cart->refresh_table_display( ).
  ENDMETHOD.


  METHOD get_final_price.
    r_result = g_shop->get_final_price( ).
  ENDMETHOD.


  METHOD buy_cart.
    DATA(success) = g_shop->buy_cart( ).
    IF success = abap_true.
      user_notification = `Cart has been purchased for a value of ` && final_price.
      CLEAR: total_price, global_rebate, global_rebate_reason, final_price.
      refresh_cart_display( ).
    ELSE.
      user_notification = |Cart purchase failed|.
    ENDIF.
  ENDMETHOD.


  METHOD create_alv_active_rules.
    DATA:
      alv_layout TYPE REF TO lcl_alv_layout
     .
    DATA(active_rules_alv) = create_alv_grid( i_container_name = c_ccc4_alv_active_rules ).
    DATA(active_rules) = g_shop->get_names_of_active_rules( ).
    CREATE OBJECT alv_layout.
    alv_layout->disable_toolbar( ).
    DATA(layout) = alv_layout->m_layout.
    layout-grid_title = 'Active rules'.

    CALL METHOD active_rules_alv->set_table_for_first_display
      EXPORTING
        i_structure_name = c_struc_name_alv_rules
        is_layout        = layout
      CHANGING
        it_outtab        = active_rules.
  ENDMETHOD.

ENDCLASS.

* --- ALV Fieldcatalog ................................................*
CLASS lcl_alv_fieldcatalog IMPLEMENTATION.

  METHOD constructor.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = i_structure_name
      CHANGING
        ct_fieldcat      = mt_fieldcatalog.
  ENDMETHOD.

  METHOD set_total_for_column.
    me->customize( i_column_name  = i_column_name
                   i_field_name  = 'DO_SUM'
                   i_field_value = 'X'
                 ).
  ENDMETHOD.

  METHOD customize.
    DATA:
      fieldcatalog TYPE lvc_s_fcat
     .
    FIELD-SYMBOLS:
      <fs_field_to_modify> TYPE any
     .
    ASSIGN COMPONENT i_field_name OF STRUCTURE fieldcatalog
        TO <fs_field_to_modify>.
    READ TABLE mt_fieldcatalog WITH KEY fieldname = i_column_name
          INTO fieldcatalog.
    <fs_field_to_modify> = i_field_value.
    MODIFY mt_fieldcatalog FROM fieldcatalog INDEX sy-tabix.
  ENDMETHOD.

ENDCLASS.

* --- ALV Layout ......................................................*
CLASS lcl_alv_layout IMPLEMENTATION.

  METHOD disable_toolbar.
    me->customize( i_field_name = 'NO_TOOLBAR' i_field_value = 'X' ).
  ENDMETHOD.

  METHOD customize.
    FIELD-SYMBOLS:
      <field_to_modify> TYPE any
     .
    ASSIGN COMPONENT i_field_name OF STRUCTURE m_layout
        TO <field_to_modify>.
    <field_to_modify> = i_field_value.
  ENDMETHOD.

ENDCLASS.
