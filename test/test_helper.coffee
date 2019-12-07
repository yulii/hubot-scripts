fs     = require('fs')
path   = require('path')
moment = require('moment-timezone')

exports.moment  = moment
exports.fixture =
  time_series_daily: fs.readFileSync(path.join(__dirname, './fixture/time_series_daily.json'))
