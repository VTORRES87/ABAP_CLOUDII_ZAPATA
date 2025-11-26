@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ayuda de busqueda priority'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.supportedCapabilities: [ #VALUE_HELP_PROVIDER ]
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'priority'
define view entity Zdd_priority_vh_vt as select from zdt_priority_vhv
{

 key priority,
 
   @Search.defaultSearchElement: true
   @Search.fuzzinessThreshold: 0.8
     @Semantics.text:true
  description
     
}
