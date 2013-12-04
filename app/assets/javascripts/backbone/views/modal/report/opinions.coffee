class Reporter.Views.Modal.ReportOpinions extends Marionette.CompositeView
  template: JST['modals/report/opinions']
  itemViewContainer: '.items'
  events:
    'submit form': 'submit'
  getItemView: ->
    Reporter.Views.Modal.ReportOpinion

  initialize: ->
    @collection.fetch(reset: true)

  serializeData: ->
    model: @model.attributes

  submit: (e)->
    e.preventDefault()
    title = @$('input[name=title]').val()
    description = @$('input[name=description]').val()
    opinion = new Reporter.Models.Opinion(report_id: @model.id, title: title, description: description)
    opinion.save null,
      success: =>
        @$('form')[0].reset()
