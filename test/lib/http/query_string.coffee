helper = require('../../test_helper')
expect = require('chai').expect

HttpQueryString = helper.require('http/query_string')
describe 'HttpQueryString', ->

  describe '#build', ->
    it 'returns a query string', () ->
      subject = HttpQueryString.build(object: 'QueryString', function: 'build')
      expect(subject).to.equal('object=QueryString&function=build')
