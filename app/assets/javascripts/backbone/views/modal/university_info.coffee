class Reporter.Views.Modal.UniversityInfo extends Marionette.Layout
  template: JST['modals/university_info']
  id: 'university-info'
  className: 'modal-container'
  events:
    'click .overlay': 'closeModal'
    'click button.close': 'closeModal'

  closeModal: (e)=>
    @$el.fadeOut 300, =>
      @close()
