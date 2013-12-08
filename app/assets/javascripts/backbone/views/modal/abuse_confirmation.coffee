class Reporter.Views.Modal.AbuseConfirmation extends Marionette.ItemView
  template: JST['modals/abuse_confirmation']
  modal: 'div.modal-container#abuse-confirmation'
  events:
    'click #abuse-confirmation .overlay': 'closeModal'
    'click #abuse-confirmation button.close': 'closeModal'

  render: ->
    $(@el).append @template(@serializeData())

  closeModal: (e)=>
    @$el.fadeOut 300, =>
      @close()
