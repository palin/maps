class Reporter.Views.Modal.ReportAbuse extends Marionette.ItemView
  template: JST['modals/report/abuse']
  events:
    'click a': 'reportAbuse'

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())

  reportAbuse: (e)->
    name = @$(e.currentTarget).data('type')
    abuse = new Reporter.Models.Abuse(report_id: @model.id, name: name)
    abuse.save null,
      success: =>
        @$el.slideUp(200, 'swing', =>@close())
