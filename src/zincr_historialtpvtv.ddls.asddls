@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forHistorial'
@ObjectModel.sapObjectNodeType.name: 'ZINCHistorialVTV'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAB', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ '_Extension' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity ZINCR_HistorialTPVTV
  as select from ZDT_INCT_H_VT as Hist
  association to parent ZINCR_Incidente02TPVTV as _Incidente on $projection.IncUUID = _Incidente.IncUUID
  association [1] to ZINCE_HistorialVTV as _Extension on $projection.HisUUID = _Extension.HisUUID
{
  key HIS_UUID as HisUUID,
  INC_UUID as IncUUID,
  HIS_ID as HisID,
  PREVIOUS_STATUS as PreviousStatus,
  NEW_STATUS as NewStatus,
  TEXT as Text,
  LOCAL_CREATED_BY as LocalCreatedBy,
  LOCAL_CREATED_AT as LocalCreatedAt,
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  LAST_CHANGE_DAT as LastChangeDat,
  _Incidente,
  _Extension
}
