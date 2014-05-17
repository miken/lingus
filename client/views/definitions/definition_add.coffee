Template.definitionAdd.events
  'submit form': (e, template) ->
    e.preventDefault()

    $detail = $(e.target).find '[name=detail]'
    $example = $(e.target).find '[name=example]'

    newDefinition =
      detail: $detail.val()
      example: $example.val()
      lingoId: template.data._id

    Meteor.call "define", newDefinition, (error, definitionId) ->
      if error
        throwError error.reason
      else
        $detail.val('')
        $example.val('')