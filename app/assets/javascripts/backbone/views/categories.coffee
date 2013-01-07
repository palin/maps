class Reporter.Views.Categories extends Backbone.View

  el: 'ul#categories'
  events:
    'click li': 'onMouseClick'
    'mouseenter li': 'onMouseEnter'
    'mouseleave li': 'onMouseLeave'

  onMouseClick: (e) ->
    $(e.currentTarget).find('img').toggleClass("grey")
    $(e.currentTarget).find('a').transition({x: '0px'})

  onMouseEnter: (e) ->
    unless $(e.currentTarget).find('img').hasClass('grey')
      $(e.currentTarget).find('a').transition({ x: '-30px' })

  onMouseLeave: (e) ->
    $(e.currentTarget).find('a').transition({x: '0px'})