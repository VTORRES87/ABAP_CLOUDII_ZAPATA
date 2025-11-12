@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Extension include view forHistorial'
@AbapCatalog.viewEnhancementCategory: [ #PROJECTION_LIST ]
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAB', 
  allowNewDatasources: false, 
  allowNewCompositions: false, 
  dataSources: [ 'Historial' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity ZINCE_HistorialVTV
  as select from ZDT_INCT_H_VT as Historial
{
  key HIS_UUID as HisUUID
}
