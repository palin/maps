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
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#= require_tree .

window.Reporter =
  Models: {
    Opinion: {}
    Report: {}
  }
  Collections: {
    Reports: {}
    Opinions: {}
  }
  Routers: {}
  Templates: {}
  Views: {
    Admin: {}
    Home: {}
    Modal: {
      Base: {}
      UniversityInfo: {}
      ReportInfo: {}
      LargePhoto: {}
      ModerateConfirmation: {}
    }
    Map: {}
    Categories: {}
  }
  currentView: null
  currentReport: null
  router: null

  apiRoot: ->
    "/v1"

$ ->
  Reporter.router = new Reporter.Router()
  Reporter.currentView = new Reporter.Views.Home()
  Backbone.history.start()

