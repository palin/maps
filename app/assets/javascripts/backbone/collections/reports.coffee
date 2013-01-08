class Reporter.Collections.Reports extends Backbone.Collection
  model: Reporter.Models.Report
  url: "api/reports/all"

  parse: (json) ->
    json.reports
