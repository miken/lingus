Router.configure
  waitOn: ->
    [
      Meteor.subscribe("lingos")
      Meteor.subscribe("definitions")
    ]

Router.map ->
  @route "welcome",
    path: "/"
    layoutTemplate: "layout"
    loadingTemplate: "loading"

  @route "lingoPage",
    layoutTemplate: "layout"
    loadingTemplate: "loading"
    path: "/lingos/:_id"
    waitOn: ->
      Meteor.subscribe 'definitions', @params._id
    data: ->
      Lingos.findOne @params._id

  @route "lingoEdit",
    layoutTemplate: "layout"
    loadingTemplate: "loading"
    path: "/lingos/:_id/edit"
    data: ->
      Lingos.findOne @params._id

  @route "definitionEdit",
    layoutTemplate: "layout"
    loadingTemplate: "loading"
    path: "/definitions/:_id/edit"
    waitOn: ->
      Meteor.subscribe 'currentDefinition', @params._id
    data: ->
      Definitions.findOne @params._id

  @route "front",
    layoutTemplate: "front"
    loadingTemplate: "loading"
    path: "/front"


Router.onBeforeAction "loading"
Router.onBeforeAction ->
  clearErrors()
