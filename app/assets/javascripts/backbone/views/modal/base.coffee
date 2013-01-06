class Reporter.Views.Modal.Base extends Backbone.View

  el: 'body section.content'
  template: JST['modals/base']
  events: 'click button.close': 'closeModal'
  modal: 'div.modal-container'
  context: @context

  closeModal: ->
    $(@modal).fadeOut 300, =>
      $(@modal).remove()

  render: (context) ->
    $(@el).append @template({context})