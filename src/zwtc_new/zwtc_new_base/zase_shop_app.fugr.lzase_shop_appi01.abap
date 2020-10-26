*----------------------------------------------------------------------*
***INCLUDE LASE_SHOP_APPI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  pai_ok_code = ok_code.
  CASE pai_ok_code.
    WHEN 'BACK' OR 'exit' OR 'cancel'.
      LEAVE PROGRAM.
  ENDCASE.

  global_rebate = go_shop_gui->get_global_rebate( ).
  global_rebate_reason = go_shop_gui->get_global_rebate_reason( ).
  total_price = go_shop_gui->get_total_price( ).
  final_price = go_shop_gui->get_final_price( ).

  CLEAR ok_code.
  CASE pai_ok_code.
    WHEN 'BUY'.
      go_shop_gui->buy_cart( ).
    WHEN OTHERS.

  ENDCASE.
ENDMODULE.
