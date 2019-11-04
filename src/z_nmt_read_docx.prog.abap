*&---------------------------------------------------------------------*
*& Report  Z_NMT_READ_DOCX
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

include z_nmt_read_docx_top.
include z_nmt_read_docx_sel.
include z_nmt_read_docx_lcl.


at selection-screen on value-request for p_file.
  lcl_controller=>f4_file( changing cv_path = p_file ).

start-of-selection.
  lcl_controller=>main( ).
