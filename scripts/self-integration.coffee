# Description:
#   Self-integration commands for Hubot.
#
# Commands:
#   hubot outdated - Execute npm outdated

module.exports = (robot) ->

  robot.respond /printenv$/i, (msg) ->
    @child_process = require('child_process')
    command = 'printenv'
    @child_process.exec command, (error, stdout, stderr) ->
      msg.send command
      msg.send "```#{error}```"  if error?  && error.length  > 0
      msg.send "```#{stdout}```" if stdout? && stdout.length > 0
      msg.send "```#{stderr}```" if stderr? && stderr.length > 0

  robot.respond /show$/i, (msg) ->
    @child_process = require('child_process')
    @child_process.exec 'pwd', (error, stdout, stderr) ->
      msg.send command
      msg.send "```#{error}```"  if error?  && error.length  > 0
      msg.send "```#{stdout}```" if stdout? && stdout.length > 0
      msg.send "```#{stderr}```" if stderr? && stderr.length > 0
    @child_process.exec 'ls -ltr', (error, stdout, stderr) ->
      msg.send command
      msg.send "```#{error}```"  if error?  && error.length  > 0
      msg.send "```#{stdout}```" if stdout? && stdout.length > 0
      msg.send "```#{stderr}```" if stderr? && stderr.length > 0

  robot.respond /outdated$/i, (msg) ->
    @child_process = require('child_process')
    command = 'npm outdated'
    @child_process.exec command, (error, stdout, stderr) ->
      msg.send command
      msg.send "```#{error}```"  if error?  && error.length  > 0
      msg.send "```#{stdout}```" if stdout? && stdout.length > 0
      msg.send "```#{stderr}```" if stderr? && stderr.length > 0

