*----------------------------------------------------------------------*
***INCLUDE LASE_SHOP_APPO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN_0100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module TITLEBAR_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE titlebar_0100 OUTPUT.
  DATA(participant_class_name) = cl_abap_classdescr=>get_class_name( g_shop ).
  participant_class_name = substring( val = participant_class_name off = 10 len = 5 ).
  "Reference implementation
  IF participant_class_name+4(1) = '_'.
    participant_class_name = substring( val = participant_class_name off = 0 len = 4 ).
  ENDIF.
  SET TITLEBAR 'SCREEN_0100' WITH participant_class_name.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_CONTROLS OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_controls OUTPUT.
  IF go_shop_gui IS INITIAL.
    CREATE OBJECT go_shop_gui.
  ENDIF.
ENDMODULE.
