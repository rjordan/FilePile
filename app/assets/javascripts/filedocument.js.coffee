class @FileDocument
  constructor: (data) ->
    @id = data.id['$oid']
    @file_id = data.file_id['$oid']
    @file_name = data.file_name
    @fingerprint = data.fingerprint
    @file_size = data.file_size
    @tags = data.tags || new Array
    @location = "/files/" + @id

  delete: =>
    $.ajax
      type: "DELETE"
      dataType: 'json'
      url: @location

  addTag: (tag) =>
    @tags = @tags.concat(tag) unless tag in @tags

  removeTag: (tag) =>
    @tags = @tags.remove(tag)

  save: =>
    $.ajax
      type: "PUT"
      dataType: 'json'
      url: @location
      data: { id: @id, tags: @tags }
    document.dispatchEvent(changeEvent)

  formattedFileSize: =>
    bytes = @file_size
    return '' if (typeof bytes != 'number')
    return (bytes / 1000000000).toFixed(2) + ' GB' if (bytes >= 1000000000)
    return (bytes / 1000000).toFixed(2) + ' MB' if (bytes >= 1000000)
    return (bytes / 1000).toFixed(2) + ' KB' if (bytes >= 1000)
    return bytes.toFixed(0) + ' B'
