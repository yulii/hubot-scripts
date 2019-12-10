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

AlphaVantage = require '../lib/alpha_vantage'
CircleCI     = require '../lib/circleci'

module.exports = (robot) ->

  robot.router.post '/webhook', (req, res) ->
    if /<@U0C8EL18D\|hubot>/i.test(req.body.text)
      switch true
        when /update all projects!/i.test(req.body.text)
          ['hubot-scripts', 'yulii.github.io'].forEach (name) ->
            try
              new CircleCI(
                owner: 'yulii'
                project: name
                job: 'update'
              ).notify('#devops').execute(robot)
            catch error
              robot.send { room: '#devops' }, "#{error.name}: #{error.message}"

        when /show market indexes!/i.test(req.body.text)
          ['^GSPC'].forEach (name) ->
            try
              new AlphaVantage(
                function: 'TIME_SERIES_DAILY', symbol: name
              ).execute(robot, (message) ->
                robot.send { room: '#random' }, message.format()
              )
            catch error
              robot.send { room: '#devops' }, "#{error.name}: #{error.message}"

        when /wake up!/i.test(req.body.text)
          robot.send { room: '#general' }, "I'm readly for @#{req.body.user_name}"

    res.end('OK')
