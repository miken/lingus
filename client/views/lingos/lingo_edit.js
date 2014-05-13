Template.lingoEdit.events({
  'submit form': function(e) {
    e.preventDefault();

    var currentLingoId = this._id;

    var lingoProperties = {
      name: $(e.target).find('[name=name]').val()
    };

    Lingos.update(
      currentLingoId,
      {$set: lingoProperties},
      function(error) {
        if (error) {
          // display the error to the user
          alert(error.reason);
        } else {
          Router.go('lingoPage', {_id: currentLingoId});
        }
      });
  },

  'click .delete': function(e) {
    e.preventDefault();

    if (confirm("Delete this lingo?")) {
      var currentLingoId = this._id;
      Lingos.remove(currentLingoId);
      Router.go('welcome');
    }
  }
});