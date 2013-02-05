class JobOrg.Views.JobProspectsIndex extends Backbone.View

  template: JST['job_prospects/index']

  events:
    'submit #new_job_prospect': 'createJobProspect'

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
      
      