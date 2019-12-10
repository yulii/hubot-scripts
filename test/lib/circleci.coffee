helper = require('../test_helper')
expect = require('chai').expect

CircleCI = helper.require('circleci')
describe 'CircleCI', ->

  describe '#new', ->
    it 'returns an instance with default values', () ->
      process.env.CIRCLE_TOKEN_MOCHA = 'circle-token-mocha'
      ci = new CircleCI(owner: 'yulii', project: 'mocha', job: 'test')
      expect(ci).to.be.an.instanceof(CircleCI)
      expect(ci).to.have.property('vcsType', 'github')
      expect(ci).to.have.property('owner',   'yulii')
      expect(ci).to.have.property('project', 'mocha')
      expect(ci).to.have.property('branch',  'master')
      expect(ci).to.have.property('job',     'test')
      expect(ci).to.have.property('token',   'circle-token-mocha')
      delete process.env.CIRCLE_TOKEN_MOCHA

    it 'returns an instance', () ->
      ci = new CircleCI(vcsType: 'vcs', owner: 'yulii', project: 'mocha', branch: 'test/lib', job: 'test', token: 'circle')
      expect(ci).to.be.an.instanceof(CircleCI)
      expect(ci).to.have.property('vcsType', 'vcs')
      expect(ci).to.have.property('owner',   'yulii')
      expect(ci).to.have.property('project', 'mocha')
      expect(ci).to.have.property('branch',  'test/lib')
      expect(ci).to.have.property('job',     'test')
      expect(ci).to.have.property('token',   'circle')

    it 'throws an error', () ->
      expect(-> new CircleCI(                project: 'mocha', job: 'test', token: 'circle')).to.throw(Error, '`owner` is required argument')
      expect(-> new CircleCI(owner: 'yulii',                   job: 'test', token: 'circle')).to.throw(Error, '`project` is required argument')
      expect(-> new CircleCI(owner: 'yulii', project: 'mocha',              token: 'circle')).to.throw(Error, '`job` is required argument')
      expect(-> new CircleCI(owner: 'yulii', project: 'mocha', job: 'test'                 )).to.throw(Error, /Access token not found!/)

  describe '#tokenEnvName', ->
    beforeEach ->
      process.env.CIRCLE_TOKEN_PROJECT_REPOSITORY_NAME = 'circle-project-token'

    afterEach ->
      delete process.env.CIRCLE_TOKEN_PROJECT_REPOSITORY_NAME

    it 'returns environment variable name', () ->
      ci = new CircleCI(owner: 'yulii', job: 'test', project: 'project.repository-name')
      expect(ci.tokenEnvName()).to.equal('CIRCLE_TOKEN_PROJECT_REPOSITORY_NAME')

  describe '#tokenEnvValue', ->
    beforeEach ->
      process.env.CIRCLE_TOKEN_PROJECT_REPOSITORY_NAME = 'circle-project-token'

    afterEach ->
      delete process.env.CIRCLE_TOKEN_PROJECT_REPOSITORY_NAME

    it 'returns environment variable', () ->
      ci = new CircleCI(owner: 'yulii', job: 'test', project: 'project.repository-name')
      expect(ci.tokenEnvValue()).to.equal('circle-project-token')

  describe '#endpoint', ->
    it 'returns endpoint url in CircleCI API', () ->
      ci = new CircleCI(owner: 'yulii', job: 'test', project: 'mocha', token: 'circle-token')
      expect(ci.endpoint()).to.equal('https://circleci.com/api/v1.1/project/github/yulii/mocha/tree/master')

  describe '#notify', ->
    it 'sets `destination` property', () ->
      ci = new CircleCI(owner: 'yulii', job: 'test', project: 'mocha', token: 'circle-token').notify('address')
      expect(ci).to.be.an.instanceof(CircleCI)
      expect(ci).to.have.property('destination', 'address')
