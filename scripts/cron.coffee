cron = require('cron').CronJob
child_process = require 'child_process'

module.exports = (robot) ->

  new cron '0 0 0 * * 1-7', () =>
    child_process.exec "CIRCLE_PROJECT=yulii.github.io JOB_USER=hubot bin/circleci", (error, stdout, stderr) ->
      if !error
        robot.send { room: "#devops" }, "Kick yulii.github.io update"
      else
        robot.send "Error yulii.github.io update"
  , null, true

  new cron '0 0 0 * * 1-7', () =>
    child_process.exec "CIRCLE_PROJECT=hubot-scripts JOB_USER=hubot bin/circleci", (error, stdout, stderr) ->
      if !error
        robot.send { room: "#devops" }, "Kick hubot-scripts update"
      else
        robot.send "Error hubot-scripts update"
  , null, true
