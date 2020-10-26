FUNCTION ZASE_WTC_SHOP_PROCESS_PAYMENT.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_USERNAME) TYPE  SYST_UNAME
*"     VALUE(I_VALUE) TYPE  F
*"  EXPORTING
*"     REFERENCE(E_SUCCESS) TYPE  ABAP_BOOL
*"--------------------------------------------------------------------
  "********************************************
  "Some old, odd, legacy code...
  "********************************************

  DATA: l_mod3 TYPE i,
        l_mod5 TYPE i.
  DATA: result TYPE string.

  DO 15 TIMES.
    l_mod3 = sy-index MOD 3.
    l_mod5 = sy-index MOD 5.

    IF l_mod3 = 0 AND l_mod5 = 0.
      result = 'FizzBuzz'.
      CONTINUE.
    ENDIF.

    IF l_mod3 = 0.
      result = 'Fizz'.
      CONTINUE.
    ENDIF.

    IF l_mod5 = 0.
      result = 'Buzz'.
      CONTINUE.
    ENDIF.
  ENDDO.

  IF i_value < 1000.
    e_success = abap_true.
  ENDIF.

  DATA count TYPE i.
  DATA upper TYPE string.
  DATA roman TYPE string.
  DATA:
    cr_work(21),
    cr_countc(5).
  CHECK count > 0.
  CHECK count <= 9999.

  WRITE count TO cr_countc NO-SIGN NO-ZERO.
  SHIFT cr_countc LEFT.

  CASE cr_countc(1). "...................Tausender......................
    WHEN '1'. cr_work(9) = 'm        '.
    WHEN '2'. cr_work(9) = 'mm       '.
    WHEN '3'. cr_work(9) = 'mmm      '.
    WHEN '4'. cr_work(9) = 'mmmm     '.
    WHEN '5'. cr_work(9) = 'mmmmm    '.
    WHEN '6'. cr_work(9) = 'mmmmmm   '.
    WHEN '7'. cr_work(9) = 'mmmmmmm  '.
    WHEN '8'. cr_work(9) = 'mmmmmmmm '.
    WHEN '9'. cr_work(9) = 'mmmmmmmmm'.
  ENDCASE.

  CASE cr_countc+1(1). ".................Hunderter......................
    WHEN '1'. cr_work+9(4) = 'c   '.
    WHEN '2'. cr_work+9(4) = 'cc  '.
    WHEN '3'. cr_work+9(4) = 'ccc '.
    WHEN '4'. cr_work+9(4) = 'cd  '.
    WHEN '5'. cr_work+9(4) = 'd   '.
    WHEN '6'. cr_work+9(4) = 'dc  '.
    WHEN '7'. cr_work+9(4) = 'dcc '.
    WHEN '8'. cr_work+9(4) = 'dccc'.
    WHEN '9'. cr_work+9(4) = 'dm  '.
  ENDCASE.

  CASE cr_countc+2(1). ".................Zehner.........................
    WHEN '1'. cr_work+13(4) = 'x   '.
    WHEN '2'. cr_work+13(4) = 'xx  '.
    WHEN '3'. cr_work+13(4) = 'XXX '.
    WHEN '4'. cr_work+13(4) = 'xl  '.
    WHEN '5'. cr_work+13(4) = 'l   '.
    WHEN '6'. cr_work+13(4) = 'lx  '.
    WHEN '7'. cr_work+13(4) = 'lxx '.
    WHEN '8'. cr_work+13(4) = 'lxxx'.
    WHEN '9'. cr_work+13(4) = 'xc  '.
  ENDCASE.

  CASE cr_countc+3(1). ".................Einer..........................
    WHEN '1'. cr_work+17(4) = 'i   '.
    WHEN '2'. cr_work+17(4) = 'ii  '.
    WHEN '3'. cr_work+17(4) = 'iii '.
    WHEN '4'. cr_work+17(4) = 'iv  '.
    WHEN '5'. cr_work+17(4) = 'v   '.
    WHEN '6'. cr_work+17(4) = 'vi  '.
    WHEN '7'. cr_work+17(4) = 'vii '.
    WHEN '8'. cr_work+17(4) = 'viii'.
    WHEN '9'. cr_work+17(4) = 'ix  '.
  ENDCASE.

  CONDENSE cr_work NO-GAPS.

  IF upper > space.
    TRANSLATE cr_work TO UPPER CASE.
  ENDIF.



ENDFUNCTION.
