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
      text: "*#{_outline.price}* #{self.date(_outline.timestamp)}",
      attachments: attachments,
      mrkdwn: true
    }

  @color: (number) ->
    return '#155724' if number > 0
    return '#721c24' if number < 0
    return '#383d41'

  @compare: (number) ->
    return "+#{number}" if number > 0
    return "#{number}"

  @date: (timestamp) ->
    return moment(timestamp).tz('Asia/Tokyo').format('LL')

  toString: ->
    return JSON.stringify(@format())

module.exports = AlphaVantageSlackMessage
