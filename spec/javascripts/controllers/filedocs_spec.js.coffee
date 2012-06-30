#= require jquery
#= require jquery.mockjax
#= require spine
#= require spine/ajax
#= require extensions
#= require models/filedoc
#= require controllers/filedocs

describe 'FileDocs', ->
  it 'should exist', ->
    expect(FileDocs).toBeDefined

  controller = new FileDocs()
  it 'should handle small sizes', ->
    test = new FileDoc()
    test.file_size = 42
    expect(controller.helper.formatFileSize(test.file_size)).toEqual('42 B')
  it 'should handle larger sizes', ->
    test = new FileDoc()
    test.file_size = 42200
    expect(controller.helper.formatFileSize(test.file_size)).toEqual('42.20 KB')

