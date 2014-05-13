Template.lingoAdd.events({
  'submit form': function(e) {
    e.preventDefault();

    var lingo = {
      name: $(e.target).find('[name=name]').val()
    };

    lingo._id = Lingos.insert(lingo);
    Router.go('lingoPage', lingo);
  }
});