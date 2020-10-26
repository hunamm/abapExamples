class ZCL_WTC_SHOP_PAYMENTPROCESSOR definition
  public
  final
  create public .

public section.

  methods PAY
    importing
      !I_EMAIL_SENDER type ref to ZCL_WTC_SHOP_EMAIL_SENDER
      !I_VALUE type F
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  PROTECTED SECTION.
PRIVATE SECTION.
    METHODS:
      get_participant_information RETURNING VALUE(r_participant) TYPE string.
ENDCLASS.



CLASS ZCL_WTC_SHOP_PAYMENTPROCESSOR IMPLEMENTATION.


  METHOD get_participant_information.
    DATA my_classname TYPE abap_abstypename.
    my_classname = cl_abap_classdescr=>get_class_name( me ).
    r_participant = sy-uname && ` from ` && my_classname.
  ENDMETHOD.


  METHOD pay.
    CALL FUNCTION 'ZASE_WTC_SHOP_PROCESS_PAYMENT'
      EXPORTING
        i_username = sy-uname
        i_value    = i_value
      IMPORTING
        e_success  = r_success.

    IF r_success = abap_true.
      i_email_sender->send(
        i_subject = `Payment processed for user ` && sy-uname
        i_body    = VALUE #( ( `Final price: ` && i_value ) ( get_participant_information( ) ) )
      ).
    ELSE.
      i_email_sender->send(
        i_subject = `Payment FAILED for user ` && sy-uname
        i_body    = VALUE #( ( `Final price: ` && i_value ) ( get_participant_information( ) ) )
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
