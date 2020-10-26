INTERFACE ZIF_WTC_CASH_PROVIDER
  PUBLIC.
  TYPES: BEGIN OF ty_change,
           amount TYPE i,
           type   TYPE string,
         END OF ty_change.
  TYPES tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY.

  METHODS get_notes
    IMPORTING i_currency TYPE string
    RETURNING value(r_change) type tt_change.
  METHODS get_coins
    IMPORTING i_currency TYPE string
    RETURNING value(r_change) type tt_change.
ENDINTERFACE.
