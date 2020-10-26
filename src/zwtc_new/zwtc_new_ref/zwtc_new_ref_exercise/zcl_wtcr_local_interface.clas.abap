CLASS zcl_wtcr_local_interface DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor.
    METHODS get_amount_in_coins
      IMPORTING i_amount       TYPE i
      RETURNING VALUE(r_value) TYPE i.
    METHODS get_amount_in_notes
      IMPORTING i_amount       TYPE i
      RETURNING VALUE(r_value) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA m_cash_provider TYPE REF TO lif_cash_provider. "back door injection
ENDCLASS.



CLASS ZCL_WTCR_LOCAL_INTERFACE IMPLEMENTATION.


  METHOD constructor.
    m_cash_provider = NEW lcl_cash_provider( ).
  ENDMETHOD.


  METHOD get_amount_in_coins.
    DATA(notes) = m_cash_provider->get_notes( i_currency = 'EUR' ).  "provide testability
    SORT notes BY amount ASCENDING.

    r_value = COND #( WHEN i_amount <= 0
                      THEN -1
                      ELSE i_amount MOD notes[ 1 ]-amount ).
  ENDMETHOD.


  METHOD get_amount_in_notes.
    r_value = get_amount_in_coins( i_amount ).
    IF r_value >= 0.
      r_value = i_amount - r_value.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
