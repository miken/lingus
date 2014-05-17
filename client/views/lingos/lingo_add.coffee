Template.lingoAdd.events
  'submit form': (e) ->
    e.preventDefault()
    
    $name = $(e.target).find("[name=name]")
    
    lingo =
      name: $name.val()

    Meteor.call "post", lingo, (error, id) ->
      if error
        # display the error to the user
        throwError error.reason

        if error.error is 302
          Router.go "lingoPage",
            _id: error.details

      else
        # Leave blank in the name field
        $name.val('')
        Router.go "lingoPage",
          _id: id
