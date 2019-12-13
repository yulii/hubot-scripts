helper = require('../../../test_helper')
expect = require('chai').expect
sinon  = require('sinon')

AlphaVantageQueryFxDaily = helper.require('alpha_vantage/query/fx_daily')
describe 'AlphaVantageQueryFxDaily', ->

  describe '#build', ->
    it 'returns a query string', () ->
      subject = new AlphaVantageQueryFxDaily({})
      expect(subject.build()).to.equal('')
