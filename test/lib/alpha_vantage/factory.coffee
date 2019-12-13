helper = require('../../test_helper')
expect = require('chai').expect
sinon  = require('sinon')

AlphaVantageFactory = helper.require('alpha_vantage/factory')
describe 'AlphaVantageFactory', ->

  describe '#query', ->
    describe 'with defined function name', ->
      it 'returns an instance of AlphaVantageParserTimeSeriesDaily', () ->
        QueryObject = helper.require('alpha_vantage/query/time_series_daily')
        params = { apikey: 'secret', function: 'func', symbol: 'sym' }

        subject = new AlphaVantageFactory('TIME_SERIES_DAILY')
        expect(subject.query(params)).be.an.instanceof(QueryObject)

      it 'returns an instance of AlphaVantageParserFxDaily', () ->
        QueryObject = helper.require('alpha_vantage/query/fx_daily')
        params = { apikey: 'secret', function: 'func', symbol: 'sym' }

        subject = new AlphaVantageFactory('FX_DAILY')
        expect(subject.query(params)).be.an.instanceof(QueryObject)

  describe '#parse', ->
    describe 'with defined function name', ->
      it 'returns an instance of AlphaVantageParserTimeSeriesDaily', () ->
        AlphaVantageParserTimeSeriesDaily = helper.require('alpha_vantage/parser/time_series_daily')
        object = JSON.parse(helper.fixture.time_series_daily)

        subject = new AlphaVantageFactory('TIME_SERIES_DAILY')
        expect(subject.parse(object)).be.an.instanceof(AlphaVantageParserTimeSeriesDaily)

      it 'returns an instance of AlphaVantageParserFxDaily', () ->
        AlphaVantageParserFxDaily = helper.require('alpha_vantage/parser/fx_daily')
        object = JSON.parse(helper.fixture.fx_daily)

        subject = new AlphaVantageFactory('FX_DAILY')
        expect(subject.parse(object)).be.an.instanceof(AlphaVantageParserFxDaily)
