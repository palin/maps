#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Reporter =
  Models: {}
  Collections: {}
  Routers: {
    Base: {}
  }
  Views: {
    Home: {}
    Modal: {
      Base: {},
      UniversityInfo: {}
    }
  }
  currentView: null

  initCurrentView: ->
    if @currentView?
      @currentView.undelegateEvents()
      @currentView = null

    viewName = $("body").data("view_name")
    @currentView = new Reporter.Views[viewName]() if Reporter.Views[viewName]?

$ ->
  Reporter.initCurrentView()