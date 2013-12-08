class Reporter.Views.Modal.ReportOpinions extends Marionette.CompositeView
  template: JST['modals/report/opinions']
  itemViewContainer: '.items'
  events:
    'submit form': 'submit'
  getItemView: ->
    Reporter.Views.Modal.ReportOpinion

  initialize: ->
    @opinion = new Reporter.Models.Opinion(report_id: @model.id)
    @collection.fetch(reset: true)

  serializeData: ->
    model: @model.attributes

  submit: (e)->
    e.preventDefault()
    title = @$('input[name=title]').val()
    description = @$('input[name=description]').val()
    @opinion.save { title: title, description: description },
      success: =>
        @$('form')[0].reset()
        @$('input').attr('disabled', true)
        Reporter.showInfoMessage("Dziekujemy za opinie!")
        @collection.fetch(reset: true)
