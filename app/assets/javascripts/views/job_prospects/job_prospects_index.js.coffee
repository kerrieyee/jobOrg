class JobOrg.Views.JobProspectsIndex extends Backbone.View

  template: JST['job_prospects/index']

  events:
    'submit #new_job_prospect': 'createJobProspect'
  	# 'click input[value="Edit"]': 'updateJobProspect'
  	# 'submit #delete_job_prospect': 'deleteJobProspect'
  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendJobProspect, this)
  	# @collection.on('change', @editJobPropsect, this)
  	# @collection.on('delete', @removeJobProspect, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendJobProspect)
    this

  appendJobProspect: (job_prospect)=>
    view = new JobOrg.Views.JobProspect(model: job_prospect)
    @$('#jobprospects').append(view.render().el)

  # editJobProspect: (job_prospect)->
  # 	alert('job prospect has changed')
  # 	view = new JobOrg.Views.JobPropsect(model: job_prospect)
  # 	$('#jobprospects').replaceWith(view.render().el)

  createJobProspect: (event) ->
    event.preventDefault()
    attributes =
      company: $('#new_job_prospect_company').val()
      position: $('#new_job_prospect_position').val()
    @collection.create attributes,
      wait: true
      success: ->
        $('#new_job_prospect')[0].reset()
        $('.alert-success').text "Your job prospect has been successfully created."
        $('.alert-error').hide()
        $('.alert-success').show()
        $('.alert-warning').hide()
        $('.alert-notice').hide()
      error: @handleError

  handleError: (job_prospect, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        for message in messages
          $('.alert-error').text("#{attribute} #{message}.")
          $('.alert-error').show()
          $('.alert-success').hide()
          $('.alert-warning').hide()
          $('.alert-notice').hide()
		
  updateJobProspect: (event, job_prospect) ->
    event.preventDefault()
    $('form#new_job_prospect').hide()
    $('form#edit_job_prospect').show()
    attributes =
      company: $('#new_job_prospect_company').val()
      position: $('#new_job_prospect_position').val()
    @collection.update job_prospect.attributes,
      wait: true
      success: -> $('#new_job_prospect')[0].reset()
      error: @handleError

      
      