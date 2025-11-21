@EndUserText.label: 'Change Status'
define abstract entity z_ae_changestatus_VTV
 // with parameters parameter_name : parameter_type
{
    @EndUserText.label: 'Satus'
    @Consumption.valueHelpDefinition: [{
    entity.name: 'zdt_status_vhv',
    entity.element: 'StatusCode',
    useForValidation: true  }]
    change_status: zde_status;
    @EndUserText.label: 'Observaciones'
    Observaciones: zde_description;
}
