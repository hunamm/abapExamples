class ZCL_WTC_SHOP_USER definition
  public
  final
  create public .

public section.

  methods GET_FULL_NAME
    returning
      value(R_FULLNAME) type STRING .
  methods GET_EMAIL
    returning
      value(R_EMAIL) type STRING .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_WTC_SHOP_USER IMPLEMENTATION.


  METHOD get_email.
    DATA:
      badi_return  TYPE STANDARD TABLE OF bapiret2,
      address_smtp TYPE TABLE OF bapiadsmtp.

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username = sy-uname
      TABLES
        addsmtp  = address_smtp
        return   = badi_return.

    TRY.
        r_email = address_smtp[ 1 ]-e_mail.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.


  METHOD get_full_name.
    DATA:
      address     TYPE bapiaddr3,
      badi_return TYPE STANDARD TABLE OF bapiret2.
    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username = sy-uname
      IMPORTING
        address  = address
      TABLES
        return   = badi_return.

    "-- No need to check SY-SUBRC as the FM will never raise an Exception.
    CONCATENATE address-firstname
                address-lastname
          INTO  r_fullname
          SEPARATED BY space.

  ENDMETHOD.
ENDCLASS.
