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
     {{formatFileSize}}
   </td>
  </tr>
  """

class @FileDocs extends Spine.Controller
  render: ->
    FileDoc.each (d) ->
      $('#fileList').append(Mustache.render(fileTemplate, d))

  helper:
    formatFileSize: (bytes) =>
      return '' if (typeof bytes != 'number')
      return (bytes / 1000000000).toFixed(2) + ' GB' if (bytes >= 1000000000)
      return (bytes / 1000000).toFixed(2) + ' MB' if (bytes >= 1000000)
      return (bytes / 1000).toFixed(2) + ' KB' if (bytes >= 1000)
      return bytes.toFixed(0) + ' B'
