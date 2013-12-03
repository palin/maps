class Reporter.Views.Modal.LargePhoto extends Marionette.ItemView
  template: JST['modals/large_photo']
  modal: 'div.modal-container#large-photo'
  events:
    'click #large-photo .overlay': 'closeModal'
    'click #large-photo button.close': 'closeModal'

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())
