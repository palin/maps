class Reporter.Models.Report extends Backbone.Model

  initialize: (options)->
    @id = options.id

  url: ->
    @urlRoot()

  urlRoot: ->
    Reporter.apiRoot(2) + "/reports/#{@get('id')}"

  rateUp: ->
    @save { positives: @get('positives')+1 },
      reset: true

  rateDown: ->
    @save { negatives: @get('negatives')+1 },
      reset: true

  toJSON: ->
    report:
      id: @get('id')
      key: @get('key')

  uniqueId: ->
    @get('category').unique_id

  latitude: ->
    parseFloat(@get('latitude'))

  longitude: ->
    parseFloat(@get('longitude'))
