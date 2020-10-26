class ZCL_WTC_SHOP_CATALOG definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR .
  methods GET_CATALOG
    returning
      value(R_CATALOG) type ZASE_SHOP_ITEM_TABLE .
  methods GET_ITEM
    importing
      !I_ID type INT4
    returning
      value(R_ITEM) type ZASE_SHOP_ITEM .
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA:
      m_items TYPE zase_shop_item_table.    "-- should be read-only but cannot because of ALV

    METHODS:
      gen_local_test_data
      .
ENDCLASS.



CLASS ZCL_WTC_SHOP_CATALOG IMPLEMENTATION.


  METHOD constructor.
    gen_local_test_data( ).
  ENDMETHOD.


  METHOD gen_local_test_data.
    "-- Build up initial item list
    m_items = VALUE #(
      ( id = '111' category = 'Books'     name = 'Refactoring'          price = '59.99'  )
      ( id = '137' category = 'Household' name = 'Iron'                 price = '49.65'  )
      ( id = '250' category = 'DVDs'      name = 'Narnia'               price = '12.99'  )
      ( id = '270' category = 'Books'     name = 'Moby Dick'            price = '15.66'  )
      ( id = '362' category = 'Books'     name = 'Domain Driven Design' price = '39.99'  )
      ( id = '365' category = 'Gardening' name = 'Waterhose'            price = '15.66'  )
      ( id = '368' category = 'DVDs'      name = 'Couragous'            price = '10.99'  )
      ( id = '458' category = 'Computers' name = 'Screen'               price = '215.55' )
      ( id = '570' category = 'DVDs'      name = 'Kill bill'            price = '16.99'  )
      ( id = '964' category = 'Computers' name = 'Mouse'                price = '5.66'   )
    ).
  ENDMETHOD.


  METHOD get_catalog.
    r_catalog = m_items.
  ENDMETHOD.


  METHOD get_item.
    READ TABLE m_items INTO r_item WITH KEY id = i_id.
  ENDMETHOD.
ENDCLASS.
