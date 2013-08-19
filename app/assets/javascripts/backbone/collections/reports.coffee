class Reporter.Collections.Reports extends Backbone.Collection

  model: Reporter.Models.Report

  url: ->
    Reporter.apiRoot() + "/reports"
