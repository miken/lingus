Template.definitionEdit.helpers
  lingo: ->
    Lingos.findOne @lingoId


Template.definitionEdit.events
  'submit form': (e) ->
    e.preventDefault()

    currentDefinitionId = @_id
    def = Definitions.findOne currentDefinitionId
    currentLingoId = def.lingoId

    $detail = $(e.target).find '[name=detail]'
    $example = $(e.target).find '[name=example]'

    definitionProperties =
      detail: $detail.val()
      example: $example.val()
      lingoId: currentLingoId

    Meteor.call "editDef", currentDefinitionId, definitionProperties, (error) ->
      if error
        throwError error.reason
      else
        Router.go "lingoPage",
          _id: currentLingoId