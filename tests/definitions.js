//tests/definitions.js
var assert = require('assert');

suite('Definitions', function() {
  var insertNewLingo = function() {
    Lingos.insert({name: 'original lingo'});
  };

  // Insert a new lingo now and retrieve the id
  newLingoId = insertNewLingo();

  var goodDefinition = {
    detail: "a definition for the original lingo",
    example: "a good example for the use of this lingo",
    lingoId: newLingoId
  };

  var insertNewDefinition = function() {
    Definitions.insert(goodDefinition);
  };

  
  test('in the server', function(done, server) {
    server.eval(function() {
      insertNewDefinition();
      var docs = Definitions.find().fetch();
      emit('docs', docs);
    });

    server.once('docs', function(docs) {
      assert.equal(docs.length, 1);
      done();
    });
  });

  test('using both client and the server', function(done, server, client) {
    server.eval(function() {
      // On the server side, observe for an event when a new definition is added
      // Once observed, emit the event as 'definition' to perform the next function
      // under server.once()
      Definitions.find().observe({
        added: addedNewDefinition
      });

      function addedNewDefinition(definition) {
        emit('definition', definition);
      }
    });

    server.once('definition', function(definition) {
      assert.equal(definition.detail, "a definition for the original lingo");
      assert.equal(definition.example, "a good example for the use of this lingo");
      done();
    });

    client.eval(function() {
      insertNewDefinition();
    });
  });

  test('using two clients', function(done, server, c1, c2) {
    c1.eval(function() {
      // On client 1, observe for an event when a new definition is added
      // Once observed, emit two signals: 'definition' and 'done'
      Definitions.find().observe({
        added: addedNewDefinition
      });

      function addedNewDefinition(definition) {
        emit('definition', definition);
      }

      emit('done');
    });

    c1.once('definition', function(definition) {
      assert.equal(definition.detail, "a definition for the original lingo");
      assert.equal(definition.example, "a good example for the use of this lingo");
      done();
    });

    c1.once('done', function() {
      c2.eval(insertNewDefinition);
    });
  });

});