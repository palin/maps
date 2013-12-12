class Reporter.Models.Category extends Backbone.Model
  urlRoot: ->
    Reporter.apiRoot() + "/categories"

  toJSON: ->
    category:
      id: @get('id')
      title: @get('title')
      description: @get('description')
      unique_id: @get('unique_id')
