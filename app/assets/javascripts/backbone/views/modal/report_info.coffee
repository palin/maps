class Reporter.Views.Modal.ReportInfo extends Marionette.Layout

  template: JST['modals/report_info']
  modal: 'div.modal-container#report-info'
  events:
    'click .rating-box .rate.down': 'onRateNegative'
    'click .rating-box .rate.up': 'onRatePositive'
    'click #report-info button.close': 'closeModal'
    'click #report-info .overlay': 'closeModal'
    'submit .new_opinion form': 'onOpinionSubmit'
    'click .image-box a': 'onEnlargeImage'
    'click .rating-opinion a': 'onRateOpinion'
    'click .moderate-box ul li a': 'onModerate'

  initialize: ->
    @report = @model

  serializeData: ->
    report: @report.attributes

  closeModal: ->
    super
    Reporter.router.navigate("/")

  url: (vote, id) ->
    "v1/reports/#{id}/rate_#{vote}"

  onRateNegative: (e) ->
    e.preventDefault()
    return if $(e.currentTarget).attr("disabled") == 'disabled'
    @model.rateDown()
    return false

  onRatePositive: (e) ->
    console.log "onRatePositive"
    e.preventDefault()
    return if $(e.currentTarget).attr("disabled") == 'disabled'
    console.log "come on"
    @model.rateUp()

  sendRequest: (e) ->
    $.post(@url($(e.currentTarget).data('vote'), e.currentTarget.id), null, null, 'json')

  onRateSuccess: (response) =>
    @$('div#current_rating').text(response.rating)

  disableRating: ->
    _.each $('div.rating-box a'), (link) ->
      $(link).attr("disabled", 'true')
      $(link).addClass('disabled')

  canVote: (id) ->
    url = "v1/reports/#{id}/can_vote"
    response = $.post(url, null, null, 'json')
    response.error(@disableRating)

  render: ->
    $("html meta[property='og:title']")[0].content = "Zgłoszenie- #{@report.get('title')}"
    $("html meta[property='og:url']")[0].content = "http://reporter-maps.herokuapp.com/#/report/#{@report.id}"
    $("html meta[property='og:image']")[0].content = @report.get('photo').small
    $(@el).append @template()

  onOpinionSubmit: (e) ->
    e.preventDefault()
    url = e.currentTarget.action
    response = $.post(url, title: e.currentTarget[0].value, description: e.currentTarget[1].value, null, 'json')
    response.success(@updateOpinions)

  updateOpinions: (response) =>
    @$(".opinions").hide().prepend(JST['new_opinion']({opinion: response.new_opinion})).fadeIn('slow')
    @$('.new_opinion form input[type=submit]').attr('disabled', 'true')
    _.each @$('.new_opinion form input[type=text]'), (input) ->
      $(input).val("")
      $(input).attr("disabled", 'true')

  onEnlargeImage: (e) ->
    e.preventDefault()
    photo = new Reporter.Views.Modal.LargePhoto()
    photo.render(e.currentTarget.href, e.currentTarget.alt)

  onRateOpinion: (e) ->
    return if $(e.currentTarget).attr("disabled") == 'disabled'
    e.preventDefault()

    report_id = $(e.currentTarget).data('report-id')
    opinion_id = e.currentTarget.id
    vote = $(e.currentTarget).data('vote')

    url = "/api/reports/#{report_id}/opinions/#{opinion_id}/rate_#{vote}"
    response = $.post(url, null, @onRateOpinionSuccess, 'json')
    return false

  onRateOpinionSuccess: (response) =>
    id = parseInt(response.rating.id)
    @updateRatedOpinion(response.rating.rating, id)
    @disableOpinionRating(id)

  disableOpinionRating: (id) ->
    _.each $('div.rating-opinion a'), (link) ->
      if parseInt(link.id) == id
        $(link).attr('disabled', 'true')
        $(link).addClass('disabled')

  onCheckVoteOpinions: (response) =>
    _.each response.opinions, (op) ->
      _.each $('div.rating-opinion a'), (link) ->
        if parseInt(link.id) == parseInt(op)
          $(link).attr('disabled', 'true')
          $(link).addClass('disabled')

  canVoteOpinions: (report_id) ->
    url = "v1/reports/#{report_id}/opinions/can_vote"
    response = $.get(url, null, @onCheckVoteOpinions, 'json')

  updateRatedOpinion: (rating, id) ->
    _.each $('#current_opinion_rating span.rating'), (link) ->
      if parseInt($(link).data('opinion-id')) == id
        $(link).text(rating)

  onModerate: (e) ->
    e.preventDefault()
    url = e.currentTarget.href
    response = $.post(url, null, @onModerateSuccess, 'json')

  onModerateSuccess: (response) =>
    modal = new Reporter.Views.Modal.ModerateConfirmation()
    modal.render(response.thanks)
    $('.moderate-box').fadeOut('slow')
    $('.moderate-box').css('height', '0px')
