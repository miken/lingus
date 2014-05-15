Template.lingoAdd.events({
  'submit form': function(e) {
    e.preventDefault();

    var lingo = {
      name: $(e.target).find('[name=name]').val()
    };

    Meteor.call('post', lingo, function(error, id) {
      if (error) {
        // display the error to the user
        throwError(error.reason);

        if (error.error === 302)
          Router.go('lingoPage', {_id: error.details});
      } else {
        Router.go('lingoPage', {_id: id});
      }
    });
  }
});