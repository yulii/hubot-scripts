# Description:
#   Kick CI job.
#
# Commands:
#   hubot ci <job> <project> - Kick CI job

CircleCI = require '../lib/circleci'

module.exports = (robot) ->
  robot.respond /ci (.+) (.+)$/i, (msg) ->
    new CircleCI(
      token: process.env.CIRCLE_TOKEN
      owner: 'yulii'
      job: msg.match[1]
      project: msg.match[2]
    ).notify("##{msg.envelope.room}").execute(robot)
