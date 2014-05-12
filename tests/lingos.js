//tests/lingos.js
var assert = require('assert');

suite('Lingos', function() {
  test('in the server', function(done, server) {
    server.eval(function() {
      Lingos.insert({title: 'hello title'});
      var docs = Lingos.find().fetch();
      emit('docs', docs);
    });

    server.once('docs', function(docs) {
      assert.equal(docs.length, 1);
      done();
    });
  });
});