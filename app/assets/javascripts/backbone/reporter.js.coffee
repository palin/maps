#= require_self
#= require hamlcoffee
#= require jquery
#= require jquery_ujs
#= require jquery.transit
#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#= require_tree .

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
    Map: {}
    Categories: {}
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
