class Reporter.Views.Modal.ModerateConfirmation extends Marionette.ItemView
  template: JST['modals/moderate_confirmation']
  modal: 'div.modal-container#moderate-confirmation'
  events:
    'click #moderate-confirmation .overlay': 'closeModal'
    'click #moderate-confirmation button.close': 'closeModal'


  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())
