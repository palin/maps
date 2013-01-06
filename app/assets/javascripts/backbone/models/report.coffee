class Reporter.Models.Report extends Backbone.Model

  parse: (response) ->
    response
  # url_rate_up: (id) ->
  #   "api/reports/#{id}/rate_up"

  # url_rate_down: (id) ->
  #   "api/reports/#{id}/rate_down"

  # url_can_vote: (id) ->
  #   "api/reports/#{id}/can_vote"

  # rate_up: ->
  #   response = $.post(@url_rate_up(@id), null, null, 'json')

  # rate_down: ->
  #   response = $.post(@url_rate_down(@id), null, null, 'json')

  # can_vote: ->
  #   response = $.post(@url_can_vote(@id), null, null, 'json')

  # getOpinions: ->
  #   @opinions = new Reporter.Collections.Opinions(@id)
