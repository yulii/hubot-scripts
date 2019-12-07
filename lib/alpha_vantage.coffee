QueryString = require './query_string'
AlphaVantageTimeSeriesDaily = require './alpha_vantage/time_series_daily'

class AlphaVantage
  _endpoint = 'https://www.alphavantage.co/query'

  constructor: (args) ->
    @function = args.function
    @symbol   = args.symbol
    @token    = process.env['ALPHA_VANTAGE_API_KEY']

  endpoint: ->
    return _endpoint

  execute: (robot, callback) ->
    queryString = QueryString.build
                    apiKey: @token
                    function: @function
                    symbol: @symbol

    robot.http("#{@endpoint()}?#{queryString}")
      .header('Content-Type', 'application/json')
      .header('Accept', 'application/json')
      .get() (error, response, body) ->
        result = JSON.parse(body)
        if result.hasOwnProperty('Error Message')
          callback(error: result['Error Message'])
        else
          callback(new AlphaVantageTimeSeriesDaily(result).outline())


module.exports = AlphaVantage
