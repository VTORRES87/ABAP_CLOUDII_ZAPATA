@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forHistorial'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAB', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ 'Hist' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
@ObjectModel.semanticKey: [ 'HisID' ]
@Search.searchable: true
define view entity ZINCC_HistorialTPVTV
  as projection on ZINCR_HistorialTPVTV as Hist
{
  key HisUUID,
  IncUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  HisID,
  PreviousStatus,
  NewStatus,
  Text,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangeDat,
  _Incidente : redirected to parent ZINCC_Incidente02TPVTV
}
