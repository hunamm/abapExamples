CLASS zcl_wtcr_money_machine DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_change,
             amount TYPE i,
             type   TYPE string,
           END OF ty_change.
    TYPES tt_change TYPE STANDARD TABLE OF ty_change WITH DEFAULT KEY.

    METHODS constructor.
    METHODS get_change
      IMPORTING i_amount        TYPE i
      RETURNING VALUE(r_change) TYPE tt_change.
    METHODS get_amount_in_coins
      IMPORTING i_amount       TYPE i
      RETURNING VALUE(r_coin_amount) TYPE i.
    METHODS get_amount_in_notes
      IMPORTING i_amount       TYPE i
      RETURNING VALUE(r_note_amount) TYPE i.

  PRIVATE SECTION.
    DATA m_ordered_amounts TYPE tt_change.
ENDCLASS.



CLASS ZCL_WTCR_MONEY_MACHINE IMPLEMENTATION.

  METHOD constructor.
    m_ordered_amounts = VALUE #(
      ( amount = 500 type = 'note' )
      ( amount = 200 type = 'note' )
      ( amount = 100 type = 'note' )
      ( amount = 50  type = 'note' )
      ( amount = 20  type = 'note' )
      ( amount = 10  type = 'note' )
      ( amount = 5   type = 'note' )
      ( amount = 2   type = 'coin' )
      ( amount = 1   type = 'coin' )
    ).
  ENDMETHOD.


  METHOD get_amount_in_coins.
    r_coin_amount = COND #( WHEN i_amount <= 0
                      THEN -1
                      ELSE i_amount MOD 5 ).
  ENDMETHOD.


  METHOD get_amount_in_notes.
    r_note_amount = get_amount_in_coins( i_amount ).
    IF r_note_amount >= 0.
      r_note_amount = i_amount - r_note_amount.
    ENDIF.
  ENDMETHOD.


  METHOD get_change.
    DATA(remaining_amount) = i_amount.
    WHILE remaining_amount > 0.
      LOOP AT m_ordered_amounts INTO DATA(amount).
        IF remaining_amount >= amount-amount.
          APPEND amount TO r_change.
          SUBTRACT amount-amount FROM remaining_amount.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
