#= require_self
#= require hamlcoffee
#= require jquery
#= require jquery_ujs
#= require underscore
#= require backbone
#= require backbone_rails_sync
#= require backbone_datalink
#= require ./marionette
#= require_tree ./templates
#= require_tree ./components
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#= require_tree .

window.Reporter =
  Collections: {
    Border: {}
    Opinions: {}
    Reports: {}
  }
  Components: {
    Marker: {}
    Point: {}
  }
  Models: {
    Abuse: {}
    Opinion: {}
    Report: {}
  }
  Routers: {}
  Views: {
    Admin: {}
    Home: {}
    Modal: {
      Base: {}
      UniversityInfo: {}
      ReportInfo: {}
      LargePhoto: {}
      AbuseConfirmation: {}
    }
    Map: {}
    Categories: {}
  }
  currentView: null
  currentReport: null
  router: null

  apiRoot: (version=1)->
    "/v#{version}"

  showView: (view)->
    @currentView = view
    $('.content').append(@currentView.$el)
    @currentView.render()

  showInfoMessage: (content)->
    flash = $('body #flash.notice')
    flash.text(content)
    flash.slideToggle(500)
    setTimeout =>
      flash.slideToggle(500)
    , 2000

$ ->
  Reporter.router = new Reporter.Router()
  viewName = $('body').data('view-name')
  Reporter.currentView = new Reporter.Views[viewName] if Reporter.Views[viewName]?
  Backbone.history.start()

