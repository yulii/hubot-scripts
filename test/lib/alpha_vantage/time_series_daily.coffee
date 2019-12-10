helper = require('../../test_helper')
expect = require('chai').expect

AlphaVantageTimeSeriesDaily = helper.require('alpha_vantage/time_series_daily')
describe 'AlphaVantageTimeSeriesDaily', ->
  subject = undefined

  beforeEach ->
    object  = JSON.parse(helper.fixture.time_series_daily)
    subject = new AlphaVantageTimeSeriesDaily(object)

  describe '#outline', ->
    it 'returns an object', () ->
      expect(subject.outline()).to.include(timestamp: 1575435600000, symbol: 'MSFT', price: 149.85)
      expect(subject.outline().compare).to.have.ordered.deep.members([
        { timestamp: 1575349200000, diff: 0.54,  ratio: 0.36 }
        { timestamp: 1572930000000, diff: 5.39,  ratio: 3.73 }
        { timestamp: 1568088000000, diff: 13.77, ratio: 10.12 }
      ])

  describe '#symbol', ->
    it 'returns Symbol', () ->
      expect(subject.symbol()).to.equal('MSFT')

  describe '#timezone', ->
    it 'returns Time Zone', () ->
      expect(subject.timezone()).to.equal('US/Eastern')

  describe '#latestDate', ->
    it 'returns a timestamp', () ->
      expect(subject.latestDate()).to.equal(1575435600000)

  describe '#closingPrice', ->
    it 'return a floating point number', () ->
      timestamp = helper.moment.tz('2019-10-28', 'US/Eastern').valueOf()
      expect(subject.closingPrice(timestamp)).to.equal(144.1900)

  describe '#diffClosingPrice', ->
    it 'return a floating point number', () ->
      begin = helper.moment.tz('2019-07-17', 'US/Eastern').valueOf()
      end   = helper.moment.tz('2019-11-20', 'US/Eastern').valueOf()
      expect(subject.diffClosingPrice(begin, end)).to.equal(13.35)

  describe '#ratioClosingPrice', ->
    it 'return a floating point number', () ->
      begin = helper.moment.tz('2019-09-03', 'US/Eastern').valueOf()
      end   = helper.moment.tz('2019-12-02', 'US/Eastern').valueOf()
      expect(subject.ratioClosingPrice(begin, end)).to.equal(9.93)
