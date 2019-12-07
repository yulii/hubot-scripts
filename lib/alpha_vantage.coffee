QueryString = require './query_string'
AlphaVantageTimeSeriesDaily = require './alpha_vantage/time_series_daily'
AlphaVantageSlackMessage    = require './alpha_vantage/slack_message'

class AlphaVantage
  _endpoint = 'https://www.alphavantage.co/query'

  constructor: (args) ->
    @function = args.function
    @symbol   = args.symbol
    @token    = process.env['ALPHA_VANTAGE_API_KEY']

  endpoint: ->
    return _endpoint

  execute: (robot, callback) ->
    queryString = QueryString.build(apikey: @token, function: @function, symbol: @symbol)

    robot.http("#{@endpoint()}?#{queryString}")
      .header('Content-Type', 'application/json')
      .header('Accept', 'application/json')
      .get() (error, response, body) ->
        result = JSON.parse(body)
        if result.hasOwnProperty('Error Message')
          callback(attachments: [{ color: '#ff0000', title: 'Error Message', text: result['Error Message'] }])
        else
          outline = new AlphaVantageTimeSeriesDaily(result).outline()
          callback(new AlphaVantageSlackMessage(outline))


module.exports = AlphaVantage
