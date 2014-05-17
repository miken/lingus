Meteor.publish "lingos", ->
  Lingos.find()

Meteor.publish "definitions", (lingoId) ->
  Definitions.find {lingoId: lingoId}

Meteor.publish "currentDefinition", (definitionId) ->
  Definitions.find {_id: definitionId}