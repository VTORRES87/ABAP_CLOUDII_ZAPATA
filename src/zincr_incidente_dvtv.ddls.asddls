@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Draft query view forIncidente'
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
define view entity ZINCR_Incidente_DVTV
  as select from ZINCINCIDE00DVTV as Incidente
{
  key IncUUID as IncUUID,
  IncidentID as IncidentID,
  Title as Title,
  Description as Description,
  Status as Status,
  Priority as Priority,
  CreationDate as CreationDate,
  ChangedDate as ChangedDate,
  LocalCreatedBy as LocalCreatedBy,
  LocalCreatedAt as LocalCreatedAt,
  LocalLastChangedBy as LocalLastChangedBy,
  LocalLastChangedAt as LocalLastChangedAt,
  LastChangedAt as LastChangedAt,
  draftentitycreationdatetime as Draftentitycreationdatetime,
  draftentitylastchangedatetime as Draftentitylastchangedatetime,
  draftadministrativedatauuid as Draftadministrativedatauuid,
  draftentityoperationcode as Draftentityoperationcode,
  hasactiveentity as Hasactiveentity,
  draftfieldchanges as Draftfieldchanges
}
