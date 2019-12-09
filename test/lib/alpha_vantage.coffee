source = '../../lib/alpha_vantage'
helper = require('../test_helper')
expect = require('chai').expect
sinon  = require('sinon')

Robot = require('hubot/src/robot')
AlphaVantageSlackMessage = require '../../lib/alpha_vantage/slack_message'
AlphaVantage = require(source)
describe 'AlphaVantage', ->

  beforeEach ->
    process.env.ALPHA_VANTAGE_API_KEY = 'alpha-vantage-key'

  afterEach ->
    delete process.env.ALPHA_VANTAGE_API_KEY

  describe '#new', ->
    it 'returns an instance with default values', () ->
      av = new AlphaVantage(function: 'FUNCTION', symbol: 'SYMBOL')
      expect(av).to.be.an.instanceof(AlphaVantage)
      expect(av).to.have.property('function', 'FUNCTION')
      expect(av).to.have.property('symbol',   'SYMBOL')
      expect(av).to.have.property('token',    'alpha-vantage-key')

  describe '#execute', ->
    robot = undefined
    stub  = undefined

    beforeEach ->
      robot = new Robot(null, 'mock-adapter', false, 'hubot')
      stub  = (callback) ->
        sinon.stub(robot, 'http').returns(
          header: sinon.stub().returnsThis()
          get: sinon.stub().callsFake(() -> return callback)
        )

    afterEach ->
      robot.http.restore()

    it 'returns an instance with default values', () ->
      stub((f) -> f('error', 'response', helper.fixture.time_series_daily))

      av = new AlphaVantage(function: 'FUNCTION', symbol: 'SYMBOL').execute(robot, (message) ->
        expect(message).to.be.an.instanceof(AlphaVantageSlackMessage)
      )
