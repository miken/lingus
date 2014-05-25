@Lingos = new Meteor.Collection("lingos")

validateLingo = (lingoProperties) ->
  # ensure the lingo has a name
  unless lingoProperties.name
    throw new Meteor.Error 422, "Cannot add a blank lingo"

  lingoAlreadyExists = Lingos.findOne(name: lingoProperties.name)

  # check that there are no duped lingos
  if lingoAlreadyExists
    throw new Meteor.Error 302, "This lingo already exists", lingoAlreadyExists._id

  # pick out the whitelisted keys
  lingo = _.extend(_.pick(lingoProperties, "name"),
    updated: new Date().getTime()
  )

Meteor.methods
  post: (lingoProperties) ->
    lingo = validateLingo(lingoProperties)
    # insert lingo and return created record
    Lingos.insert(lingo)

  update: (currentLingoId, lingoProperties) ->
    validateLingo(lingoProperties)
    # update and return # of affected records
    Lingos.update(currentLingoId, $set: lingoProperties)
