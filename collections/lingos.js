Lingos = new Meteor.Collection('lingos');

Meteor.methods({
  post: function(lingoProperties) {
    var lingoAlreadyExists = Lingos.findOne({name: lingoProperties.name});

    // ensure the lingo has a name
    if (!lingoProperties.name)
      throw new Meteor.Error(422, 'Cannot add a blank lingo');

    // check that there are no duped lingos
    if (lingoProperties.name && lingoAlreadyExists) {
      throw new Meteor.Error(302, 'This lingo already exists', lingoAlreadyExists._id);
    }

    // pick out the whitelisted keys
    var lingo = _.extend(_.pick(lingoProperties, 'name'), {
      updated: new Date().getTime()
    });

    var lingoId = Lingos.insert(lingo);

    return lingoId;
  },

  update: function(currentLingoId, lingoProperties) {
    var lingoAlreadyExists = Lingos.findOne({name: lingoProperties.name});

    // ensure the lingo has a name
    if (!lingoProperties.name)
      throw new Meteor.Error(422, 'Cannot leave a lingo blank');

    // check that there are no duped lingos
    if (lingoProperties.name && lingoAlreadyExists) {
      throw new Meteor.Error(302, 'This lingo already exists', lingoAlreadyExists._id);
    }

    // pick out the whitelisted keys
    var lingo = _.extend(_.pick(lingoProperties, 'name'), {
      updated: new Date().getTime()
    });

    var lingoId = Lingos.update(lingo);

    return lingoId;

  }
});