helper = require('../../../test_helper')
expect = require('chai').expect
sinon  = require('sinon')

AlphaVantageQueryTimeSeriesDaily = helper.require('alpha_vantage/query/time_series_daily')
describe 'AlphaVantageQueryTimeSeriesDaily', ->

  describe '#build', ->
    it 'returns a query string', () ->
      subject = new AlphaVantageQueryTimeSeriesDaily(apikey: 'secret', function: 'func', symbol: 'sym')
      expect(subject.build()).to.equal('apikey=secret&function=func&symbol=sym')
