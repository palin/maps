class Reporter.Routers.Base extends Backbone.Router

  routes:
    '': 'home'
    '/reports/:id': 'report'
