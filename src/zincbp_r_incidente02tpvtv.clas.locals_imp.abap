CLASS LHC_INCIDENTE DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Incidente
        RESULT result,
      CALCULATEINCIDENTID FOR DETERMINE ON SAVE
        IMPORTING
          KEYS FOR  Incidente~CalculateIncidentID .
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
ENDCLASS.
