Template.lingosList.helpers
  lingos: ->
    Lingos.find {},
      sort:
        ["name", "desc"]