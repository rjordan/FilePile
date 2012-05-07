Array.prototype.unique = () ->
    a = []
    for e in @
      a.push(e) if a.indexOf(e)==-1
    return a

Array.prototype.remove = (v) ->
  $.grep @,(e)-> e!=v

class Tag extends Spine.Model
  @configure 'Tag', 'name'
  @extend Spine.Model.Ajax

window.Tag = Tag

class FileDoc extends Spine.Model
  @configure "File", "file_name", "file_id", "file_size",
             "fingerprint", "description", "file_type", "tags"
  @extend Spine.Model.Ajax
  @url: "/files" 
  #@manyToMany Tag
  #@hasMany 'tags', 'Tag'

  validate: =>
    @tags = @tags.unique()
    return false

  formatFileSize: () =>
    bytes = @file_size
    return '' if (typeof bytes != 'number')
    return (bytes / 1000000000).toFixed(2) + ' GB' if (bytes >= 1000000000)
    return (bytes / 1000000).toFixed(2) + ' MB' if (bytes >= 1000000)
    return (bytes / 1000).toFixed(2) + ' KB' if (bytes >= 1000)
    return bytes.toFixed(0) + ' B'
    
window.FileDoc = FileDoc
