class Reporter.Views.Admin extends Backbone.View

  el: 'body section.content'

  initialize: ->
    $('#flash').slideToggle(2500) if $('#flash') != undefined
