HttpQueryString = require './http/query_string'
AlphaVantageFactory      = require './alpha_vantage/factory'
AlphaVantageErrorMessage = require './alpha_vantage/error_message'
AlphaVantageSlackMessage = require './alpha_vantage/slack_message'

class AlphaVantage
  _factory  = undefined
  _args     = undefined
  _endpoint = 'https://www.alphavantage.co/query'

  constructor: (args) ->
    _args = args
    _initialize.call @

  execute: (robot, callback) ->
    robot.http("#{_endpoint}?#{_queryString()}")
      .header('Content-Type', 'application/json')
      .header('Accept', 'application/json')
      .get() (error, response, body) ->
        result = JSON.parse(body)
        if result.hasOwnProperty('Error Message')
          callback(new AlphaVantageErrorMessage(result))
        else
          callback(new AlphaVantageSlackMessage(_factory.parse(result).outline()))

  _initialize = ->
    _args.apikey = process.env['ALPHA_VANTAGE_API_KEY']
    _factory     = new AlphaVantageFactory(_args.function)

  _queryString = ->
    return HttpQueryString.build(_factory.query(_args).params())


module.exports = AlphaVantage
