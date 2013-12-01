class Reporter.Views.Modal.ReportPhoto extends Marionette.ItemView
  template: JST['modals/report/photo']

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())
