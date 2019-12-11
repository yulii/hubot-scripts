helper = require('../../test_helper')
expect = require('chai').expect

AlphaVantageFxDaily = helper.require('alpha_vantage/fx_daily')
describe 'AlphaVantageFxDaily', ->
  subject = undefined

  beforeEach ->
    object  = JSON.parse(helper.fixture.fx_daily)
    subject = new AlphaVantageFxDaily(object)

  describe '#outline', ->
    it 'returns an object', () ->
      expect(subject.outline()).to.include(timestamp: 1575849600000, symbol: 'EUR/USD', price: 1.1076)
      expect(subject.outline().compare).to.have.ordered.deep.members([
        { timestamp: 1575763200000, diff: 0.0018, ratio: 0.16 }
        { timestamp: 1573776000000, diff: 0.0025, ratio: 0.23 }
        { timestamp: 1569801600000, diff: 0.0178, ratio: 1.63 }
      ])

  describe '#symbol', ->
    it 'returns Symbol', () ->
      expect(subject.symbol()).to.equal('EUR/USD')

  describe '#timezone', ->
    it 'returns Time Zone', () ->
      expect(subject.timezone()).to.equal('UTC')

  describe '#latestDate', ->
    it 'returns a timestamp', () ->
      expect(subject.latestDate()).to.equal(1575849600000)

  describe '#closingPrice', ->
    it 'return a floating point number', () ->
      timestamp = helper.moment.tz('2019-10-28', 'UTC').valueOf()
      expect(subject.closingPrice(timestamp)).to.equal(1.1098)

  describe '#diffClosingPrice', ->
    it 'return a floating point number', () ->
      begin = helper.moment.tz('2019-09-11', 'UTC').valueOf()
      end   = helper.moment.tz('2019-11-20', 'UTC').valueOf()
      expect(subject.diffClosingPrice(begin, end)).to.equal(0.0066)

  describe '#ratioClosingPrice', ->
    it 'return a floating point number', () ->
      begin = helper.moment.tz('2019-09-03', 'UTC').valueOf()
      end   = helper.moment.tz('2019-12-02', 'UTC').valueOf()
      expect(subject.ratioClosingPrice(begin, end)).to.equal(0.96)
