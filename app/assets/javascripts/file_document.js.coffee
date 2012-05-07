class FileDocument
  tags: ko.observableArray([])
  constructor: (file) ->
    @id = file._id
    @file_name = file.file_name
    #for tag in file.tags
    #  @tags.push tag
    @tags(file.tags)
    @file_id=file.file_id
    @file_size=file.file_size
    @location = "/files/#{@id}"
  addTag: (tag) =>
    return @tags().length if contains(tag, @tags())
    $.ajax
      url: "#{@location}/tags"
      dataType: 'JSON'
      data: {"tags": tag}
      type: 'POST'
    @tags.push(tag)
  removeTag: (tag) =>
    return @tags().length if not contains(tag, @tags()) 
    $.ajax
      url: "#{@location}/tags"
      dataType: 'JSON'
      data: {"tags": tag}
      type: 'DELETE'
    @tags.remove(tag)

@contains = (elem, array) ->
  if $.inArray(elem, array) > -1 
    true
  else
    false 

window.FileDocument = FileDocument

