Router.configure({
  layoutTemplate: 'layout'
});

Router.map(function() {
  this.route('welcome', {path: '/'});

  this.route('lingoPage', {
    path: '/lingos/:_id',
    data: function() { return Lingos.findOne(this.params._id); }
  });
});