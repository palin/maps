class Reporter.Views.Modal.ModerateConfirmation extends Reporter.Views.Modal.Base
  template: JST['modals/moderate_confirmation']
  modal: 'div.modal-container#moderate-confirmation'
  events:
    'click #moderate-confirmation .overlay': 'closeModal'
    'click #moderate-confirmation button.close': 'closeModal'
