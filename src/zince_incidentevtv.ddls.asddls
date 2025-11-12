@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension include view forIncidente'
@AbapCatalog.viewEnhancementCategory: [ #PROJECTION_LIST ]
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAA', 
  allowNewDatasources: false, 
  allowNewCompositions: false, 
  dataSources: [ 'Incidente' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity ZINCE_IncidenteVTV
  as select from ZDT_INCT_VT as Incidente
{
  key INC_UUID as IncUUID
}
