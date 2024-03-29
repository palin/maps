class Reporter.Views.Modal.ReportRating extends Marionette.ItemView
  template: JST['modals/report/rating']
  events:
    'click button.rate': 'rateReport'

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())

  rateReport: (e)->
    @model.save key: @$(e.currentTarget).data('key'),
      success: =>
        @$el.empty()
        @render()
