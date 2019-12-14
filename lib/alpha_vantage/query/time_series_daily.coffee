HttpQueryString = require '../../http/query_string'

class AlphaVantageQueryTimeSeriesDaily

  constructor: (params) ->
    @apikey     = params.apikey
    @function   = params.function
    @symbol     = params.symbol
    @outputsize = params.outputsize ? 'compact'
    @datatype   = params.datatype ? 'json'
    _assert.call @

  params: () ->
    return {
            apikey: @apikey
            function: @function
            symbol: @symbol
            outputsize: @outputsize
            datatype: @datatype
          }

  _assert = ->
    throw new Error('`apikey` is required argument')   unless @apikey?
    throw new Error('`function` is required argument') unless @function?
    throw new Error('`symbol` is required argument')   unless @symbol?

module.exports = AlphaVantageQueryTimeSeriesDaily
