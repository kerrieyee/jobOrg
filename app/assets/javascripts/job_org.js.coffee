window.JobOrg =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
  	new JobOrg.Routers.JobProspects()
  	Backbone.history.start()

$(document).ready ->
  JobOrg.initialize()
