CLASS zcl_wtcr_cash_provider_static DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_change,
             amount TYPE i,
             type   TYPE string,
           END OF ty_change.
    TYPES tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY.

    CLASS-METHODS get_notes
      IMPORTING i_currency      TYPE string
      RETURNING VALUE(r_change) TYPE tt_change.
    CLASS-METHODS get_coins
      IMPORTING i_currency      TYPE string
      RETURNING VALUE(r_change) TYPE tt_change.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WTCR_CASH_PROVIDER_STATIC IMPLEMENTATION.


  METHOD get_coins.
    "not usable right now
    ASSERT 0 = 1.
  ENDMETHOD.


  METHOD get_notes.
    "not usable right now
    ASSERT 0 = 1.
  ENDMETHOD.
ENDCLASS.
