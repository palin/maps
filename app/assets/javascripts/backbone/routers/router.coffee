class Reporter.Router extends Backbone.Router

  routes:
    "report/:id": "report"

  report: (id)->
    report = new Reporter.Models.Report(id: id)
    report.fetch
      success: (response)->
        Reporter.currentView = new Reporter.Views.Modal.ReportInfo(model: response)
        Reporter.currentView.render()
    Reporter.currentReport = report