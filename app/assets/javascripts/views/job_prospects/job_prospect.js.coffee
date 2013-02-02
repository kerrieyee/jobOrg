class JobOrg.Views.JobProspect extends Backbone.View

  template: JST['job_prospects/job_prospect']
  tagName: 'tr'

  render: ->
  	$(@el).html(@template(job_prospect: @model))
  	this

  