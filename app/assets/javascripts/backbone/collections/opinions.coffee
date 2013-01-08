class Reporter.Collections.Opinions extends Backbone.Collection
  model: Reporter.Models.Opinion
  url: ->
    "/api/reports/#{@id}/opinions/all"

  initialize: (id) ->
    @id = id

  parse: (json) ->
    json.opinions