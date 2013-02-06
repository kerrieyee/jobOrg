class JobOrg.Views.JobProspect extends Backbone.View

  template: JST['job_prospects/job_prospect']
  tagName: 'tr'
  id: 'id'

  events:
    'click input[value="Delete"]': 'removeJobProspect'
    'click input[value="Edit"]': 'editJobProspect'

  initialize: ->
    @model.on('destroy', @unrenderJobProspect, this)
    @model.on('save', @rerenderJobProspect, this)
    $(@el).attr('id', @model.get('id'))

  render: ->
    $(@el).html(@template(job_prospect: @model))
    this

  removeJobProspect: (event, job_prospect) ->
    event.preventDefault
    if confirm("Are you sure you want to delete this Job Prospect? It will erase all corresponding events.") then @model.destroy() 

  editJobProspect: (event, job_prospect) ->
    event.preventDefault()
    $('form#new_job_prospect').hide()
    $('form#edit_job_prospect').show()
    $('#edit_job_prospect_company').val(@model.get('company'))
    $('#edit_job_prospect_position').val(@model.get('position'))
    $('#edit_id').val(@model.get('id'))
  
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

  rerenderJobProspect: ->
    $(@el).html(@template(job_prospect: @model))
    this

  unrenderJobProspect: ->
    $(@el).remove()
    