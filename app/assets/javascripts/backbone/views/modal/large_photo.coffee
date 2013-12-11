class Reporter.Views.Modal.LargePhoto extends Marionette.Layout
  template: JST['modals/large_photo']
  id: "large-photo"
  className: "modal-container"
  events:
    'click .overlay': 'closeModal'
    'click button.close': 'closeModal'

  serializeData: ->
    model: @model.attributes

  render: ->
    $(@el).append @template(@serializeData())

  closeModal: (e)=>
    @$el.fadeOut 300, =>
      @close()
