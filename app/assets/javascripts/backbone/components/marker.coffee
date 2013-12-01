class Reporter.Components.Marker extends Backbone.Model

  initialize: (options)->
    map = options.map
    report = options.report
    @googleMarker = new google.maps.Marker
      map: map
      draggable: false
      animation: google.maps.Animation.DROP
      position: new google.maps.LatLng(report.latitude(), report.longitude())
      icon: "assets/categories/#{report.get('category').unique_id}_icon.png"
      category: report.get('category').unique_id
    google.maps.event.addListener @googleMarker, 'click', =>
      Reporter.router.navigate("reports/#{report.id}", { trigger: true })
