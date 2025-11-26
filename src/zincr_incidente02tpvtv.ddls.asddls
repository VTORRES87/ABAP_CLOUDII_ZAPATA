@AccessControl.authorizationCheck: #NOT_ALLOWED
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
  as select from zdt_inct_vt as Incidente
 association [1] to ZINCE_IncidenteVTV as _Extension on $projection.IncUUID = _Extension.IncUUID
  composition [0..*] of ZINCR_HistorialTPVTV as _Hist
{
  key inc_uuid as IncUUID,
  incident_id as IncidentID,
  title as Title,
  description as Description,
  status as Status,
  priority as Priority,
  creation_date as CreationDate,
  changed_date as ChangedDate,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  _Hist,
  _Extension
}
