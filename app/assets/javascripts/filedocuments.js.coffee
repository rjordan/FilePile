@fileTemplate = """
  <tr data-id="{{id}}" class="filerow">
   <td class="select">
     <input type="checkbox" name="file_ids[]" value="{{id}}"></input>
   </td>
   <td>
     <a href="/files/{{id}}/{{file_name}}">{{file_name}}</a>
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

@tagsTemplate = """
    {{#.}}
      <span class="badge">{{.}}</span>
    {{/.}}
  """

@changeEvent = new CustomEvent "changeEvent", {
  detail: null
  bubbles: true
  cancelable: true
}

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

  find: (id) =>
    file = item for item in @files when item.id is id
    file

  delete: (id) =>
    file = @find(id)
    @files = @files.remove(file)
    file.delete()
    document.dispatchEvent(changeEvent)

  add: (doc) =>
    @files.push(doc)
    document.dispatchEvent(changeEvent)

  fromUpload: (data) =>
    doc = new FileDocument
      id: data._id
      file_name: data.file_name
      file_size: data.file_size
      fingerprint: data.fingerprint
      tags: data.tags
      #description: data.description
      #file_type: data.file_type
    @add(doc)

  addTagFilter: (tag) =>
    @filterTags.push(tag)
    @filterTags = @filterTags.unique()
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
    @renderFilterTags()

  renderFilterTags: =>
    $('#tags').html(Mustache.render(tagsTemplate, @filterTags))

############ END NEW METHOD #############

#class @FileDocs extends Spine.Controller
#  @render: ->
#    $('#fileList').empty()
#    FileDoc.each (d) ->
#      $('#fileList').append(Mustache.render(fileTemplate, d))
#
#  @buildTagsModel: =>
#    for t in FileDoc.allTags()
#      Tags.add(t)
#
#  @renderFilteredFiles: =>
#    FileDocs.buildTagsModel()
#    $('#fileList').empty()
#    for file in FileDoc.filteredFiles()
#      $('#fileList').append(Mustache.render(fileTemplate, file))
#
