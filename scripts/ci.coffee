# Description:
#   Kick CI job.
#
# Commands:
#   hubot ci <job> <project> - Kick CI job

CircleCI = require '../lib/circleci'

module.exports = (robot) ->
  robot.respond /ci ([a-z_0-9]+) ([a-z_0-9.-]+)$/i, (msg) ->
    try
      new CircleCI(
        owner: 'yulii'
        job: msg.match[1]
        project: msg.match[2]
      ).notify("##{msg.envelope.room}").execute(robot)
    catch error
      msg.send "#{error.name}: #{error.message}"
