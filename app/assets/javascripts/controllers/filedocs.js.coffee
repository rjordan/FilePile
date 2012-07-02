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

