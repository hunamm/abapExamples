*&---------------------------------------------------------------------*
*& Report  z_pp_vi_limit_calc_assist
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report z_pp_vi_limit_calc_assist.

parameters: p_cls type z_pp_vi_cluster.

types: begin of ty_ic_interim,
         pmkid          type z_pp_sl_pmkid,
         average        type f,
         average_short  type p length 4 decimals 6,
         std_devi       type f,
         std_devi_short type p length 4 decimals 6,
       end of ty_ic_interim,
       tyt_ic_interim type table of ty_ic_interim.

data: lr_calculator type ref to zcl_pp_vi_limit_calculator,
      lr_alv        type ref to cl_salv_table.

data: lt_ic_interim_result type zcl_pp_vi_limit_calculator=>tyt_ic_calc,
      lt_ic_group_result   type zcl_pp_vi_limit_calculator=>tyt_icg_calc_result,
      lt_list              type tyt_ic_interim,
      ls_list              type ty_ic_interim.

lr_calculator = zcl_pp_vi_limit_calculator=>get_instance( ).
break-point.
call method lr_calculator->get_interim_result_by_cluster
  exporting
    iv_cluster                 = p_cls
  importing
    et_ic_interim_result       = lt_ic_interim_result
    et_cluster_ic_group_result = lt_ic_group_result.

break-point.

loop at lt_ic_interim_result into data(ls_interim).
  ls_list = corresponding #( ls_interim ).
  ls_list-average_short = ls_interim-average.
  ls_list-std_devi_short = ls_interim-std_devi.
  append ls_list to lt_list.

endloop.

try.
    call method cl_salv_table=>factory
      importing
        r_salv_table = lr_alv
      changing
        t_table      = lt_list.

  catch cx_salv_msg.

endtry.

lr_alv->get_columns( )->set_optimize( ).

try.
    lr_alv->get_columns( )->get_column( 'AVERAGE' )->set_long_text( 'Durchschnitt' ).
    lr_alv->get_columns( )->get_column( 'STD_DEVI' )->set_long_text( 'Standardabweichung' ).

  catch cx_salv_not_found.

endtry.

lr_alv->get_functions( )->set_all( ).
lr_alv->display( ).
