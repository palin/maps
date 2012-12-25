class Reporter.Views.Categories extends Backbone.View

  el: 'ul#categories'
  events:
    'mouseenter li': 'onMouseEnterCategory'
    'mouseleave li': 'onMouseLeaveCategory'

  initialize: ->

  onMouseEnterCategory: (e) ->
    $(e.currentTarget).transition({ x: '-30px' })

  onMouseLeaveCategory: (e) ->
    $(e.currentTarget).transition({ x: '0px' })
