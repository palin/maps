class Reporter.Collections.Reports extends Reporter.Collections.Base
  model: Reporter.Models.Report
  url: "api/reports/all"

  parse: (json) ->
    json.reports
