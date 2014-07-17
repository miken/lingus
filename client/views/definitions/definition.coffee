@DEF_HEIGHT = 80
@Positions = new Meteor.Collection(null)

upsertNewPosition = (defId, newPosition)->
  Positions.upsert definitionId: defId,
    $set:
      position: newPosition

Template.definition.helpers
  exampleWithLineBreaks: (exampleStr) ->
    exampleStr.replace(/\n/g, '<br />')

  timeFromNow: (rawTime) ->
    moment(rawTime).fromNow()

  pos: ->
    def = Definitions.findOne @_id
    newPosition = @_rank * DEF_HEIGHT

    # upsertNewPosition(@_id, newPosition)
    # `Meteor.setTimeout(function() {
    #   upsertNewPosition(this._id, newPosition);
    # });`
    Meteor.setTimeout upsertNewPosition(@_id, newPosition)

    pos = Positions.findOne definitionId: @_id
    pos.position

  attributes: ->
    # This line probably has syntax errors
    # Need to check with Harley
    definition = _.extend({},
      Positions.findOne(definitionId: @_id),
      this
    )
    # For some reason definition._rank returns NaN
    # Use @_rank for now
    newPosition = @_rank * DEF_HEIGHT
    attributes = {}

    if not _.isUndefined(definition.position)
      offset = definition.position - newPosition
      attributes.style = "top: #{offset}px"
      if offset is 0
        attributes.class = "definition animate"

    Meteor.setTimeout ->
      Positions.upsert definitionId: @_id,
        $set:
          position: newPosition

    attributes

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

  'click .star': (e) ->
    e.preventDefault()

    starredKey = "starred_definition_" + @_id
    if not amplify.store(starredKey)
      amplify.store(starredKey, true)
      Meteor.call 'star', @_id

  'click .flag': (e) ->
    e.preventDefault()

    flaggedKey = "flagged_definition_" + @_id
    if not amplify.store(flaggedKey)
      amplify.store(flaggedKey, true)
      Meteor.call 'flag', @_id
      $(e.currentTarget).removeClass('text-muted').addClass('text-danger')