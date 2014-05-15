Lingos = new Meteor.Collection('lingos');

Meteor.methods({
  post: function(lingoAttributes) {
    var lingoAlreadyExists = Lingos.findOne({name: lingoAttributes.name});

    // ensure the lingo has a name
    if (!lingoAttributes.name)
      throw new Meteor.Error(422, 'Please start typing before adding');

    // check that there are no duped lingos
    if (lingoAttributes.name && lingoAlreadyExists) {
      throw new Meteor.Error(302, 'This lingo already exists', lingoAlreadyExists._id);
    }

    // pick out the whitelisted keys
    var lingo = _.extend(_.pick(lingoAttributes, 'name'), {
      created: new Date().getTime()
    });

    var lingoId = Lingos.insert(lingo);

    return lingoId;
  }
});