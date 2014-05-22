@Definitions = new Meteor.Collection("definitions")

validateDef = (definitionProperties) ->
  lingo = Lingos.findOne definitionProperties.lingoId

  # ensure the definition must be tagged to a lingo
  if not lingo
    throw new Meteor.Error 422, "Lingo not found"

  # ensure the definition has some detail
  if not definitionProperties.detail
    throw new Meteor.Error 422, "Cannot add a blank definition"

Meteor.methods
  define: (newDefinition) ->
    definitionAlreadyExists = Definitions.findOne(detail: newDefinition.detail)
    
    validateDef(newDefinition)

    # check that there are no duped definitions
    if newDefinition.detail and definitionAlreadyExists
      throw new Meteor.Error 302, "This definition already exists", definitionAlreadyExists._id
    
    # pick out the whitelisted keys
    definition = _.extend(_.pick(newDefinition, "lingoId", "detail", "example"),
      updated: new Date().getTime()
      starCount: 0
    )

    Definitions.insert(definition)


  editDef: (currentDefinitionId, definitionProperties) ->  
    validateDef(definitionProperties)
    
    # pick out the whitelisted keys
    definitionProperties = _.extend(_.pick(definitionProperties, "lingoId", "detail", "example"),
      updated: new Date().getTime()
    )

    Definitions.update(currentDefinitionId,
      $set: definitionProperties
    )

  star: (definitionId) ->
    # Add validation for whether current user
    # has already starred this definition later

    Definitions.update(definitionId,
      $inc:
        starCount: 1
    )


