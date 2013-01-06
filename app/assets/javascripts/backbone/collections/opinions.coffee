class Reporter.Collections.Opinions extends Reporter.Collections.Base
  model: Reporter.Models.Opinion
  url: ->
    "/api/reports/#{@id}/opinions/all"

  initialize: (id) ->
    @id = id

  parse: (json) ->
    json.opinions