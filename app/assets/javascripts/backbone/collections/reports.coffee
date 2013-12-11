class Reporter.Collections.Reports extends Backbone.Collection

  model: Reporter.Models.Report

  initialize: (options)->
    @map = options.map
    @markers = options.markers

  url: ->
    Reporter.apiRoot() + "/reports"

  parse: (response)->
    response.reports

  addMarkers: ->
    @fetch
      success: (reports)=>
        _.each reports.models, (report) =>
          @newMarker(report)
      error: =>
        console.log "Wystąpił problem z pobraniem listy zgłoszeń."

  newMarker: (report)->
    report.marker = new Reporter.Components.Marker(map: @map, report: report)
    @markers.push report.marker.googleMarker
