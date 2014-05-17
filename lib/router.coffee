Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  waitOn: ->
    [
      Meteor.subscribe("lingos")
      Meteor.subscribe("definitions")
    ]

Router.map ->
  @route "welcome",
    path: "/"

  @route "lingoPage",
    path: "/lingos/:_id"
    waitOn: ->
      Meteor.subscribe 'definitions', @params._id
    data: ->
      Lingos.findOne @params._id

  @route "lingoEdit",
    path: "/lingos/:_id/edit"
    data: ->
      Lingos.findOne @params._id

  @route "definitionEdit",
    path: "/definitions/:_id/edit"
    waitOn: ->
      Meteor.subscribe 'currentDefinition', @params._id
    data: ->
      Definitions.findOne @params._id


Router.onBeforeAction "loading"
Router.onBeforeAction ->
  clearErrors()
