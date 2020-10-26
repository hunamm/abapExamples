*&---------------------------------------------------------------------*
*& Report ase_shop_gen_testdata
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zase_shop_gen_testdata.

*==========================================================
class lth_ase_shop_test_utils definition.
  public section.
    class-methods:
      gen_item_db_test_data.

endclass.

class lth_ase_shop_test_utils implementation.

  method gen_item_db_test_data.

    DATA:
      ls_shop_item TYPE zase_shop_item,
      ls_cart_item TYPE zase_shop_cart_item,
      lt_shop_items type zase_shop_item_table,
      cnt type i.

    "-- Build up initial item list
    lt_shop_items = VALUE #( ( id = '1' category = 'DVDs' name = 'Couragous' price = '10.99' )
                        ( id = '2' category = 'Household' name = 'Iron' price = '49.65' )
                        ( id = '3' category = 'Gardening' name = 'Waterhose' price = '15.66' )
                        ( id = '4' category = 'DVDs' name = 'Kill bill' price = '16.99' )
                        ( id = '5' category = 'Computers' name = 'Mouse' price = '5.66' )
                        ( id = '6' category = 'Computers' name = 'Screen' price = '215.55' )
                        ( id = '7' category = 'Books' name = 'Moby Dick' price = '15.66' )
                        ( id = '8' category = 'Books' name = 'Refactoring' price = '59.99' )
                        ( id = '9' category = 'Books' name = 'Domain Driven Design' price = '39.99' )
                        ( id = '10' category = 'DVDs' name = 'Narnia' price = '12.99' )
                      ).

    delete from zase_shop_item_d.
    insert zase_shop_item_d from table lt_shop_items.
    commit work.

  endmethod.

endclass.

*=======================================================================
start-of-selection.

lth_ase_shop_test_utils=>gen_item_db_test_data( ).
