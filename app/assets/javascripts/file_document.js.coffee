class FileDocument
  tags: ko.observableArray([])
  constructor: (file) ->
    @id = file._id
    @file_name = file.file_name
    @tags(file.tags)
    @file_id=file.file_id
    @file_size=file.file_size
    @location = "/files/#{@id}"
  addTag: (tag) =>
    return @tags().length if $.inArray(tag, @tags())!=-1
    $.ajax
      url: "#{@location}/tags"
      dataType: 'JSON'
      data: {"tags": tag}
      type: 'POST'
    @tags.push(tag)
  removeTag: (tag) =>
    return @tags().length if not $.inArray(tag, @tags())
    $.ajax
      url: "#{@location}/tags"
      dataType: 'JSON'
      data: {"tags": tag}
      type: 'DELETE'
    @tags.remove(tag)

root = exports ? window  
root.FileDocument = FileDocument

