class Reporter.Views.Modal.LargePhoto extends Reporter.Views.Modal.Base
  template: JST['modals/large_photo']
  modal: 'div.modal-container#large-photo'

  render: (photo, alt) ->
    $(@el).append @template({photo: photo, alt: alt})
