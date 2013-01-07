class Reporter.Views.Modal.LargePhoto extends Reporter.Views.Modal.Base
  template: JST['modals/large_photo']
  modal: 'div.modal-container#large-photo'
  events:
    'click #large-photo .overlay': 'closeModal'
    'click #large-photo button.close': 'closeModal'

  render: (photo, alt) ->
    $(@el).append @template({photo: photo, alt: alt})
