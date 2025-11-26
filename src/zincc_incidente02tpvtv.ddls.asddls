@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
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
@ObjectModel.semanticKey: [ 'IncidentID' ]
@Search.searchable: true
define root view entity ZINCC_Incidente02TPVTV
  provider contract transactional_query
  as projection on ZINCR_Incidente02TPVTV as Incidente
{
  key IncUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
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
  _Hist : redirected to composition child ZINCC_HistorialTPVTV
}
