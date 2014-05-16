Template.lingoEdit.events
  'submit form': (e) ->
    e.preventDefault()
    
    currentLingoId = @_id
    
    lingoProperties =
      name: $(e.target).find('[name=name]').val()

    Meteor.call "update", currentLingoId, lingoProperties, (error) ->
      if error
        throwError error.reason
      else
        Router.go "lingoPage",
          _id: currentLingoId

  'click .delete': (e) ->
    e.preventDefault()

    if confirm "Delete this lingo?"
      currentLingoId = @_id
      Lingos.remove currentLingoId
      Router.go "welcome"