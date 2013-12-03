class Reporter.Views.Modal.Base extends Marionette.ItemView

  id: "report"
  className: "modal-container"
  template: JST['modals/base']
  events: 'click button.close': 'closeModal'
  modal: 'div.modal-container'
  context: @context

  closeModal: ->
    $(@modal).fadeOut 300, =>
      $(@modal).remove()

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())
