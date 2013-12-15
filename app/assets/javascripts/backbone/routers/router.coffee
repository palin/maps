class Reporter.Router extends Backbone.Router

  routes:
    "reports/:id": "reports"
    "": "home"

  reports: (id)->
    report = new Reporter.Models.Report(id: id)
    report.fetch
      success: (report)->
        Reporter.showView(new Reporter.Views.Modal.Report(model: report))

  home: ->
    Reporter.showView(new Reporter.Views.Modal.UniversityInfo())
