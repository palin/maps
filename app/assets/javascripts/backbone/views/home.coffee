class Reporter.Views.Home extends Backbone.View

  el: 'body.home_controller section'

  initialize: ->
    new Reporter.Views.Map()
    new Reporter.Views.Categories()
    new Reporter.Views.Modal.UniversityInfo().render()
