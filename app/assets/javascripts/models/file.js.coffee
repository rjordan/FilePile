Array.prototype.unique = () ->
    a = []
    for e in @
      a.push(e) if a.indexOf(e)==-1
    return a

Array.prototype.remove = (v) ->
   $.grep @,(e)-> e!=v

#formatFileSize: (bytes) =>
#  return '' if (typeof bytes != 'number')
#  return (bytes / 1000000000).toFixed(2) + ' GB' if (bytes >= 1000000000)
#  return (bytes / 1000000).toFixed(2) + ' MB' if (bytes >= 1000000)
#  return (bytes / 1000).toFixed(2) + ' KB' if (bytes >= 1000)
#  return bytes.toFixed(0) + ' B'

#window.formatFileSize = formatFileSize

class FileDoc extends Spine.Model
  @configure "FileDoc", "file_name", "file_id", "file_size",
             "fingerprint", "description", "file_type", "tags"
  @extend Spine.Model.Ajax
  @url: "/files" 

  hasTag: (tag) =>
    @tags.indexOf(tag) != -1

  addTag: (tag) =>
    @tags.push(tag) unless @.hasTag(tag)

  removeTag: (tag) =>
    @tags = @tags.remove(tag)

  formatFileSize: () =>
    bytes = @file_size
    return '' if (typeof bytes != 'number')
    return (bytes / 1000000000).toFixed(2) + ' GB' if (bytes >= 1000000000)
    return (bytes / 1000000).toFixed(2) + ' MB' if (bytes >= 1000000)
    return (bytes / 1000).toFixed(2) + ' KB' if (bytes >= 1000)
    return bytes.toFixed(0) + ' B'

window.FileDoc = FileDoc
