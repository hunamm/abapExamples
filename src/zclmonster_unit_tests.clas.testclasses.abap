*"* use this source file for your ABAP unit test classes
class ltcl_monster_test definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      first_monster for testing raising cx_static_check.
endclass.


class ltcl_monster_test implementation.

  method first_monster.

    data(cut) = new zclmonster_unit_tests( ).

    cut->first_monster( ).

*    cl_abap_unit_assert=>fail( 'Implement your first test here' ).
  endmethod.

endclass.
