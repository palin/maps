class Reporter.Views.Modal.UniversityInfo extends Reporter.Views.Modal.Base
  template: JST['modals/university_info']
  modal: 'div.modal-container#university-info'
  events:
    'click #university-info .overlay': 'closeModal'
    'click #university-info button.close': 'closeModal'
