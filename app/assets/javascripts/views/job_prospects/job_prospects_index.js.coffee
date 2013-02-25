class JobOrg.Views.JobProspectsIndex extends Backbone.View

  template: JST['job_prospects/index']

  events:
    'submit #new_job_prospect': 'createJobProspect'
    'click input[value="Update Job Prospect"]': 'updateJobProspect'


  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendJobProspect, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendJobProspect)
    this

  appendJobProspect: (job_prospect)=>
    view = new JobOrg.Views.JobProspect(model: job_prospect)
    @$('#jobprospects').prepend(view.render().el)

  createJobProspect: (event) ->
    event.preventDefault()
    attributes =
      company: $('#new_job_prospect_company').val()
      position: $('#new_job_prospect_position').val()
    @collection.create attributes,
      wait: true
      success: ->
        $('#new_job_prospect')[0].reset()
        $('.alert').hide()
        $('.alert-success').text "Your job prospect has been successfully created."
        $('.alert-success').show()
      error: @handleError
  
  updateJobProspect: (event, job_prospect) ->
    event.preventDefault()
    attributes =
      company: $('#edit_job_prospect_company').val()
      position: $('#edit_job_prospect_position').val()
    editJob = @collection.get($('#edit_id').val())
    editJob.set attributes
    editJob.save attributes,
      wait: true
      success: ->
        $('#edit_job_prospect')[0].reset()
        $('#edit_job_prospect').hide()
        $('#new_job_prospect').show()
        $('.alert').hide()
        $('.alert-success').text("Your job prospect has been successfully updated.").show()
        editJob.trigger("save")
      error: @handleError

  handleError: (job_prospect, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        for message in messages
          $('.alert').hide()
          $('.alert-error').text("#{attribute} #{message}.")
          $('.alert-error').show()