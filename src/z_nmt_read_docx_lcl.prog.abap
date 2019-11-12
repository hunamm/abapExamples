*&---------------------------------------------------------------------*
*&  Include  z_nmt_read_docx_lcl
*&---------------------------------------------------------------------*

class lcl_model definition final.

  public section.
    methods:
      get_doc_binary
        returning value(rv_content) type xstring.

endclass.

class lcl_controller definition final.

  public section.
    class-methods:
      main,
      f4_file
        changing cv_path type dxlpath.

  private section.

endclass.

class lcl_model implementation.

  method get_doc_binary.

    data: lt_raw_data type standard table of x255.

    data: lv_length type i.

    "--------------------------------------------------

    call method cl_gui_frontend_services=>gui_upload
      exporting
        filename   = conv #( p_file )
        filetype   = 'BIN'
      importing
        filelength = lv_length
      changing
        data_tab   = lt_raw_data.

    call function 'SCMS_BINARY_TO_XSTRING'
      exporting
        input_length = lv_length
      importing
        buffer       = rv_content
      tables
        binary_tab   = lt_raw_data.

  endmethod.

endclass.

class lcl_controller implementation.

  method main.

    data: lo_document type ref to cl_docx_document.

    data: lv_content    type xstring,
          lv_xml        type xstring,
          lv_xml_result type xstring.

    "--------------------------------------------------

    break-point.
    data(lr_model) = new lcl_model( ).
    lv_content = lr_model->get_doc_binary( ).

    try.
        lo_document = cl_docx_document=>load_document( lv_content ).
        check lo_document is not initial.
        data(lo_core_part) = lo_document->get_corepropertiespart( ).
        data(lv_core_data) = lo_core_part->get_data( ).
        data(lo_main_part) = lo_document->get_maindocumentpart( ).
        lv_xml = lo_main_part->get_data( ).

        call transformation z_nmt_trans_test
            source xml lv_xml result xml lv_xml_result.

*        call transformation z_nmt_trans_test
*            source xml lv_xml lv_xml_result result xml lv_xml_result.

**********************************************************************
* jetzt werden die Tags ermittelt
**********************************************************************
*data: lt_result         TYPE match_result_tab.

*  FIND ALL OCCURRENCES OF REGEX `<[^>]+>`
*    IN lv_xml RESULTS lt_result.


"--- To JSON
*/ui2/cl_json=>deserialize / serialize
" https://wiki.scn.sap.com/wiki/display/Snippets/One+more+ABAP+to+JSON+Serializer+and+Deserializer
" https://answers.sap.com/questions/486739/deserialize-unknown-json-structure-with-ui2cljson.html
" https://codezentrale.de/tag/ui2cl_json/


*        data(lo_image_parts) = lo_main_part->get_imageparts( ).
*        data(lv_image_count) = lo_image_parts->get_count( ).
*
*        do lv_image_count times.
*          data(lo_image_part) = lo_image_parts->get_part( sy-index - 1 ).
*          data(lv_image_data) = lo_image_part->get_data( ).
*        enddo.
*
*        data(lo_header_parts) = lo_main_part->get_headerparts( ).
*        data(lv_header_count) = lo_header_parts->get_count( ).
*
*        do lv_header_count times.
*          data(lo_header_part) = lo_header_parts->get_part( sy-index - 1 ).
*          data(lv_header_data) = lo_header_part->get_data( ).
*        enddo.

      catch cx_openxml_format.

      catch cx_openxml_not_found.

    endtry.



  endmethod.

  method f4_file.

    data: lv_file_name type localfile.

    "--------------------------------------------------

    call function 'F4_FILENAME'
      exporting
        field_name = 'P_FILE'
      importing
        file_name  = lv_file_name.

    cv_path = lv_file_name.

  endmethod.

endclass.
