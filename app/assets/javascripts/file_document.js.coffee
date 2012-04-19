//= require knockout-2.0.0

class FileDocument
  tags: ko.observableArray([])
  constructor: (file) ->
    @id = file._id
    @file_name = file.file_name
    @tags(file.tags)
    @file_id=file.file_id
    @file_size=file.file_size
    @location = "/files/#{@file_id}"

root = exports ? window  
root.FileDocument = FileDocument

