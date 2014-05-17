@Lingos = new Meteor.Collection("lingos")

Meteor.methods
  post: (lingoProperties) ->
    lingoAlreadyExists = Lingos.findOne(name: lingoProperties.name)
    
    # ensure the lingo has a name
    if not lingoProperties.name
      throw new Meteor.Error 422, "Cannot add a blank lingo"
    
    # check that there are no duped lingos
    if lingoProperties.name and lingoAlreadyExists
      throw new Meteor.Error 302, "This lingo already exists", lingoAlreadyExists._id
    
    # pick out the whitelisted keys
    lingo = _.extend(_.pick(lingoProperties, "name"),
      updated: new Date().getTime()
    )
    lingoId = Lingos.insert(lingo)
    lingoId

  update: (currentLingoId, lingoProperties) ->
    lingoAlreadyExists = Lingos.findOne(name: lingoProperties.name)
    
    # ensure the lingo has a name
    if lingoProperties.name
      throw new Meteor.Error 422, "Cannot leave a lingo blank"
    
    # check that there are no duped lingos
    if lingoProperties.name and lingoAlreadyExists
      throw new Meteor.Error 302, "This lingo already exists", lingoAlreadyExists._id
    
    # pick out the whitelisted keys
    lingoProperties = _.extend(_.pick(lingoProperties, "name"),
      updated: new Date().getTime()
    )
    updatedLingoCount = Lingos.update(currentLingoId,
      $set: lingoProperties
    )
    updatedLingoCount