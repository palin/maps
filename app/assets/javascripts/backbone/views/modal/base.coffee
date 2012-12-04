class Reporter.Views.Modal.Base extends Backbone.View

  el: 'body section.content'
  template: JST['modals/base']
  events: 'click button.close': 'closeModal'
  modal: 'div.modal-container'

  closeModal: ->
    $(@modal).fadeOut 300, =>
      $(@modal).remove()

  render: ->
     $(@el).append @template()
