*&---------------------------------------------------------------------*
*& Report  ztest_tmp
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report z_pp_vi_show_absolute_volume.

parameters: p_inspid type z_pp_sl_grupnr.

data: lo_strichliste type ref to zcl_sl_db_strichliste.

data: lt_stlnr type table of z_pp_sl_stlnr,
      lt_menge type table of zpp_sl_mengeokomma,
      ls_menge type zpp_sl_mengeokomma.

data: lv_total type i.

select stlnr from zpp_sl_kopf into table lt_stlnr
    where grupnr = p_inspid.

lo_strichliste = new #( ).
loop at lt_stlnr into data(lv_strlnr).
  call method lo_strichliste->m_get_sl_mengensum
    exporting
      iv_stlnr    = lv_strlnr
      iv_stlposnr = '0001'
      iv_allpos   = 'X'
    importing
      es_mengen   = ls_menge.

  append ls_menge to lt_menge.

  lv_total = lv_total + ls_menge-mengegesamt.

endloop.

write: |ca. { lv_total }|.
