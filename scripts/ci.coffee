# Description:
#   Kick CI job.
#
# Commands:
#   hubot ci <job> <project> - Kick CI job

CircleCI = require '../lib/circleci'

module.exports = (robot) ->
  robot.respond /ci ([a-z_0-9]+) ([a-z_0-9.-]+)$/i, (msg) ->
    var_name = "CIRCLE_TOKEN_#{msg.match[2].replace(/[-.]/gi, '_').toUpperCase()}"

    if process.env[var_name]?
      new CircleCI(
        token: process.env[var_name]
        owner: 'yulii'
        job: msg.match[1]
        project: msg.match[2]
      ).notify("##{msg.envelope.room}").execute(robot)
    else
      msg.send "Environment variable undefind.\n
                Run `export #{var_name}=${API tokens for #{msg.match[2]}}` first."
