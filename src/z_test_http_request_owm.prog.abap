*&---------------------------------------------------------------------*
*& Report  ztest
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
report z_test_http_request_owm.

data: lo_http_client type ref to if_http_client,
      lo_rest_client type ref to cl_rest_http_client,
      lo_response    type ref to if_rest_entity.

data: lv_url         type        string.

"--------------------------------------------------

if sy-subrc <> 0.
* Implement a suitable exception handling here
endif.


* Create HTTP intance using RFC restination created
* You can directly use the REST service URL as well
call method cl_http_client=>create_by_destination
  exporting
    destination              = 'OWM'
  importing
    client                   = lo_http_client    " HTTP Client Abstraction
  exceptions
    argument_not_found       = 1
    destination_not_found    = 2
    destination_no_authority = 3
    plugin_not_active        = 4
    internal_error           = 5
    others                   = 6.

"--- Create REST client instance
create object lo_rest_client
  exporting
    io_http_client = lo_http_client.

"--- Set HTTP version
lo_http_client->request->set_version( if_http_request=>co_protocol_version_1_0 ).
if lo_http_client is bound and lo_rest_client is bound.
  lv_url = '/data/2.5/forecast/hourly?q=Ravensburg,DE&APPID=00084ed63988ecdf002b0dcb9926917c&lang=de&units=metric'.
* Set the URI if any
  call method cl_http_utility=>set_request_uri
    exporting
      request = lo_http_client->request    " HTTP Framework (iHTTP) HTTP Request
      uri     = lv_url.                     " URI String (in the Form of /path?query-string)

  "--- HTTP GET
  lo_rest_client->if_rest_client~get( ).

  "--- HTTP response
  lo_response = lo_rest_client->if_rest_client~get_response_entity( ).

* HTTP return status
  data(http_status) = lo_response->get_header_field( '~status_code' ).


* HTTP JSON return string
  data(json_response) = lo_response->get_string_data( ).

  write: http_status.

  types: begin of ty_coord,
           lon type f,
           lat type f,
         end of ty_coord.

  types: begin of ty_data,
           coord type ty_coord,

         end of ty_data.


*  /ui2/cl_json=>deserialize( exporting json = json_response pretty_name = /ui2/cl_json=>pretty_mode-camel_case changing data = ls_data ).


  types: begin of ty_main,
           temp_min type f,
           temp_max type f,
         end of ty_main.

  types: begin of ty_weather,
           main        type string,
           description type string,
         end of ty_weather,
         tyt_weather type standard table of ty_weather with empty key.

  types: begin of ty_list,
           dt_txt  type string, "comt_created_at_usr,
           main    type ty_main,
           weather type tyt_weather,
         end of ty_list,
         tyt_list type sorted table of ty_list with unique key primary_key components dt_txt.

  types: begin of ty_json,
           list type tyt_list,
         end of ty_json.

  data: ls_json type ty_json.

  "--- Example:
*{"cod":"200","message":0.0151,"cnt":96,"list":[{"dt":1553709600,"main":{"temp":278.76,"temp_min":278.76,"temp_max":279.558,"pressure":1031.934,
*"sea_level":1031.934,"grnd_level":971.745,"humidity":100,"temp_kf":-0.8},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],
*"clouds":{"all":77},"wind":{"speed":1.6,"deg":40.932},"sys":{"pod":"n"},"dt_txt":"2019-03-27 18:00:00"},

  /ui2/cl_json=>deserialize( exporting json = json_response pretty_name = /ui2/cl_json=>pretty_mode-camel_case changing data = ls_json ).

endif.
