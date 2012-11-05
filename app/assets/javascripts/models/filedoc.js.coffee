class @FileDoc extends Spine.Model
  @configure "FileDoc", "file_name", "file_id", "file_size",
             "fingerprint", "description", "file_type", "tags"
  @extend Spine.Model.Ajax
  @url: "/files"

  @filteredFiles: ->
    docs = @.all()
    for tag in Tags.selected()
      docs = (item for item in docs when tag in item.tags)
    docs

  @allTags: =>
    tags = (d.tags for d in FileDoc.all()).flatten()

  addTag: (tag) =>
    @tags = @tags.concat(tag) unless tag in @tags

  removeTag: (tag) =>
    @tags = @tags.remove(tag)

  formattedFileSize: =>
    bytes = @file_size
    return '' if (typeof bytes != 'number')
    return (bytes / 1000000000).toFixed(2) + ' GB' if (bytes >= 1000000000)
    return (bytes / 1000000).toFixed(2) + ' MB' if (bytes >= 1000000)
    return (bytes / 1000).toFixed(2) + ' KB' if (bytes >= 1000)
    return bytes.toFixed(0) + ' B'


#window.FileDoc = FileDoc
