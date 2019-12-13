HttpQueryString = require '../../http/query_string'

class AlphaVantageQueryTimeSeriesDaily
  _params = undefined

  constructor: (params) ->
    _params = params

  build: () ->
    return HttpQueryString.build(_params)

module.exports = AlphaVantageQueryTimeSeriesDaily
