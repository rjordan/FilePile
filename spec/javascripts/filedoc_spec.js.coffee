#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require extensions
#= require models/filedoc

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
    model = new FileDoc()
    it 'should exist', ->
      expect(model).toNotBe(null)

  model = new FileDoc()
  it 'should accept new tags', ->
    model.tags = ['tag1', 'tag2']
    expect(model.tags).toNotContain('tag3')
    model.addTag('tag3')
    expect(model.isValid()).toBeTruthy()
    expect(model.tags).toContain('tag3')

  it 'should ignore duplicate tags', ->
    model.tags = ['tag1','tag2']
    expect(model.tags.length).toEqual(2)
    model.addTag('tag2')
    expect(model.isValid()).toBeTruthy()
    expect(model.tags.length).toEqual(2)

  it 'should be able to remove existing tags', ->
    model.tags = ['tag1','tag2']
    expect(model.tags).toContain('tag2')
    model.removeTag('tag2')
    expect(model.isValid()).toBeTruthy()
    expect(model.tags).toNotContain('tag2')


