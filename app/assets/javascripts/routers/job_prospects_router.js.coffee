class JobOrg.Routers.JobProspects extends Backbone.Router

  routes: 
    '': 'index'
  
  initialize: ->
    @collection = new JobOrg.Collections.JobProspects()
    @collection.fetch()
    @collection.comparator = (item) ->
      item.get("last_updated")

  index: ->
    view = new JobOrg.Views.JobProspectsIndex(collection: @collection)
    $('#container').html(view.render().el)
