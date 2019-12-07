# Description:
#   Get an equity price.
#
# Commands:
#   hubot stock <symbol> - Get the equity price of your choice

AlphaVantage = require '../lib/alpha_vantage'

module.exports = (robot) ->
  robot.respond /stock ([a-z_0-9^]+)$/i, (msg) ->
    try
      new AlphaVantage(
        function: 'TIME_SERIES_DAILY',
        symbol: msg.match[1]
      ).execute(robot, (data) ->
        if data.hasOwnProperty('error')
          msg.send(attachments: [{ color: '#ff0000', title: 'Error Message', text: data.error }])
        else
          attachments = []
          for c in data.compare
            attachments.push(
              color: (c.diff > 0 ? '#155724' : (c.diff < 0 ? '#721c24' : '#383d41')),
              text: "#{c.diff} (#{c.ratio}%) at #{new Date(c.timestamp)}"
            )

          msg.send(
            text: "*#{data.price}* #{new Date(data.timestamp)}",
            attachments: attachments,
            mrkdwn: true
          )
      )
    catch error
      msg.send "#{error.name}: #{error.message}"
