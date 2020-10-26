FUNCTION ZASE_SHOP_APP_0100.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_CUSTOM_CLASS_NAME) TYPE  CLASSNAME
*"----------------------------------------------------------------------
  TRANSLATE i_custom_class_name TO UPPER CASE.

  DATA object_meta_data TYPE REF TO cl_oo_object.
  DATA class_meta_data  TYPE REF TO cl_oo_class.

  TRY.
      object_meta_data = cl_oo_object=>get_instance( to_upper( i_custom_class_name ) ).
      class_meta_data ?= object_meta_data.

    CATCH cx_class_not_existent cx_sy_move_cast_error.
      MESSAGE `Class ` && i_custom_class_name && ` does not exist` TYPE 'S'.
      CALL SELECTION-SCREEN 0200.
      RETURN.
  ENDTRY.

  CREATE OBJECT g_shop TYPE (i_custom_class_name).

  CALL SCREEN 0100.

ENDFUNCTION.
