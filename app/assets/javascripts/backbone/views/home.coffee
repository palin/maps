class Reporter.Views.Home extends Backbone.View

  el: 'body.home_controller section'

  initialize: ->
    @modal = new Reporter.Views.Modal.UniversityInfo()
    @modal.render()
