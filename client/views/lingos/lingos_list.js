Template.lingosList.helpers({
  lingos: function() {
    return Lingos.find(
      {},
      {sort: ["name", "desc"]});
  }
});