CLASS LHC_INCIDENTE DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.

  PUBLIC SECTION.

    CONSTANTS: BEGIN OF mc_status,
                 open        TYPE zde_status2_lgl VALUE 'OP',
                 in_progress TYPE zde_status2_lgl VALUE 'IP',
                 pending     TYPE zde_status2_lgl VALUE 'PE',
                 completed   TYPE zde_status2_lgl VALUE 'CO',
                 closed      TYPE zde_status2_lgl VALUE 'CL',
                 canceled    TYPE zde_status2_lgl VALUE 'CN',
               END OF mc_status.

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
          METHODS setHistory FOR MODIFY
            IMPORTING keys FOR ACTION Incidente~setHistory.

          METHODS setdefaulValues FOR DETERMINE ON MODIFY
            IMPORTING keys FOR Incidente~setdefaulValues.

          METHODS setdefaulHistory FOR DETERMINE ON SAVE
            IMPORTING keys FOR Incidente~setdefaulHistory
            .
          METHODS get_history
            EXPORTING
              value(ev_incuuid) TYPE any
            RETURNING
              value(rv_index)   TYPE zde_his_id_vtv.
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

    DATA lv_history_index TYPE zde_his_id_vtv.


    READ ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
       ENTITY Incidente
         FIELDS ( Status )
         WITH CORRESPONDING #( keys )
       RESULT DATA(incidentes)
       FAILED failed.

** Disable changeStatus for Incidents Creation
    DATA(lv_create_action) = lines( incidentes ).
    IF lv_create_action EQ 1.
      lv_history_index = get_history( IMPORTING ev_incuuid = incidentes[ 1 ]-IncUUID ).
    ELSE.
      lv_history_index = 1.
    ENDIF.



    result = VALUE #( FOR incidente IN incidentes
                          ( %tky                   = incidente-%tky
                            %action-ChangeStatus   = COND #( WHEN incidente-Status = mc_status-completed OR
                                                                  incidente-Status = mc_status-closed    OR
                                                                  incidente-Status = mc_status-canceled  OR
                                                                  lv_history_index = 0
                                                             THEN if_abap_behv=>fc-o-disabled
                                                             ELSE if_abap_behv=>fc-o-enabled )

*                            %assoc-_Hist      = COND #( WHEN incidente-Status = mc_status-completed OR
*                                                                 incidente-Status = mc_status-closed    OR
*                                                                 incidente-Status = mc_status-canceled  OR
*                                                                 lv_history_index = 0
*                                                            THEN if_abap_behv=>fc-o-disabled
*                                                            ELSE if_abap_behv=>fc-o-enabled )
                          ) ).


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

  METHOD setHistory.

*   DATA: lt_updated_root_entity  TYPE TABLE FOR UPDATE ZINCI_Incidente02TPVTV,
*          lt_association_entity  TYPE TABLE FOR CREATE ZINCI_Incidente02TPVTV\_Hist,
*          lv_exception           TYPE string,
*          ls_incident_history    TYPE ZDT_INCT_H_VT,
*          lv_max_his_id          TYPE zde_his_id_vtv.
*
*
*    READ ENTITIES OF ZINCR_Incidente02TPVTV  IN LOCAL MODE
*         ENTITY Incidente
*         ALL FIELDS WITH CORRESPONDING #( keys )
*         RESULT DATA(incidentes).
*
*    LOOP AT incidentes ASSIGNING FIELD-SYMBOL(<incident>).
*      lv_max_his_id = get_history( IMPORTING ev_incuuid = <incident>-IncUUID ).
*
*      IF lv_max_his_id IS INITIAL.
*        ls_incident_history-his_id = 1.
*      ELSE.
*        ls_incident_history-his_id = lv_max_his_id + 1.
*      ENDIF.
*
*      TRY.
*          ls_incident_history-inc_uuid = cl_system_uuid=>create_uuid_x16_static( ).
*        CATCH cx_uuid_error INTO DATA(lo_error).
*          lv_exception = lo_error->get_text(  ).
*      ENDTRY.
*
*      IF ls_incident_history-his_id IS NOT INITIAL.
*        APPEND VALUE #( %tky = <incident>-%tky
*                        %target = VALUE #( (  HisUUID = ls_incident_history-inc_uuid
*                                              IncUUID = <incident>-IncUUID
*                                              HisID = ls_incident_history-his_id
*                                              NewStatus = <incident>-Status
*                                              Text = | Creación - { <incident>-Description }| ) )
*                                               ) TO lt_association_entity.
*      ENDIF.
*    ENDLOOP.
*    UNASSIGN <incident>.
*
*    FREE incidentes.
*
*    MODIFY ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
*     ENTITY Incidente
*     CREATE BY \_Hist FIELDS ( HisUUID
*                                  IncUUID
*                                  HisID
*                                  PreviousStatus
*                                  NewStatus
*                                  Text )
*        AUTO FILL CID
*        WITH lt_association_entity.

  ENDMETHOD.

  METHOD setdefaulValues.


* Read root entity entries
    READ ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
     ENTITY Incidente
     FIELDS ( CreationDate
              Status ) WITH CORRESPONDING #( keys )
     RESULT DATA(incidentes).

** This important for logic
    DELETE incidentes WHERE CreationDate IS NOT INITIAL.

    CHECK incidentes IS NOT INITIAL.

** Get Last index from Incidents
    SELECT FROM zdt_inct_alg
      FIELDS MAX( incident_id ) AS max_inct_id
      WHERE incident_id IS NOT NULL
      INTO @DATA(lv_max_inct_id).

    IF lv_max_inct_id IS INITIAL.
      lv_max_inct_id = 1.
    ELSE.
      lv_max_inct_id += 1.
    ENDIF.

** Modify status in Root Entity
    MODIFY ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
      ENTITY Incidente
      UPDATE
      FIELDS ( IncidentID
               CreationDate
               Status )
      WITH VALUE #(  FOR incidente IN incidentes ( %tky = incidente-%tky
                                                 IncidentID = lv_max_inct_id
                                                 CreationDate = cl_abap_context_info=>get_system_date( )
                                                 Status       = mc_status-open )  ).

  ENDMETHOD.

  METHOD setdefaulHistory.

      MODIFY ENTITIES OF ZINCR_Incidente02TPVTV IN LOCAL MODE
    ENTITY Incidente
    EXECUTE setHistory
       FROM CORRESPONDING #( keys ).

  ENDMETHOD.


  METHOD get_history.
** Fill history data
    SELECT FROM ZDT_INCT_H_VT
      FIELDS MAX( his_id ) AS max_his_id
      WHERE inc_uuid EQ @ev_incuuid AND
            his_uuid IS NOT NULL
      INTO @rv_index.
  ENDMETHOD.

ENDCLASS.
