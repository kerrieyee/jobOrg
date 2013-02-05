class JobOrg.Views.JobProspect extends Backbone.View

  template: JST['job_prospects/job_prospect']
  tagName: 'tr'

  events:
    'click input[value="Delete"]': 'removeJobProspect'
    'click input[value="Edit"]': 'editJobProspect'

  initialize: ->
    @model.on('destroy', @unrenderJobProspect, this)

  render: ->
    $(@el).html(@template(job_prospect: @model))
    this

  removeJobProspect: (event, job_prospect) ->
    event.preventDefault
    @model.destroy()


  unrenderJobProspect: ->
    $(@el).remove()
    