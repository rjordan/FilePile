#= require jquery
#= require jquery.mockjax
#= require extensions
#= require filedocument
#= require filedocuments

describe 'FileDocuments', ->
  it 'should exist', ->
    expect(FileDocuments).toBeDefined

#  controller = new FileDocuments()
#  it 'should handle small sizes', ->
#    test = new FileDocument
#      file_size: 42
#    expect(controller.helper.formatFileSize(test.file_size)).toEqual('42 B')
#  it 'should handle larger sizes', ->
#    test = new FileDocument
#      file_size: 42200
#    expect(controller.helper.formatFileSize(test.file_size)).toEqual('42.20 KB')

