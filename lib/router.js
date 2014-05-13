Router.configure({
  layoutTemplate: 'layout',
  loadingTemplate: 'loading',
  waitOn: function() { return Meteor.subscribe('lingos');}
});

Router.map(function() {
  this.route('welcome', {path: '/'});

  this.route('lingoPage', {
    path: '/lingos/:_id',
    data: function() { return Lingos.findOne(this.params._id); }
  });
});

Router.onBeforeAction('loading');