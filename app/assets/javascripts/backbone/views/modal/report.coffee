class Reporter.Views.Modal.Report extends Marionette.Layout

  id: "report"
  className: "modal-container"
  template: JST['modals/report']
  events:
    'click button.close': 'closeModal'
    'click .overlay': 'closeModal'
  regions:
    photoRegion: "#photo-region"
    ratingRegion: "#rating-region"
    abuseRegion: "#abuse-region"
    socialRegion: "#social-region"
    descriptionRegion: "#description-region"
    opinionsRegion: "#opinions-region"

  initialize: ->
    @opinions = new Reporter.Collections.Opinions(report_id: @model.id)
    @photoView = new Reporter.Views.Modal.ReportPhoto(model: @model)
    @ratingView = new Reporter.Views.Modal.ReportRating(model: @model)
    @abuseView = new Reporter.Views.Modal.ReportAbuse(model: @model)
    @socialView = new Reporter.Views.Modal.ReportSocial(model: @model)
    @descriptionView = new Reporter.Views.Modal.ReportDescription(model: @model)
    @opinionsView = new Reporter.Views.Modal.ReportOpinions(model: @model, collection: @opinions)

  onRender: ->
    @photoRegion.show(@photoView)
    @ratingRegion.show(@ratingView)
    @abuseRegion.show(@abuseView)
    @socialRegion.show(@socialView)
    @descriptionRegion.show(@descriptionView)
    @opinionsRegion.show(@opinionsView)

  closeModal: (e)->
    @close()
    Reporter.router.navigate("/")
