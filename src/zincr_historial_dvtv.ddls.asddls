@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Draft query view forHistorial'
@AbapCatalog.viewEnhancementCategory: [ #PROJECTION_LIST ]
@AbapCatalog.extensibility: {
  extensible: true, 
  elementSuffix: 'ZAB', 
  allowNewDatasources: false, 
  allowNewCompositions: false, 
  dataSources: [ 'Hist' ], 
  quota: {
    maximumFields: 100 , 
    maximumBytes: 10000 
  }
}
define view entity ZINCR_Historial_DVTV
  as select from ZINCHISTOR00DVTV as Hist
{
  key HisUUID as HisUUID,
  IncUUID as IncUUID,
  HisID as HisID,
  PreviousStatus as PreviousStatus,
  NewStatus as NewStatus,
  Text as Text,
  LocalCreatedBy as LocalCreatedBy,
  LocalCreatedAt as LocalCreatedAt,
  LocalLastChangedBy as LocalLastChangedBy,
  LocalLastChangedAt as LocalLastChangedAt,
  LastChangeDat as LastChangeDat,
  draftentitycreationdatetime as Draftentitycreationdatetime,
  draftentitylastchangedatetime as Draftentitylastchangedatetime,
  draftadministrativedatauuid as Draftadministrativedatauuid,
  draftentityoperationcode as Draftentityoperationcode,
  hasactiveentity as Hasactiveentity,
  draftfieldchanges as Draftfieldchanges
}
