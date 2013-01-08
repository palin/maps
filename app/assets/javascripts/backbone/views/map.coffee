class Reporter.Views.Map extends Backbone.View

  el: 'body section.content'
  events:
    'click section.right_sidebar #categories li.category': 'toggleMarker'

  initialize: ->
    mapOptions = {
      zoom: 11,
      center: new google.maps.LatLng(52.4063, 16.9251),
      mapTypeId: google.maps.MapTypeId.ROADMAP
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
        console.log "Wystąpił problem z pobraniem listy zgłoszeń."

  addMarkers: ->
    allMarkers = []
    mappy = @map
    marker = null
    modal = new Reporter.Views.Modal.ReportInfo()
    _.each @reports.models, (report) ->
      marker = new google.maps.Marker({
        map: mappy,
        draggable: false,
        animation: google.maps.Animation.DROP,
        position: new google.maps.LatLng(parseFloat(report.get('latitude')), parseFloat(report.get('longitude'))),
        icon: "assets/categories/#{report.get('category_unique_id')}_icon.png",
        category: report.get('category_unique_id')
      })
      allMarkers.push marker
      google.maps.event.addListener(marker, 'click', -> modal.render(report))
    @markers = allMarkers

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

  removeMarkers: (category) ->
    _.each @markers, (marker) ->
      if marker.category == category
        marker.setMap(null)

  showMarkers: (category) ->
    mappy = @map
    _.each @markers, (marker) ->
      if marker.category == category
        marker.setMap(mappy)

  toggleMarker: (e) ->
    link = $(e.currentTarget).find('a')
    category = link.data('category-id')
    if !link.hasClass('hidden')
      @removeMarkers(category)
      link.addClass('hidden')
    else
      @showMarkers(category)
      link.removeClass()
