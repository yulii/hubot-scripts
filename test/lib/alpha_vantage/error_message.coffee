source = '../../../lib/alpha_vantage/error_message'
helper = require('../../test_helper')
expect = require('chai').expect

AlphaVantageErrorMessage = require(source)
describe 'AlphaVantageErrorMessage', ->
  subject = undefined

  beforeEach ->
    object  = { 'Error Message': 'Invalid API call.' }
    subject = new AlphaVantageErrorMessage(object)

  describe '#format', ->
    it 'returns a object for slack message', () ->
      expect(subject.format().attachments).to.have.ordered.deep.members([
        { color: '#FF0000', title: 'Error Message', text: 'Invalid API call.' }
      ])
