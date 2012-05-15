#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require models/file

$.mockjax
  url: '/files'
  responseTime: 100
  responseText: '[]]'

$.mockjax
  url: '/files/1/tags'
  responseTime: 100
  responseText: '{}'

describe 'FileDoc', ->
  describe 'when new', ->
    test = new FileDoc()
    it 'should exist', ->
      test.should.exist

  test = new FileDoc()
  it 'should handle small sizes', ->
    test.file_size = 42
    test.formatFileSize().should.equal('42 B')
  it 'should handle larger sizes', ->
    test.file_size = 42200
    test.formatFileSize().should.equal('42.20 KB')

  it 'should accept new tags', ->
    test.tags = ['tag1', 'tag2']
    test.tags.should.not.include('tag3')
    test.addTag('tag3')
    test.isValid().should.be.true
    test.tags.should.include('tag3')

  it 'should ignore duplicate tags', ->
    test.tags = ['tag1','tag2']
    test.tags.length.should.equal(2)
    test.addTag('tag2')
    test.isValid().should.be.true
    test.tags.length.should.equal(2)

  it 'should be able to remove existing tags', ->
    test.tags = ['tag1','tag2']
    test.tags.should.include('tag2')
    test.removeTag('tag2')
    test.isValid().should.be.true
    test.tags.should.not.include('tag2')


