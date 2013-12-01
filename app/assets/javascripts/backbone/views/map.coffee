class Reporter.Views.Map extends Backbone.View

  el: 'body section.content'
  map: null
  border: null
  markers: []

  initialize: ->
    @createMap()
    @drawBorder()
    @renderReports()

  createMap: ->
    @map = new google.maps.Map @$("#map_canvas")[0],
      zoom: 11
      center: new google.maps.LatLng(52.4063, 16.9251)
      mapTypeId: google.maps.MapTypeId.ROADMAP

  drawBorder: ->
    @border = new Reporter.Collections.Border(map: @map)
    @border.draw()

  renderReports: ->
    @reports = new Reporter.Collections.Reports(map: @map, markers: @markers)
    @reports.addMarkers()
