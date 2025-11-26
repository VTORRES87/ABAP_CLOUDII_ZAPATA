@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ayuda de busqueda status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.supportedCapabilities: [ #VALUE_HELP_PROVIDER ]
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'status'
@VDM.viewType: #COMPOSITE
@Search.searchable: true


define view entity ZDD_status_vh_vt as select from zdt_status_vhv
{

     key status,
     
     @Search.defaultSearchElement: true
     @Search.fuzzinessThreshold: 0.8
     @Semantics.text:true
         description
}
