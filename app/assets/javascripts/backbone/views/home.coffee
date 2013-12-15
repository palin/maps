class Reporter.Views.Home extends Backbone.View

  el: 'body.home_controller section'

  initialize: ->
    @mapView = new Reporter.Views.Map()
    @categories = new Reporter.Collections.Categories()
    @renderCategories(new Reporter.Views.Categories(collection: @categories, mapView: @mapView))
    @categories.fetch()

  renderCategories: (view)->
    @$('ul#categories').append(view.$el)
    view.render()
