class Reporter.Views.Modal.ReportSocial extends Marionette.ItemView
  template: JST['modals/report/social']

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())
