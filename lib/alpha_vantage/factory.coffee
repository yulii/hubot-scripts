class AlphaVantageFactory
  _name   = undefined

  constructor: (name) ->
    _name = name.toLowerCase()

  parse: (object) ->
    _parser = require("./parser/#{_name}")
    return new _parser(object)

module.exports = AlphaVantageFactory
