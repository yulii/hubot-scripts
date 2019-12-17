class AlphaVantageFactory

  constructor: (name) ->
    @name = name.toLowerCase()

  query: (params) ->
    _query = require("./query/#{@name}")
    return new _query(params)

  parse: (object) ->
    _parser = require("./parser/#{@name}")
    return new _parser(object)

module.exports = AlphaVantageFactory
