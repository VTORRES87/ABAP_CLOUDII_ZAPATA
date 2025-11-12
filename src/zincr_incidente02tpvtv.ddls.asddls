@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forIncidente'
@ObjectModel.sapObjectNodeType.name: 'ZINCIncidenteVTV'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAA', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ '_Extension' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define root view entity ZINCR_Incidente02TPVTV
  as select from ZDT_INCT_VT as Incidente
  association [1] to ZINCE_IncidenteVTV as _Extension on $projection.IncUUID = _Extension.IncUUID
  composition [0..*] of ZINCR_HistorialTPVTV as _Historial
{
  key INC_UUID as IncUUID,
  INCIDENT_ID as IncidentID,
  TITLE as Title,
  DESCRIPTION as Description,
  STATUS as Status,
  PRIORITY as Priority,
  CREATION_DATE as CreationDate,
  CHANGED_DATE as ChangedDate,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  _Historial,
  _Extension
}
