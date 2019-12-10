fs     = require('fs')
path   = require('path')
moment = require('moment-timezone')

exports.moment  = moment
exports.fixture =
  error_message:     fs.readFileSync(path.join(__dirname, './fixture/error_message.json'))
  time_series_daily: fs.readFileSync(path.join(__dirname, './fixture/time_series_daily.json'))
