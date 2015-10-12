# Description:
#   Self-integration commands for Hubot.
#
# Commands:
#   hubot outdated - Execute npm outdated

module.exports = (robot) ->

  robot.respond /outdated$/i, (msg) ->
    @child_process = require('child_process')
    command = 'npm outdated'
    msg.send command
    @child_process.exec 'pwd', (error, stdout, stderr) ->
      msg.send error  if error?
      msg.send stdout if stdout?
      msg.send stderr if stderr?
    @child_process.exec 'ls -al', (error, stdout, stderr) ->
      msg.send error  if error?
      msg.send stdout if stdout?
      msg.send stderr if stderr?
    @child_process.exec command, (error, stdout, stderr) ->
      msg.send error  if error?
      msg.send stdout if stdout?
      msg.send stderr if stderr?

