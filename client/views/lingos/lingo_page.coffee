Template.lingoPage.helpers
  definitionsWithRank: ->
    definitions = Definitions.find lingoId: @_id,
      sort: [
        ["starCount", "desc"]
        ["detail", "asc"]
      ]

    definitions.rewind()

    definitions.map (definition, index, cursor) ->
      definition._rank = index
      definition
      