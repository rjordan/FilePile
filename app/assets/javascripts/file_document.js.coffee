class FileDocument
  tags: ko.observableArray([])
  constructor: (file) ->
    @id = file._id
    @file_name = file.file_name
    @tags(file.tags)
    @file_id=file.file_id
    @file_size=file.file_size
    @location = "/files/#{@file_id}"
  addTag: (tag) =>
    if @tags.indexOf(tag)
       return
#    $.ajax
#        url: "#{@location}/tags"
#        dataType: 'JSON'
#        data: {"tags": tag}
#        type: 'POST'
    @tags.push(tag)
  removeTag: (tag) =>
 #   $.ajax
 #       url: "#{@location}/tags"
 #       dataType: 'JSON'
 #       data: {"tags": tag}
 #       type: 'DELETE'
    @tags.pop(tag)

root = exports ? window  
root.FileDocument = FileDocument

