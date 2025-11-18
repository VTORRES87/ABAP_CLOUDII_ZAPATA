CLASS zcl_fill_fields_vt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

 INTERFACES IF_OO_ADT_CLASSRUN.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FILL_FIELDS_VT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lt_data  TYPE STANDARD TABLE OF zdt_priority_vhv.
    DATA lt_data2 TYPE STANDARD TABLE OF zdt_status_vhv.


    lt_data = VALUE #(
      ( priority = 'H' description = 'High' )
      ( priority = 'M' description = 'Medium' )
      ( priority = 'L' description = 'Low' )
    ).

    INSERT zdt_priority_vhv FROM TABLE @lt_data.

    out->write( |Registros insertados: { lines( lt_data ) }| ).


        lt_data2 = VALUE #(
      ( status = 'OP' description = 'Open' )
      ( status = 'IP' description = 'In Progress' )
      ( status = 'PE' description = 'Pending' )
      ( status = 'CO' description = 'Completed' )
      ( status = 'CL' description = 'Closed' )
      ( status = 'CN' description = 'Cancel' )
    ).

    INSERT zdt_status_vhv FROM TABLE @lt_data2.

    out->write( |Registros insertados: { lines( lt_data2 ) }| ).


  ENDMETHOD.
ENDCLASS.
