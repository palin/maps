class Reporter.Router extends Backbone.Router

  routes:
    "reports/:id": "reports"

  reports: (id)->
    report = new Reporter.Models.Report(id: id)
    report.fetch
      success: (report)->
        Reporter.showView(new Reporter.Views.Modal.Report(model: report))
