@EndUserText.label: 'Change Status'
define abstract entity z_ae_changestatus_VTV
 // with parameters parameter_name : parameter_type
{
    @EndUserText.label: 'Status'
    @Consumption.valueHelpDefinition: [{
    entity.name: 'zdd_status_vh_vt',
    entity.element: 'status',
    useForValidation: true  }]
    change_status: zde_status;
    @EndUserText.label: 'Observaciones'
    Observaciones: zde_description;
}
