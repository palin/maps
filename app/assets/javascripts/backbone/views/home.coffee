class Reporter.Views.Home extends Backbone.View

  el: 'body.home_controller section'

  initialize: ->
    @mapView = new Reporter.Views.Map()
    @categoriesView = new Reporter.Views.Categories(mapView: @mapView)
    # new Reporter.Views.Modal.UniversityInfo().render()
