helper = require('../test_helper')
expect = require('chai').expect
sinon  = require('sinon')

Robot = require('hubot/src/robot')
AlphaVantage = helper.require('alpha_vantage')
describe 'AlphaVantage', ->

  beforeEach ->
    process.env.ALPHA_VANTAGE_API_KEY = 'alpha-vantage-key'

  afterEach ->
    delete process.env.ALPHA_VANTAGE_API_KEY

  describe '#execute', ->
    robot = undefined
    http_stub = undefined

    beforeEach ->
      robot = new Robot(null, 'mock-adapter', false, 'hubot')
      http_stub = (callback) ->
        sinon.stub(robot, 'http').returns(
          header: sinon.stub().returnsThis()
          get: sinon.stub().callsFake(() -> return callback)
        )

    afterEach ->
      robot.http.restore()

    describe 'when response is successful', ->
      AlphaVantageSlackMessage = helper.require('alpha_vantage/slack_message')

      it 'calls callback with a message object ', () ->
        http_stub((f) -> f(null, 'response', helper.fixture.time_series_daily))

        new AlphaVantage(function: 'TIME_SERIES_DAILY', symbol: 'SYMBOL').execute(robot, (message) ->
          expect(message).to.be.an.instanceof(AlphaVantageSlackMessage)
        )

    describe 'when response is failure', ->
      AlphaVantageErrorMessage = helper.require('alpha_vantage/error_message')

      it 'calls callback with a message object', () ->
        http_stub((f) -> f(null, 'response', helper.fixture.error_message))

        new AlphaVantage(function: 'FX_DAILY', symbol: 'FROM/TO').execute(robot, (message) ->
          expect(message).to.be.an.instanceof(AlphaVantageErrorMessage)
        )
