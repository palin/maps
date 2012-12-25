class Reporter.Views.Home extends Backbone.View

  el: 'body.home_controller section'

  initialize: ->
    new Reporter.Views.Map()
    new Reporter.Views.Categories()
    # @modal = new Reporter.Views.Modal.UniversityInfo()
    # @modal.render()