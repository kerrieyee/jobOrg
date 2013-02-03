class JobOrg.Routers.JobProspects extends Backbone.Router

	routes: 
		'': 'index'

	initialize: ->
		@collection = new JobOrg.Collections.JobProspects()
		@collection.fetch()

	index: ->
		view = new JobOrg.Views.JobProspectsIndex(collection: @collection)
		$('#container').html(view.render().el)

	show: (id) ->
		alert("job_prospects #{id}")