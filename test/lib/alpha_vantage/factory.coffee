helper = require('../../test_helper')
expect = require('chai').expect
sinon  = require('sinon')

AlphaVantageFactory = helper.require('alpha_vantage/factory')
describe 'AlphaVantageFactory', ->

  describe '#create', ->
    describe 'with defined function name', ->
      it 'returns AlphaVantageTimeSeriesDaily object', () ->
        AlphaVantageTimeSeriesDaily = helper.require('alpha_vantage/time_series_daily')
        object = JSON.parse(helper.fixture.time_series_daily)

        subject = new AlphaVantageFactory('TIME_SERIES_DAILY')
        expect(subject.create(object)).be.an.instanceof(AlphaVantageTimeSeriesDaily)

    describe 'with undefined function name', ->
      it 'returns AlphaVantageFxDaily object', () ->
        AlphaVantageFxDaily = helper.require('alpha_vantage/fx_daily')
        object = JSON.parse(helper.fixture.fx_daily)

        subject = new AlphaVantageFactory('FX_DAILY')
        expect(subject.create(object)).be.an.instanceof(AlphaVantageFxDaily)
