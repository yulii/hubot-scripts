class AlphaVantageFactory
  _factor = undefined

  constructor: (name) ->
    _factor = require("./#{name.toLowerCase()}")

  create: (object) ->
    return new _factor(object)

module.exports = AlphaVantageFactory
