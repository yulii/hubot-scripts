# Description:
#   Node package management commands
#
# Commands:
#   hubot dedupe   - Check for outdated packages
#   hubot outdated - Reduce duplicated dependent packages

module.exports = (robot) ->

  robot.respond /dedupe$/i, (msg) ->
    @child_process = require('child_process')
    @child_process.exec 'npm dedupe', (error, stdout, stderr) ->
      msg.send "```#{error}```"  if error?  && error.length  > 0
      msg.send "```#{stdout}```" if stdout? && stdout.length > 0
      msg.send "```#{stderr}```" if stderr? && stderr.length > 0

  robot.respond /outdated$/i, (msg) ->
    @child_process = require('child_process')
    @child_process.exec 'npm outdated', (error, stdout, stderr) ->
      msg.send "```#{error}```"  if error?  && error.length  > 0
      msg.send "```#{stdout}```" if stdout? && stdout.length > 0
      msg.send "```#{stderr}```" if stderr? && stderr.length > 0

