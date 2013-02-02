class JobOrg.Routers.JobProspects extends Backbone.Router

	routes: 
		'': 'index'
		'job_prospects/:id' : 'show'

	initialize: ->
		@collection = new JobOrg.Collections.JobProspects()
		@collection.fetch()

	index: ->
		view = new JobOrg.Views.JobProspectsIndex(collection: @collection)
		$('#container').html(view.render().el)

	show: (id) ->
		alert("job_prospects #{id}")