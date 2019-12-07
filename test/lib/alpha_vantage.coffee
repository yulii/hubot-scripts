source = '../../lib/alpha_vantage'
helper = require('../test_helper')
expect = require('chai').expect

AlphaVantage = require(source)
describe 'AlphaVantage', ->

  describe '#new', ->
    it 'returns an instance with default values', () ->
      process.env.ALPHA_VANTAGE_API_KEY = 'alpha-vantage-key'
      av = new AlphaVantage(function: 'FUNCTION', symbol: 'SYMBOL')
      expect(av).to.be.an.instanceof(AlphaVantage)
      expect(av).to.have.property('function', 'FUNCTION')
      expect(av).to.have.property('symbol',   'SYMBOL')
      expect(av).to.have.property('token',    'alpha-vantage-key')
      delete process.env.ALPHA_VANTAGE_API_KEY
