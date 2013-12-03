class Reporter.Views.Modal.ReportOpinions extends Marionette.ItemView
  template: JST['modals/report/opinions']
  events:
    'submit form': 'submit'

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())

  submit: (e)->
    e.preventDefault()
    title = @$('input[name=title]').val()
    description = @$('input[name=description]').val()
    opinion = new Reporter.Models.Opinion(report_id: @model.id, title: title, description: description)
    opinion.save null,
      success: =>
        @$('form')[0].reset()
