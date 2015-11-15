# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot ping - Reply with pong
#   hubot echo <text> - Reply back with <text>
#   hubot time - Reply with current time
#   hubot die - End hubot process

module.exports = (robot) ->
  user = process.env.HUBOT_HATENA_USER
  url  = 'http://b.hatena.ne.jp/#{user}/'

  robot.respond /bookmark$/i, (msg) ->
    msg.send "PONG"

  robot.respond /TIME$/i, (msg) ->
    msg.send "Server time is: #{new Date()}"

