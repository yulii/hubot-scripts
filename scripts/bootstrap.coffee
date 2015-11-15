# Description:
#   Processes of starting up Hubot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None

module.exports = (robot) ->

  pid = setInterval ->
    return if typeof robot?.send isnt 'function'
    robot.send {}, "I'm ready."
    clearInterval pid
  , 1000
