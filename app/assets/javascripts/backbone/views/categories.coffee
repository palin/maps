class Reporter.Views.Categories extends Backbone.View

  el: 'ul#categories'
  events:
    'click li': 'toggleMarkers'

  initialize: (options)->
    @mapView = options.mapView
    @simpleTips()

  simpleTips: ->
    _.each @$('ul#categories li'), (li) ->
      description = @$(li).find("span.description").text()
      @$(li).simpletip(
        content: description,
        fixed: true,
        showEffect: "fade",
        persistent: false
      )

  toggleMarker: (category, value)->
    _.each @mapView.markers, (marker) =>
      if marker.category == category
        marker.setMap(value)

  toggleMarkers: (e) ->
    @$(e.currentTarget).find('img').toggleClass("grey")
    link = @$(e.currentTarget).find('a')
    category = link.data('category-id')
    if !link.hasClass('selected')
      @toggleMarker(category, null)
      link.addClass('selected')
    else
      @toggleMarker(category, @mapView.map)
      link.removeClass()
