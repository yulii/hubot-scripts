class AlphaVantageErrorMessage

  constructor: (response) ->
    @response = response

  format: ->
    return attachments: [{ color: '#FF0000', title: 'Error Message', text: @response['Error Message'] }]

  toString: ->
    return JSON.stringify(@format())

module.exports = AlphaVantageErrorMessage
