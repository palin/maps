class Reporter.Views.Map extends Backbone.View

  el: 'body section.content #map_canvas'

  initialize: ->
    mapOptions = {
      zoom: 11,
      center: new google.maps.LatLng(52.4063, 16.9251),
      mapTypeId: google.maps.MapTypeId.HYBRID
    }

    @map = new google.maps.Map($("#map_canvas")[0], mapOptions)
    @renderReports()
    @drawBorder()

  renderReports: ->
    @reports = new Reporter.Collections.Reports()
    @reports.fetch
      success: =>
        @addMarkers()
      error: =>
        console.log "error while fetching reports"

  addMarkers: ->
    mappy = @map
    @marker = null
    modal = new Reporter.Views.Modal.ReportInfo()
    _.each @reports.models, (report) ->
      @marker = new google.maps.Marker({
        map: mappy,
        draggable: false,
        animation: google.maps.Animation.DROP,
        position: new google.maps.LatLng(parseFloat(report.get('latitude')), parseFloat(report.get('longitude')))
        #icon: report.category_image
      })
      google.maps.event.addListener(@marker, 'click', -> modal.canVote(report.id); modal.render(report))

  drawBorder: ->
    url = "api/maps/border"
    response = $.get(url, null, @prepareBorder, 'json')

  prepareBorder: (response) =>
    border_coords = []

    _.each response.border, (coords) ->
      border_coords.push new google.maps.LatLng(coords[0], coords[1])

    border = new google.maps.Polygon({
      paths: border_coords,
      strokeColor: "#fff",
      strokeOpacity: 0.3,
      strokeWeight: 12,
      fillColor: "#FF4400",
      fillOpacity: 0.0
    })
    border.setMap(@map)

    border = new google.maps.Polygon({
      paths: border_coords,
      strokeColor: "#1563C2",
      strokeOpacity: 0.7,
      strokeWeight: 5,
      fillColor: "#FF4400",
      fillOpacity: 0.0
    })
    border.setMap(@map)
