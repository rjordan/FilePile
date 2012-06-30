#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require extensions
#= require models/filedoc
#= require controllers/filedocs

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

describe 'FileDocs', ->
  controller = new FileDocs()
  it 'should handle small sizes', ->
    test = new FileDoc()
    test.file_size = 42
    expect(controller.helper.formatFileSize(test.file_size)).toEqual('42 B')
  it 'should handle larger sizes', ->
    test = new FileDoc()
    test.file_size = 42200
    expect(controller.helper.formatFileSize(test.file_size)).toEqual('42.20 KB')

