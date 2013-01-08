class Reporter.Views.Categories extends Backbone.View

  el: 'ul#categories'
  events:
    'click li': 'onMouseClick'

  onMouseClick: (e) ->
    $(e.currentTarget).find('img').toggleClass("grey")
    $(e.currentTarget).find('a').transition({x: '0px'})