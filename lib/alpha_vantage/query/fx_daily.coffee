class AlphaVantageQueryFxDaily

  constructor: (params) ->
    @apikey      = params.apikey
    @function    = params.function
    @outputsize  = params.outputsize ? 'compact'
    @datatype    = params.datatype ? 'json'
    [@from_symbol, @to_symbol] = params.symbol.split('/')
    _assert.call @

  params: () ->
    return {
      apikey: @apikey
      function: @function
      from_symbol: @from_symbol
      to_symbol: @to_symbol
      outputsize: @outputsize
      datatype: @datatype
    }

  _assert = ->
    throw new Error('`apikey` is required argument')      unless @apikey?
    throw new Error('`function` is required argument')    unless @function?
    throw new Error('`from_symbol` is required argument') unless @from_symbol?
    throw new Error('`to_symbol` is required argument')   unless @to_symbol?

module.exports = AlphaVantageQueryFxDaily
