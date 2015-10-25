source = '../scripts/ping'
expect = require('chai').expect

Robot       = require('hubot/src/robot')
TextMessage = require('hubot/src/message').TextMessage

describe 'ping', ->
  robot = null
  user = null
  adapter = null

  beforeEach (done) ->
    robot = new Robot(null, 'mock-adapter', false, 'hubot')

    robot.adapter.on 'connected', ->
      require(source)(robot)
      user = robot.brain.userForId '1',
        name: 'mocha'
        room: '#mocha'
      adapter = robot.adapter
      done()
    robot.run()

  afterEach -> robot.shutdown()

  it 'replies pong', (done) ->
    adapter.on 'send', (envelope, strings) ->
      try
        expect(envelope.user.name).to.equal('mocha')
        expect(strings[0]).to.equal('PONG')
        done()
      catch e
        done e

    adapter.receive(new TextMessage(user, 'hubot ping'))

