@AccessControl.authorizationCheck: #CHECK
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
define view entity ZINCI_HistorialTPVTV
  as projection on ZINCR_HistorialTPVTV as Hist
{
  key HisUUID,
  IncUUID,
  HisID,
  PreviousStatus,
  NewStatus,
  Text,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangeDat,
  _Incidente : redirected to parent ZINCI_Incidente02TPVTV
}
