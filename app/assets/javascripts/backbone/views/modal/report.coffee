class Reporter.Views.Modal.Report extends Reporter.Views.Modal.Base

  template: JST['modals/report']
  modal: 'div.modal-container#report'
  regions:
    photoRegion: "#photo-region"
    ratingRegion: "#rating-region"
    abuseRegion: "#abuse-region"
    socialRegion: "#social-region"
    descriptionRegion: "#description-region"
    opinionsRegion: "#opinions-region"

  initialize: ->
    @photoView = new Reporter.Views.Modal.ReportPhoto(model: @model)
    @ratingView = new Reporter.Views.Modal.ReportRating(model: @model)
    @abuseView = new Reporter.Views.Modal.ReportAbuse(model: @model)
    @socialView = new Reporter.Views.Modal.ReportSocial(model: @model)
    @descriptionView = new Reporter.Views.Modal.ReportDescription(model: @model)
    @opinionsView = new Reporter.Views.Modal.ReportOpinions(model: @model)

  onRender: ->
    @photoRegion.show(@photoView)
    @ratingRegion.show(@ratingView)
    @abuseRegion.show(@abuseView)
    @socialRegion.show(@socialView)
    @descriptionRegion.show(@descriptionView)
    @opinionsRegion.show(@opinionsView)

  closeModal: ->
    super
    Reporter.router.navigate("/")
