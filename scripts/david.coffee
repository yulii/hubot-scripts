# Description:
#   Tells you when your package npm dependencies are out of date via David.
#
# Commands:
#   hubot david - List outdated Dependencies

module.exports = (robot) ->

  robot.respond /david$/i, (msg) ->
    @child_process = require('child_process')
    @child_process.exec 'david', (error, stdout, stderr) ->
      msg.send "```#{error}```"  if error?  && error.length  > 0
      msg.send "```#{stdout}```" if stdout? && stdout.length > 0
      msg.send "```#{stderr}```" if stderr? && stderr.length > 0

  # robot.respond /david(\s+)update\s*([^\s]+)?$/i, (msg) ->
  # david update
