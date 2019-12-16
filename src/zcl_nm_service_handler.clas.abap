class ZCL_NM_SERVICE_HANDLER definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_NM_SERVICE_HANDLER IMPLEMENTATION.


  method if_http_extension~handle_request.

    data: lv_path    type string,
          lv_content type xstring,
          lv_name    type string,
          lv_file    type string.

    constants: lc_log_file_name type fileintern value 'Z_IMG'.

    "--------------------------------------------------

* Inform ICF to "keep" (reuse) this handler, and that we answered the HTTP request
    if_http_extension~lifetime_rc = if_http_extension=>co_lifetime_keep.
    if_http_extension~flow_rc     = if_http_extension=>co_flow_ok.

* Determine image name from URL ~script_name/~path_info (= image_name)

    lv_name = server->request->get_header_field( name = if_http_header_fields_sap=>path_info ).
    translate lv_name to upper case.
    if strlen( lv_name ) >= 1 and lv_name(1) = '/'.
      shift lv_name left.

    endif.

    "--------------------------------------------------
    "--- From server directory

    call function 'FILE_GET_NAME_USING_PATH'
      exporting
        logical_path               = lc_log_file_name
        file_name                  = lv_name
        eleminate_blanks           = abap_false
      importing
        file_name_with_path        = lv_file
      exceptions
        path_not_found             = 1
        missing_parameter          = 2
        operating_system_not_found = 3
        file_system_not_found      = 4
        others                     = 5.

    if sy-subrc = 0.
      try.
          open dataset lv_file for input in binary mode.
          read dataset lv_file into lv_content.
          close dataset lv_file.

        catch cx_root.

      endtry.

    endif.

    "--------------------------------------------------

    if xstrlen( lv_content ) is initial.
      raise exception type cx_http_ext_exception exporting msg = 'Invalid URL!'.

    endif.

    "--- Set up HTTP response
    server->response->set_status( code = 200 reason = 'OK' ).
    server->response->set_header_field( name = if_http_header_fields=>content_type value = 'image/jpeg' ).
    server->response->server_cache_expire_rel( expires_rel = 86000 ).
    server->response->set_header_field( name = if_http_header_fields=>cache_control value = 'max-age=86000' ).
    server->response->set_data( lv_content ).

  endmethod.
ENDCLASS.
