@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ayuda de busqueda status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.supportedCapabilities: [ #VALUE_HELP_PROVIDER ]
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'status'


define view entity ZDD_status_vh_vt as select from zdt_status_vhv
{
     key status,
         description
}

