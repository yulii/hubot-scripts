class AlphaVantageFactory
  _name   = undefined

  constructor: (name) ->
    _name = name.toLowerCase()

  query: (params) ->
    _query = require("./query/#{_name}")
    return new _query(params)

  parse: (object) ->
    _parser = require("./parser/#{_name}")
    return new _parser(object)

module.exports = AlphaVantageFactory
