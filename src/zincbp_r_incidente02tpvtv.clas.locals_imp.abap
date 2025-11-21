CLASS LHC_INCIDENTE DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Incidente
        RESULT result,
      CALCULATEINCIDENTID FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  Incidente~CalculateIncidentID ,
      validateTitle FOR VALIDATE ON SAVE
            IMPORTING keys FOR Incidente~validateTitle,
      validateDescription FOR VALIDATE ON SAVE
            IMPORTING keys FOR Incidente~validateDescription.

          METHODS validatePriority FOR VALIDATE ON SAVE
            IMPORTING keys FOR Incidente~validatePriority.

          METHODS validateStatus FOR VALIDATE ON SAVE
            IMPORTING keys FOR Incidente~validateStatus.
          METHODS get_instance_features FOR INSTANCE FEATURES
            IMPORTING keys REQUEST requested_features FOR Incidente RESULT result.

          METHODS changestatus FOR MODIFY
            IMPORTING keys FOR ACTION Incidente~changestatus RESULT result.
ENDCLASS.

CLASS LHC_INCIDENTE IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CALCULATEINCIDENTID.
  READ ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
    ENTITY Incidente
      ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(entities).
  DELETE entities WHERE IncidentID IS NOT INITIAL.
  Check entities is not initial.
  "Dummy logic to determine object_id
  SELECT MAX( INCIDENT_ID ) FROM ZDT_INCT_VT INTO @DATA(max_object_id).
  "Add support for draft if used in modify
  "SELECT SINGLE FROM FROM ZINCINCIDE00DVTV FIELDS MAX( IncidentID ) INTO @DATA(max_orderid_draft). "draft table
  "if max_orderid_draft > max_object_id
  " max_object_id = max_orderid_draft.
  "ENDIF.
  MODIFY ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
    ENTITY Incidente
      UPDATE FIELDS ( IncidentID )
        WITH VALUE #( FOR entity IN entities INDEX INTO i (
        %tky          = entity-%tky
        IncidentID     = max_object_id + i
  ) ).
  ENDMETHOD.
  METHOD validateTitle.

    READ ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
      ENTITY Incidente
        FIELDS ( Title ) WITH CORRESPONDING #( keys )
      RESULT DATA(incidentes).

    LOOP AT Incidentes INTO DATA(Incidente).

      IF Incidente-title IS INITIAL.

        APPEND VALUE #( %tky = incidente-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = incidente-%tky
                        %msg = new zcl_incidentes_messages_vt( textid = zcl_incidentes_messages_vt=>title_unkown
                                                            title = incidente-Title
                                                            severity = if_abap_behv_message=>severity-error  )
                                                            %element-Title = if_abap_behv=>mk-on ) TO reported-incidente.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateDescription.

      READ ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
      ENTITY Incidente
        FIELDS ( Description ) WITH CORRESPONDING #( keys )
      RESULT DATA(incidentes).

    LOOP AT Incidentes INTO DATA(Incidente).

      IF Incidente-Description IS INITIAL.

        APPEND VALUE #( %tky = incidente-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = incidente-%tky
                        %msg = new zcl_incidentes_messages_vt( textid = zcl_incidentes_messages_vt=>description_unkown
                                                            description = incidente-Description
                                                            severity = if_abap_behv_message=>severity-error  )
                                                            %element-description = if_abap_behv=>mk-on ) TO reported-incidente.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validatePriority.


      READ ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
      ENTITY Incidente
        FIELDS ( Priority ) WITH CORRESPONDING #( keys )
      RESULT DATA(incidentes).

    LOOP AT Incidentes INTO DATA(Incidente).

      IF Incidente-Priority IS INITIAL.

        APPEND VALUE #( %tky = incidente-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = incidente-%tky
                        %msg = new zcl_incidentes_messages_vt( textid = zcl_incidentes_messages_vt=>Priority_unkown
                                                            Priority = incidente-Priority
                                                            severity = if_abap_behv_message=>severity-error  )
                                                            %element-Priority = if_abap_behv=>mk-on ) TO reported-incidente.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateStatus.

      READ ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
      ENTITY Incidente
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(incidentes).

    LOOP AT Incidentes INTO DATA(Incidente).

      IF Incidente-Status IS INITIAL.

        APPEND VALUE #( %tky = incidente-%tky ) TO failed-incidente.
        APPEND VALUE #( %tky = incidente-%tky
                        %msg = new zcl_incidentes_messages_vt( textid = zcl_incidentes_messages_vt=>status_unkown
                                                            status = incidente-Status
                                                            severity = if_abap_behv_message=>severity-error  )
                                                            %element-Status = if_abap_behv=>mk-on ) TO reported-incidente.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD changestatus.

  DATA incidente_for_status TYPE TABLE FOR UPDATE ZINCR_Incidente02TPVTV.

  READ ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE ENTITY Incidente
  FIELDS ( Status ) WITH CORRESPONDING #( keys )
  RESULT DATA(incidentes).

  LOOP AT incidentes ASSIGNING FIELD-SYMBOL(<fs_incidente>).

  DATA(statusn) = keys[ KEY id %tky = <fs_incidente>-%tky ]-%param-change_status.
    DATA(obs) = keys[ KEY id %tky = <fs_incidente>-%tky ]-%param-Observaciones.

  APPEND VALUE #( %tky = <fs_incidente>-%tky status = statusn ) TO incidente_for_status.

  ENDLOOP.

  MODIFY ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE ENTITY Incidente
  UPDATE FIELDS ( Status ) WITH incidente_for_status.


  ENDMETHOD.

ENDCLASS.
