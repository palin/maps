class Reporter.Views.Categories extends Backbone.View

  el: 'ul#categories'
  events:
    'click li': 'onMouseClick'
    'mouseenter li': 'onMouseEnter'

  onMouseClick: (e) ->
    $(e.currentTarget).find('img').toggleClass("grey")

  onMouseEnter: (e) ->
    li = $(e.currentTarget)
    description = li.find("span.description").text()

    li.simpletip(
      content: description,
      fixed: true,
      showEffect: "fade",
      persistent: false
    )
