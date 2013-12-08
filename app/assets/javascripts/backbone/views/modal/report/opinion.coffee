class Reporter.Views.Modal.ReportOpinion extends Marionette.ItemView
  template: JST['modals/report/opinion']
  className: 'opinion'
  events:
    'click button': 'rateOpinion'

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())

  rateOpinion: (e)->
    @model.save key: @$(e.currentTarget).data('key'),
      success: =>
        @$el.empty()
        @render()
