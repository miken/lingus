//tests/lingos.js
var assert = require('assert');

suite('Lingos', function() {
  test('in the server', function(done, server) {
    server.eval(function() {
      Lingos.insert({name: 'very cool lingo'});
      var docs = Lingos.find().fetch();
      emit('docs', docs);
    });

    server.once('docs', function(docs) {
      assert.equal(docs.length, 1);
      done();
    });
  });

  test('using both client and the server', function(done, server, client) {
    server.eval(function() {
      // On the server side, observe for an event when a new lingo is added
      // Once observed, emit the event as 'lingo' to perform the next function
      // under server.once()
      Lingos.find().observe({
        added: addedNewLingo
      });

      function addedNewLingo(lingo) {
        emit('lingo', lingo);
      }
    });

    server.once('lingo', function(lingo) {
      assert.equal(lingo.name, 'very cool lingo');
      done();
    });

    client.eval(function() {
      Lingos.insert({name: 'very cool lingo'});
    });
  });

  test('using two clients', function(done, server, c1, c2) {
    c1.eval(function() {
      // On client 1, observe for an event when a new lingo is added
      // Once observed, emit two signals: 'lingo' and 'done'
      Lingos.find().observe({
        added: addedNewLingo
      });

      function addedNewLingo(lingo) {
        emit('lingo', lingo);
      }

      emit('done');
    });

    c1.once('lingo', function(lingo) {
      assert.equal(lingo.name, 'from c2');
      done();
    });

    c1.once('done', function() {
      c2.eval(insertLingo);
    });

    function insertLingo() {
      Lingos.insert({name: 'from c2'});
    }
  });

});