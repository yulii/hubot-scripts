# Description:
#   A simple interaction with the built in HTTP Daemon
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   /webhook

child_process = require 'child_process'

module.exports = (robot) ->

  robot.router.post '/webhook', (req, res) ->
    switch true
      when /@hubot update projects/.test(req.body.text)
        child_process.exec "CIRCLE_PROJECT=yulii.github.io JOB_USER=hubot bin/circleci", (error, stdout, stderr) ->
          if !error
            robot.send { room: "#devops" }, "Kick yulii.github.io update"
          else
            robot.send "Error yulii.github.io update"

        child_process.exec "CIRCLE_PROJECT=hubot-scripts JOB_USER=hubot bin/circleci", (error, stdout, stderr) ->
          if !error
            robot.send { room: "#devops" }, "Kick hubot-scripts update"
          else
            robot.send "Error hubot-scripts update"

      when /@hubot wake up!/.test(req.body.text)
        robot.send { room: '#general' }, "I'm readly for @#{req.body.user_name}"

    res.end()
