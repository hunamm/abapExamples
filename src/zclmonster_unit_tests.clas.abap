class zclmonster_unit_tests definition
  public
  final
  create public .

  public section.
    methods:
      first_monster,
      second_monster.

  protected section.
  private section.
endclass.



class zclmonster_unit_tests implementation.
  method first_monster.

    write: / 'I am the first Monster'.

  endmethod.

  method second_monster.

    write: / 'I am the second Monster'.

  endmethod.

endclass.
