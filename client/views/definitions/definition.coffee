Template.definition.helpers
  exampleWithLineBreaks: (exampleStr) ->
    exampleStr.replace(/\n/g, '<br />')

Template.definition.events
  'click .delete': (e) ->
    e.preventDefault()

    currentDefinitionId = @_id
    def = Definitions.findOne currentDefinitionId
    currentLingoId = def.lingoId

    if confirm "Delete this definition?"
      Definitions.remove currentDefinitionId
      Router.go "lingoPage",
        _id: currentLingoId  