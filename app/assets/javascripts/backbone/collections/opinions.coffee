class Reporter.Collections.Opinions extends Backbone.Collection
  model: Reporter.Models.Opinion
  url: ->
    "/v1/reports/#{@id}/opinions/all"

  initialize: (id) ->
    @id = id

  parse: (json) ->
    json.opinions