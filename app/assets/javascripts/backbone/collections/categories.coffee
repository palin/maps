class Reporter.Collections.Categories extends Backbone.Collection
  model: Reporter.Models.Category

  url: ->
    @urlRoot()

  urlRoot: ->
    Reporter.apiRoot() + "/categories"

  parse: (response)->
    response.categories
