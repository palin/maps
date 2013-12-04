class Reporter.Views.Modal.ReportOpinion extends Marionette.ItemView
  template: JST['modals/report/opinion']
  className: 'opinion'

  serializeData: ->
    model: @model.attributes
