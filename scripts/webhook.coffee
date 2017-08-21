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
    if /<@U0C8EL18D\|hubot>/i.test(req.body.text)
      switch true
        when /update all projects!/i.test(req.body.text)
          ['hubot-scripts', 'yulii.github.io'].forEach (name) ->
            var_name = "CIRCLE_TOKEN_#{name.replace(/[-.]/gi, '_').toUpperCase()}"

            if process.env[var_name]?
              new CircleCI(
                token: process.env[var_name]
                owner: 'yulii'
                project: name
                job: 'update'
              ).notify('#devops').execute(robot)
            else
              msg.send "Environment variable undefind.\n
                        Run `export #{var_name}=${API tokens for #{msg.match[2]}}` first."

        when /wake up!/i.test(req.body.text)
          robot.send { room: '#general' }, "I'm readly for @#{req.body.user_name}"

    res.end('OK')
