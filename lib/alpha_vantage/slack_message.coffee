moment = require('moment-timezone')

class AlphaVantageSlackMessage
  _outline = undefined

  constructor: (outline) ->
    _outline = outline

  format: ->
    self = AlphaVantageSlackMessage

    attachments = []
    for c in _outline.compare
      attachments.push(
        color: self.color(c.diff),
        text: "#{self.compare(c.diff)} (#{self.compare(c.ratio)}%) at #{self.date(c.timestamp)}"
      )

    return {
      text: "#{self.index(_outline.symbol)} *#{_outline.price}* at #{self.date(_outline.timestamp)}",
      attachments: attachments,
      mrkdwn: true
    }

  @color: (number) ->
    return '#35A64F' if number > 0
    return '#D1091F' if number < 0
    return '#DCDCDC'

  @compare: (number) ->
    return "+#{number}" if number > 0
    return "#{number}"

  @date: (timestamp) ->
    return moment(timestamp).tz('Asia/Tokyo').format('LL')

  @index: (symbol) ->
    return 'S&P 500 (^GSPC)' if symbol == '^GSPC'
    return 'ダウ平均 (^DJI)'  if symbol == '^DJI'
    return '日経平均 (^N225)' if symbol == '^N225'
    return symbol

  toString: ->
    return JSON.stringify(@format())

module.exports = AlphaVantageSlackMessage
