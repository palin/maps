class Reporter.Collections.Border extends Backbone.Collection
  model: Reporter.Components.Point

  initialize: (options)->
    @map = options.map

  url: ->
    @urlRoot()

  urlRoot: ->
    Reporter.apiRoot(2) + "/maps/border"

  parse: (response)->
    response

  draw: ->
    @fetch
      success: (border)=>
        border_coords = []

        _.each border.models, (point) ->
          point = point.attributes
          border_coords.push new google.maps.LatLng(point[0], point[1])

        border = new google.maps.Polygon
          paths: border_coords
          strokeColor: "#fff"
          strokeOpacity: 0.3
          strokeWeight: 12
          fillColor: "#FF4400"
          fillOpacity: 0.0

        border.setMap(@map)

        border = new google.maps.Polygon
          paths: border_coords
          strokeColor: "#1563C2"
          strokeOpacity: 0.7
          strokeWeight: 5
          fillColor: "#FF4400"
          fillOpacity: 0.0

        border.setMap(@map)
