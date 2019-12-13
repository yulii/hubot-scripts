HttpQueryString = require './http/query_string'
AlphaVantageFactory      = require './alpha_vantage/factory'
AlphaVantageErrorMessage = require './alpha_vantage/error_message'
AlphaVantageSlackMessage = require './alpha_vantage/slack_message'

class AlphaVantage
  _factory  = undefined
  _function = undefined
  _symbol   = undefined
  _token    = undefined
  _endpoint = 'https://www.alphavantage.co/query'

  constructor: (args) ->
    _function = args.function
    _symbol   = args.symbol
    _initialize.call @

  endpoint: ->
    return _endpoint

  execute: (robot, callback) ->
    queryString = HttpQueryString.build(apikey: _token, function: _function, symbol: _symbol)

    robot.http("#{@endpoint()}?#{queryString}")
      .header('Content-Type', 'application/json')
      .header('Accept', 'application/json')
      .get() (error, response, body) ->
        result = JSON.parse(body)
        if result.hasOwnProperty('Error Message')
          callback(new AlphaVantageErrorMessage(result))
        else
          callback(new AlphaVantageSlackMessage(_factory.parse(result).outline()))

  _initialize = ->
    _factory = new AlphaVantageFactory(_function)
    _token   = process.env['ALPHA_VANTAGE_API_KEY']

module.exports = AlphaVantage
