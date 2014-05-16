Meteor.publish "lingos", ->
  Lingos.find()

Meteor.publish "definitions", ->
  Definitions.find()
