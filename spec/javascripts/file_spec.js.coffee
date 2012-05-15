#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require models/file

testData = { id: 1, file_name: "test.jpg", file_id: 2, file_size: 256, tags: ["tag1","tag2"] }

$.mockjax
  url: '/files'
  responseTime: 100
  responseText: [testData]

$.mockjax
  url: '/files/1'
  responseTime: 100
  responseText: testData

$.mockjax
  url: '/files/1/tags'
  responseTime: 100
  responseText: '["tag1","tag2"]'

describe 'FileDoc', ->
  describe 'when new', ->
    test = new FileDoc()
    it 'should exist', ->
      expect(test).toNotBe(null)

  test = new FileDoc()
  it 'should handle small sizes', ->
    test.file_size = 42
    expect(test.formatFileSize()).toEqual('42 B')
  it 'should handle larger sizes', ->
    test.file_size = 42200
    expect(test.formatFileSize()).toEqual('42.20 KB')

  it 'should accept new tags', ->
    test.tags = ['tag1', 'tag2']
    expect(test.tags).toNotContain('tag3')
    test.addTag('tag3')
    expect(test.isValid()).toBeTruthy()
    expect(test.tags).toContain('tag3')

  it 'should ignore duplicate tags', ->
    test.tags = ['tag1','tag2']
    expect(test.tags.length).toEqual(2)
    test.addTag('tag2')
    expect(test.isValid()).toBeTruthy()
    expect(test.tags.length).toEqual(2)

  it 'should be able to remove existing tags', ->
    test.tags = ['tag1','tag2']
    expect(test.tags).toContain('tag2')
    test.removeTag('tag2')
    expect(test.isValid()).toBeTruthy()
    expect(test.tags).toNotContain('tag2')


