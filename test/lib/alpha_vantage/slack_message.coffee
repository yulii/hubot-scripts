source = '../../../lib/alpha_vantage/slack_message'
helper = require('../../test_helper')
expect = require('chai').expect

AlphaVantageSlackMessage = require(source)
describe 'AlphaVantageSlackMessage', ->
  subject = undefined

  beforeEach ->
    object  = {
      timestamp: 1575435600000,
      symbol: 'MSFT',
      price: 149.85,
      compare: [
        { timestamp: 1575349200000, diff: 0.54,  ratio: 0.36  }
        { timestamp: 1572930000000, diff: -5.39, ratio: -3.73 }
        { timestamp: 1568088000000, diff: 0,     ratio: 0     }
      ]
    }
    subject = new AlphaVantageSlackMessage(object)

  describe '#format', ->
    it 'returns a string', () ->
      expect(subject.format()).to.include(text: 'MSFT *149.85* at December 4, 2019', mrkdwn: true)
      expect(subject.format().attachments).to.have.ordered.deep.members([
        { color: '#35A64F', text: '+0.54 (+0.36%) at December 3, 2019' }
        { color: '#D1091F', text: '-5.39 (-3.73%) at November 5, 2019' }
        { color: '#DCDCDC', text: '0 (0%) at September 10, 2019' }
      ])

  describe '.color', ->
    it 'returns a color code with a positive number', () ->
      expect(AlphaVantageSlackMessage.color(0.1)).to.equal('#35A64F')
    it 'returns a color code with zero', () ->
      expect(AlphaVantageSlackMessage.color(0)).to.equal('#DCDCDC')
    it 'returns a color code with a negative number', () ->
      expect(AlphaVantageSlackMessage.color(-0.1)).to.equal('#D1091F')

  describe '.compare', ->
    it 'returns a number string with a positive number', () ->
      expect(AlphaVantageSlackMessage.compare(0.1)).to.equal('+0.1')
    it 'returns a number string with zero', () ->
      expect(AlphaVantageSlackMessage.compare(0)).to.equal('0')
    it 'returns a number string with a negative number', () ->
      expect(AlphaVantageSlackMessage.compare(-0.1)).to.equal('-0.1')

  describe '.date', ->
    it 'returns a date', () ->
      expect(AlphaVantageSlackMessage.date(1575435600000)).to.equal('December 4, 2019')

  describe '.index', ->
    it 'returns a string', () ->
      expect(AlphaVantageSlackMessage.index('^GSPC')).to.equal('S&P 500 (^GSPC)')
    it 'returns an argument with undefined symbol', () ->
      expect(AlphaVantageSlackMessage.index('SYMBOL')).to.equal('SYMBOL')
