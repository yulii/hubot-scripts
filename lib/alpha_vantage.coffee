HttpQueryString = require './http/query_string'
AlphaVantageFactory      = require './alpha_vantage/factory'
AlphaVantageErrorMessage = require './alpha_vantage/error_message'
AlphaVantageSlackMessage = require './alpha_vantage/slack_message'

class AlphaVantage
  _endpoint = 'https://www.alphavantage.co/query'

  constructor: (args) ->
    @args = args
    _initialize.call @

  execute: (robot, callback) ->
    _factory = new AlphaVantageFactory(@args.function)
    _queryString = HttpQueryString.build(_factory.query(@args).params())

    robot.http("#{_endpoint}?#{_queryString}")
      .header('Content-Type', 'application/json')
      .header('Accept', 'application/json')
      .get() (error, response, body) ->
        result = JSON.parse(body)
        if result.hasOwnProperty('Error Message')
          callback(new AlphaVantageErrorMessage(result))
        else
          callback(new AlphaVantageSlackMessage(_factory.parse(result).outline()))

  _initialize = ->
    @args.apikey = process.env['ALPHA_VANTAGE_API_KEY']

module.exports = AlphaVantage
