Template.lingoPage.helpers
  definitions: ->
    Definitions.find lingoId: @_id,
      sort: [
        ["starCount", "desc"]
        ["detail", "asc"]
      ]
      