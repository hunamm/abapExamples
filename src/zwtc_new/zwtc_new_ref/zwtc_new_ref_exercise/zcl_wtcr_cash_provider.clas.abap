CLASS zcl_wtcr_cash_provider DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_wtcr_cash_provider.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WTCR_CASH_PROVIDER IMPLEMENTATION.

  METHOD zif_wtcr_cash_provider~get_coins.
    "not usable right now
    ASSERT 0 = 1.
  ENDMETHOD.


  METHOD zif_wtcr_cash_provider~get_notes.
    "not usable right now
    ASSERT 0 = 1.
  ENDMETHOD.

ENDCLASS.
