class Reporter.Models.Abuse extends Backbone.Model
  urlRoot: ->
    Reporter.apiRoot() + "/reports/#{@get('report_id')}/abuses"

  toJSON: ->
    abuse:
      name: @get('name')
