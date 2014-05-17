@Definitions = new Meteor.Collection("definitions")

Meteor.methods
  define: (newDefinition) ->
    definitionAlreadyExists = Definitions.findOne(detail: newDefinition.detail)
    lingo = Lingos.findOne(newDefinition.lingoId)
    
    # ensure the definition has some detail
    if not newDefinition.detail
      throw new Meteor.Error 422, "Cannot add a blank definition"
    
    # ensure the definition must be tagged to a lingo
    if not lingo
      throw new Meteor.Error 422, "You must define a lingo"

    # check that there are no duped definitions
    if newDefinition.detail and definitionAlreadyExists
      throw new Meteor.Error 302, "This definition already exists", definitionAlreadyExists._id
    
    # pick out the whitelisted keys
    definition = _.extend(_.pick(newDefinition, "lingoId", "detail", "example"),
      updated: new Date().getTime()
      starCount: 0
    )
    definitionId = Definitions.insert(definition)
    definitionId

  editDef: (currentDefinitionId, definitionProperties) ->
    definitionAlreadyExists = Definitions.findOne(detail: definitionProperties.detail)
    lingo = Lingos.findOne(definitionProperties.lingoId)
    
    # ensure the definition has some detail
    if not definitionProperties.detail
      throw new Meteor.Error 422, "Cannot add a blank definition"
    
    # ensure the definition must be tagged to a lingo
    if not lingo
      throw new Meteor.Error 422, "You must define a lingo"
    
    # pick out the whitelisted keys
    definition = _.extend(_.pick(definitionProperties, "lingoId", "detail", "example"),
      updated: new Date().getTime()
    )
    updatedDefCount = Definitions.update(currentDefinitionId,
      $set: definitionProperties
    )
    updatedDefCount