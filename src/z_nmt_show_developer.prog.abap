*&---------------------------------------------------------------------*
*& Report  z_nmt_show_developer
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report z_nmt_show_developer.

types: begin of ty_developer,
         uname      type xubname,
         title      type ad_titletx,
         firstname  type ad_namefir,
         lastname   type ad_namelas,
         email      type ad_smtpadr,
         department type ad_dprtmnt,
         gltgv      type xugltgv,
         gltgb      type xugltgb,
         lock       type abap_bool,
       end of ty_developer,
       tyt_developer type table of ty_developer.

data: lt_developer type tyt_developer,
      ls_developer type ty_developer,
      ls_lockstate type uslock,
      ls_address   type bapiaddr3,
      lt_return    type bapiret2_t.

data: lc_locked type char1 value 'L'.

"--------------------------------------------------

tables: usr01.

select-options: s_user for usr01-bname.

select uname from devaccess into table @data(lt_user)
    where uname in @s_user.

loop at lt_user into data(ls_user).
  clear ls_developer.

  ls_developer-uname = ls_user-uname.

  clear lt_return.
  call function 'BAPI_USER_GET_DETAIL'
    exporting
      username = ls_user-uname
    importing
      address  = ls_address
    tables
      return   = lt_return.

  loop at lt_return assigning field-symbol(<ls_return>)
      where type ca 'AEX'.

    exit.

  endloop.

  if sy-subrc = 0.
    continue.

  endif.

  ls_developer-email = ls_address-e_mail.
  ls_developer-title = ls_address-title_p.
  ls_developer-lastname = ls_address-lastname.
  ls_developer-firstname = ls_address-firstname.
  ls_developer-department = ls_address-department.

  select single gltgv, gltgb from usr02 into (@ls_developer-gltgv, @ls_developer-gltgb)
    where bname = @ls_user-uname.

  if ls_developer-gltgb is not initial and
     ls_developer-gltgb < sy-datum.

    continue.

  endif.

  clear ls_lockstate.
  call function 'SUSR_USER_LOCKSTATE_GET'
    exporting
      user_name           = ls_user-uname
    importing
      lockstate           = ls_lockstate
    exceptions
      user_name_not_exist = 1
      others              = 2.

  if sy-subrc ne 0.
    continue.

  endif.

  ls_developer-lock = cond #( when ls_lockstate-local_lock = lc_locked or
                                   ls_lockstate-glob_lock = lc_locked
                              then abap_true ).

  append ls_developer to lt_developer.

endloop.

sort lt_developer by lastname firstname.

try.
    cl_salv_table=>factory(
      importing
        r_salv_table = data(lo_alv)
      changing
        t_table      = lt_developer ).

  catch cx_salv_msg.

endtry.

data(lo_columns) = lo_alv->get_columns( ).
lo_columns->set_optimize( ).

try.
    data(lo_column) = cast cl_salv_column( lo_columns->get_column( 'LOCK' ) ).
    lo_column->set_long_text( 'Gesperrt' ).

  catch cx_salv_not_found.

endtry.

lo_alv->get_columns( )->set_optimize( ).
lo_alv->get_functions( )->set_all( ).
lo_alv->display( ).
