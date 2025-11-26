@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forIncidente'
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAA', 
  allowNewDatasources: false, 
  allowNewCompositions: true, 
  dataSources: [ 'Incidente' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define root view entity ZINCI_Incidente02TPVTV
  provider contract transactional_interface
  as projection on ZINCR_Incidente02TPVTV as Incidente
{
  key IncUUID,
  IncidentID,
  Title,
  Description,
  Status,
  Priority,
  CreationDate,
  ChangedDate,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  _Hist : redirected to composition child ZINCI_HistorialTPVTV
}
