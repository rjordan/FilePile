@fileTemplate = """
  <tr data-id="{{id}}" class="filerow">
   <td class="select">
     <input type="checkbox" name="file_ids[]" value="{{id}}"></input>
   </td>
   <td>
     <a href="/gridfs/{{file_id}}/{{file_name}}">{{file_name}}</a>
   </td>
   <td class="tags">
     {{#tags}}
      <span class="badge">{{.}}</span>
     {{/tags}}
   </td>
   <td class="align-right span2">
     {{formattedFileSize}}
   </td>
  </tr>
  """

@changeEvent = new CustomEvent "changeEvent", {
  detail: null
  bubbles: true
  cancelable: true
}

class FileDocument
  constructor: (data) ->
    @id = data.id
    @file_name = data.file_name
    @fingerprint = data.fingerprint
    @file_size = data.file_size
    @tags = data.tags
    @location = "/files/" + @id

  delete: =>
    $.ajax
      type: "DELETE"
      dataType: 'json'
      url: @location

  #  addTag: (tag) =>
  #    @tags = @tags.concat(tag) unless tag in @tags

  #  removeTag: (tag) =>
  #    @tags = @tags.remove(tag)

  formattedFileSize: =>
    bytes = @file_size
    return '' if (typeof bytes != 'number')
    return (bytes / 1000000000).toFixed(2) + ' GB' if (bytes >= 1000000000)
    return (bytes / 1000000).toFixed(2) + ' MB' if (bytes >= 1000000)
    return (bytes / 1000).toFixed(2) + ' KB' if (bytes >= 1000)
    return bytes.toFixed(0) + ' B'

class @FileDocuments
  constructor: () ->
    @files = []
    @filterTags = []
    document.addEventListener 'changeEvent', @render

  fetch: =>
    $.ajax('/files.json').done (filesJson) =>
      for file in filesJson
        @files.push(new FileDocument(file))
      document.dispatchEvent(changeEvent)

  delete: (id) =>
    file = item for item in @files when item.id is id
    @files.remove(file)
    file.delete()
    document.dispatchEvent(changeEvent)

  add: (doc) =>
    @files.push(doc)
    document.dispatchEvent(changeEvent)

  addTagFilter: (tag) =>
    @filterTags.push(tag)
    document.dispatchEvent(changeEvent)

  removeTagFilter: (tag) =>
    @filterTags = @filterTags.remove(tag)
    document.dispatchEvent(changeEvent)

  filteredFiles: ->
    return @files if @filterTags.length == 0
    docs = []
    for tag in @filterTags
      docs = (item for item in @files when tag in item.tags)
    docs

  allTags: =>
    (d.tags for d in @files).flatten().unique()

  render: =>
    $('#fileList').empty()
    for file in @filteredFiles()
      $('#fileList').append(Mustache.render(fileTemplate, file))


############ END NEW METHOD #############

class @FileDocs extends Spine.Controller
  @render: ->
    $('#fileList').empty()
    FileDoc.each (d) ->
      $('#fileList').append(Mustache.render(fileTemplate, d))

  @buildTagsModel: =>
    for t in FileDoc.allTags()
      Tags.add(t)

  @renderFilteredFiles: =>
    FileDocs.buildTagsModel()
    $('#fileList').empty()
    for file in FileDoc.filteredFiles()
      $('#fileList').append(Mustache.render(fileTemplate, file))

