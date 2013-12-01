class Reporter.Collections.Opinions extends Backbone.Collection
  model: Reporter.Models.Opinion

  url: ->
    Reporter.api_root(2) + "/reports/#{@get('report_id')}/opinions"

  parse: (json) ->
    json.opinions
