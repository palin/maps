class Reporter.Models.Report extends Backbone.Model

  initialize: (options)->
    @id = options.id

  url: ->
    @urlRoot()

  urlRoot: ->
    Reporter.apiRoot() + "/reports/#{@id}"

  rateUp: ->
    @save { positives: @get('positives')+1 },
      reset: true

  rateDown: ->
    @save { negatives: @get('negatives')+1 },
      reset: true