CLASS zcl_incidentes_messages_vt DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .
    INTERFACES if_abap_behv_message .

    CONSTANTS:
      gc_msgid TYPE symsgid VALUE 'ZCL_INCIDENTES',

        BEGIN OF title_unkown,
        msgid TYPE symsgid VALUE 'ZCL_INCIDENTES',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'MV_TITLE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF title_unkown,

      BEGIN OF Description_unkown,
        msgid TYPE symsgid VALUE 'ZCL_INCIDENTES',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'MV_DESCRIPTION',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF Description_unkown,

      BEGIN OF Priority_unkown,
        msgid TYPE symsgid VALUE 'ZCL_INCIDENTES',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'MV_PRIORITY',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF Priority_unkown,

            BEGIN OF status_unkown,
        msgid TYPE symsgid VALUE 'ZCL_INCIDENTES',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'MV_STATUS',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF status_unkown.


      METHODS constructor
      IMPORTING
        textid                LIKE if_t100_message=>t100key OPTIONAL
        attr1                 TYPE string OPTIONAL
        attr2                 TYPE string OPTIONAL
        attr3                 TYPE string OPTIONAL
        attr4                 TYPE string OPTIONAL
        previous              LIKE previous OPTIONAL
        title                 TYPE char20 OPTIONAL
        description           TYPE zde_description OPTIONAL
        priority              TYPE zde_priority OPTIONAL
        status                TYPE zde_status OPTIONAL
        severity              TYPE if_abap_behv_message=>t_severity OPTIONAL.



    DATA:
      mv_attr1                 TYPE string,
      mv_attr2                 TYPE string,
      mv_attr3                 TYPE string,
      mv_attr4                 TYPE string,
      mv_title                 TYPE char20,
      mv_description           TYPE zde_description,
      mv_priority              TYPE zde_priority,
      mv_status                TYPE zde_status.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_incidentes_messages_vt IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(  previous = previous ) .

    me->mv_attr1                 = attr1.
    me->mv_attr2                 = attr2.
    me->mv_attr3                 = attr3.
    me->mv_attr4                 = attr4.
    me->mv_title                 = title.
    me->mv_description           = description.
    me->mv_priority              = priority.
    me->mv_status              = status.



    if_abap_behv_message~m_severity = severity.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
