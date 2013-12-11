class Reporter.Views.Modal.ReportPhoto extends Marionette.Layout
  template: JST['modals/report/photo']
  events:
    'click a': 'largePhoto'

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())

  largePhoto: (e)->
    e.preventDefault()
    photo = new Reporter.Views.Modal.LargePhoto(model: @model)
    Reporter.showView(photo)
