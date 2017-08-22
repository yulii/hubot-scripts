source = '../../lib/circleci'
expect = require('chai').expect

CircleCI = require(source)
describe 'CircleCI', ->

  describe '#tokenEnvName', ->
    it 'return environment variable name', () ->
      ci = new CircleCI(
              owner: 'yulii'
              job: 'job'
              project: 'project.repository-name'
              token: 'circle-token'
            )

      expect(ci.tokenEnvName()).to.equal('CIRCLE_TOKEN_PROJECT_REPOSITORY_NAME')

  describe '#endpoint', ->
    it 'return endpoint url in CircleCI API', () ->
      ci = new CircleCI(
              owner: 'yulii'
              job: 'job'
              project: 'mocha'
              token: 'circle-token'
            )

      expect(ci.endpoint()).to.equal('https://circleci.com/api/v1.1/project/github/yulii/mocha/tree/master')
