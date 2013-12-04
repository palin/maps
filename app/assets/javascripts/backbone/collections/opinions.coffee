class Reporter.Collections.Opinions extends Backbone.Collection
  model: Reporter.Models.Opinion

  initialize: (options)->
    @report_id = options.report_id

  url: ->
    Reporter.apiRoot(2) + "/reports/#{@report_id}/opinions"

  parse: (json) ->
    json.opinions
