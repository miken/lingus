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
    data: ->
      Lingos.findOne @params._id

  @route "lingoEdit",
    path: "/lingos/:_id/edit"
    data: ->
      Lingos.findOne @params._id

  return

Router.onBeforeAction "loading"
Router.onBeforeAction ->
  clearErrors()
  return
