class Reporter.Models.Report extends Backbone.Model

  initialize: (options)->
    @id = options.id

  url: ->
    @urlRoot()

  urlRoot: ->
    Reporter.apiRoot() + "/reports/#{@get('id')}"

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
