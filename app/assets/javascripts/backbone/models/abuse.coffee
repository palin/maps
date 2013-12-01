class Reporter.Models.Abuse extends Backbone.Model
  urlRoot: ->
    Reporter.apiRoot(2) + "/reports/#{@get('report_id')}/abuses"

  toJSON: ->
    abuse:
      name: @get('name')
