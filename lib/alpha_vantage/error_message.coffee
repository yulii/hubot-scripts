class AlphaVantageErrorMessage
  _response = undefined

  constructor: (response) ->
    _response = response

  format: ->
    return attachments: [{ color: '#FF0000', title: 'Error Message', text: _response['Error Message'] }]

  toString: ->
    return JSON.stringify(@format())

module.exports = AlphaVantageErrorMessage
