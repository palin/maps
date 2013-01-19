class Reporter.Views.Categories extends Backbone.View

  el: 'ul#categories'
  events:
    'click li': 'onMouseClick'

  initialize: ->
    _.each $('ul#categories li'), (li) ->
      description = $(li).find("span.description").text()
      $(li).simpletip(
        content: description,
        fixed: true,
        showEffect: "fade",
        persistent: false
      )

  onMouseClick: (e) ->
    $(e.currentTarget).find('img').toggleClass("grey")
