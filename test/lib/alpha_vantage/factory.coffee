helper = require('../../test_helper')
expect = require('chai').expect
sinon  = require('sinon')

AlphaVantageFactory = helper.require('alpha_vantage/factory')
describe 'AlphaVantageFactory', ->

  describe '#parse', ->
    describe 'with defined function name', ->
      it 'returns AlphaVantageParserTimeSeriesDaily object', () ->
        AlphaVantageParserTimeSeriesDaily = helper.require('alpha_vantage/parser/time_series_daily')
        object = JSON.parse(helper.fixture.time_series_daily)

        subject = new AlphaVantageFactory('TIME_SERIES_DAILY')
        expect(subject.parse(object)).be.an.instanceof(AlphaVantageParserTimeSeriesDaily)

      it 'returns AlphaVantageParserFxDaily object', () ->
        AlphaVantageParserFxDaily = helper.require('alpha_vantage/parser/fx_daily')
        object = JSON.parse(helper.fixture.fx_daily)

        subject = new AlphaVantageFactory('FX_DAILY')
        expect(subject.parse(object)).be.an.instanceof(AlphaVantageParserFxDaily)
