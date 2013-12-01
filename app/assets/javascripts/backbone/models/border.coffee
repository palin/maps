class Reporter.Models.Border extends Backbone.Model
  urlRoot: ->
    Reporter.apiRoot() + "/maps/border"

  parse: (response)->
    response
