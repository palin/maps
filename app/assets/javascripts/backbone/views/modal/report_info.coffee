class Reporter.Views.Modal.ReportInfo extends Reporter.Views.Modal.Base
  template: JST['modals/report_info']

  events:
    'click .rating-box a': 'onRate'
    'click button.close': 'closeModal'

  constructor: ->
    super

  url: (vote) ->
    "api/reports/rate_#{vote}"

  onRate: (e) ->
    return if $(e.currentTarget).attr("disabled") == 'disabled'
    e.preventDefault()
    response = @sendRequest(e)
    response.success(@onRateSuccess)
    response.error(@onRateFail)
    @disableRating()
    return false

  sendRequest: (e) ->
    $.post(@url($(e.currentTarget).data('vote')), {'report': e.currentTarget.id}, null, 'json')

  onRateSuccess: (response) =>
    @$('div#current_rating').text(response.rating)

  disableRating: ->
    _.each @$('div.rating-box a'), (link) ->
      $(link).attr("disabled", 'true')
      $(link).addClass('disabled')

  onRateFail: (response) =>
    #showTooltip
    alert(JSON.parse(response.responseText).reason.reason)

  canVote: (id)->
    url = "api/reports/can_vote"
    response = $.post(url, {'report': id}, null, 'json')
    response.error(@onVoteError)

  onVoteError: (response) =>
    @disableRating()