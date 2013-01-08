class Reporter.Views.Admin extends Backbone.View

  el: 'body section.content'

  initialize: ->
    if $('#flash') != undefined
      $('#flash').slideToggle(2500)
