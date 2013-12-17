class Reporter.Views.Category extends Marionette.ItemView
  template: (data)->
    JST["category"](data)
  tagName: 'li'
  className: 'category'
  events:
    'click': 'toggleMarkers'

  initialize: (options)->
    @mapView = options.mapView

  onRender: ->
    @addSimpleTip()

  addSimpleTip: ->
    @$el.simpletip
      content: @$("span.description").text()
      fixed: true
      showEffect: "fade"
      persistent: false

  toggleMarker: (category, value)->
    _.each @mapView.markers, (marker) =>
      marker.setMap(value) if marker.category == category

  toggleMarkers: (e) ->
    link = @$('a')
    category = link.data('category-id')
    @$("div.category-icon.#{category}").toggleClass("grey")
    if !link.hasClass('selected')
      @toggleMarker(category, null)
      link.addClass('selected')
    else
      @toggleMarker(category, @mapView.map)
      link.removeClass()
