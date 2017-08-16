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

module.exports = (robot) ->

  robot.router.post '/webhook', (req, res) ->
    switch true
      when /wake(\s+#{robot.name})?\s+up!/.test(req.body.text)
        robot.send { room: '#general' }, "@#{req.body.user_name} Waking @#{robot.name} up now. Wait a second."
    res.end()
