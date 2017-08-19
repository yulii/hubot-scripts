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

CircleCI = require '../lib/circleci'

module.exports = (robot) ->

  robot.router.post '/webhook', (req, res) ->
    switch true
      when /<@U0C8EL18D|hubot> update all projects!/.test(req.body.text)
        new CircleCI(
          token: process.env.CIRCLE_TOKEN
          owner: 'yulii'
          project: 'yulii.github.io'
          job: 'update'
        ).notify('#devops').execute(robot)

      when /<@U0C8EL18D|hubot> wake up!/.test(req.body.text)
        robot.send { room: '#general' }, "I'm readly for @#{req.body.user_name}"

    res.end()
