class Reporter.Views.Modal.ReportDescription extends Marionette.ItemView
  template: JST['modals/report/description']

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())
