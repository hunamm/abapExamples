class ZCL_WTC_CASH_PROVIDER_STATIC definition
  public
  final
  create private .

public section.

  types:
    BEGIN OF ty_change,
             amount TYPE i,
             type   TYPE string,
           END OF ty_change .
  types:
    tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY .

  class-methods GET_NOTES
    importing
      !I_CURRENCY type STRING
    returning
      value(R_CHANGE) type TT_CHANGE .
  class-methods GET_COINS
    importing
      !I_CURRENCY type STRING
    returning
      value(R_CHANGE) type TT_CHANGE .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WTC_CASH_PROVIDER_STATIC IMPLEMENTATION.


  METHOD get_coins.
    "not usable right now
    ASSERT 0 = 1.
  ENDMETHOD.


  METHOD get_notes.
    "not usable right now
    ASSERT 0 = 1.
  ENDMETHOD.
ENDCLASS.
