helper = require('../../../test_helper')
expect = require('chai').expect
sinon  = require('sinon')

AlphaVantageQueryFxDaily = helper.require('alpha_vantage/query/fx_daily')
describe 'AlphaVantageQueryFxDaily', ->

  describe '#build', ->
    it 'returns a query string', () ->
      subject = new AlphaVantageQueryFxDaily(apikey: 'secret', function: 'func', symbol: 'from_sym/to_sym')
      expect(subject.build()).to.equal('apikey=secret&function=func&from_symbol=from_sym&to_symbol=to_sym&outputsize=compact&datatype=json')
