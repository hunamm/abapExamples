*&---------------------------------------------------------------------*
*& Report  ZTEST2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report z_test_http_request.

data: lo_client      type ref to if_http_client,
      lo_request     type ref to if_http_request,
      lv_rc          type sy-subrc,
      lv_http_rc     type sy-subrc,
      lv_xml_xstring type xstring,
      lv_xml_string  type string,
      lv_url         type string value 'https://www.w3schools.com/tags/tag_embed.asp'.

"--------------------------------------------------

call method cl_http_client=>create_by_url
  exporting
    url                = lv_url
*   proxy_host         =
*   proxy_service      =
*   ssl_id             =
*   sap_username       =
*   sap_client         =
  importing
    client             = lo_client
  exceptions
    argument_not_found = 1
    plugin_not_active  = 2
    internal_error     = 3
    others             = 4.
if sy-subrc <> 0.
*   Implement suitable error handling here
endif.

call method lo_client->request->set_method(
  if_http_request=>co_request_method_get ).

call method lo_client->send
  exceptions
    http_communication_failure = 1
    http_invalid_state         = 2
    http_processing_failed     = 3
    http_invalid_timeout       = 4
    others                     = 5.
if sy-subrc <> 0.
  raise connection_error.
endif.

call method lo_client->receive
  exceptions
    http_communication_failure = 1
    http_invalid_state         = 2
    http_processing_failed     = 3
    others                     = 4.

lv_rc = sy-subrc. "error receive

if lv_rc = 0.
**http status code
  lo_client->response->get_status( importing code = lv_http_rc ).

  if lv_http_rc <> 200.
    """KO
  else. "status 200 ->>OK
    clear: lv_xml_xstring.
    lv_xml_xstring = lo_client->response->get_data( ).

  endif.
endif.

lo_client->close( ).

data(o_conv_r) = cl_abap_conv_in_ce=>create( input = lv_xml_xstring encoding = 'UTF-8' ).
o_conv_r->read( importing data = lv_xml_string ).

write: / lv_xml_string.
