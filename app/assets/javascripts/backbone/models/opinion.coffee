class Reporter.Models.Opinion extends Backbone.Model
  urlRoot: ->
    Reporter.apiRoot(2) + "/reports/#{@get('report_id')}/opinions"

  toJSON: ->
    opinion:
      id: @get('id')
      title: @get('title')
      description: @get('description')
      key: @get('key')
