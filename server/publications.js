Meteor.publish('lingos', function() {
  return Lingos.find();
});