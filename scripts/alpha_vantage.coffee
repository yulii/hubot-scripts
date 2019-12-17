# Description:
#   Get an equity price.
#
# Commands:
#   hubot stock <symbol> - Get the equity price of your choice

AlphaVantage = require '../lib/alpha_vantage'

module.exports = (robot) ->
  robot.respond /stock ([a-z_0-9^/]+)$/i, (msg) ->
    try
      new AlphaVantage(
        function: 'TIME_SERIES_DAILY',
        symbol: msg.match[1]
      ).execute(robot, (message) ->
        robot.logger.debug(message.toString())
        msg.send(message.format())
      )
    catch error
      msg.send "#{error.name}: #{error.message}"

  robot.respond /fx ([a-z0-9^]+\/[a-z0-9^]+)$/i, (msg) ->
    try
      new AlphaVantage(
        function: 'FX_DAILY',
        symbol: msg.match[1]
      ).execute(robot, (message) ->
        robot.logger.debug(message.toString())
        msg.send(message.format())
      )
    catch error
      msg.send "#{error.name}: #{error.message}"
