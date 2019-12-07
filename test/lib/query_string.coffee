source = '../../lib/query_string'
helper = require('../test_helper')
expect = require('chai').expect

QueryString = require(source)
describe 'QueryString', ->

  describe '#build', ->
    it 'returns a query string', () ->
      subject = QueryString.build(object: 'QueryString', function: 'build')
      expect(subject).to.equal('object=QueryString&function=build')
