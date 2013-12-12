class Reporter.Views.Categories extends Marionette.CollectionView
  template: JST["templates/categories"]
  getItemView: -> Reporter.Views.Category
  itemViewOptions: => { mapView: @options.mapView }
  itemViewContainer: '.items'
