
@selectedItems = ->
  (item.value for item in $("INPUT[type='checkbox']:checked"))

fileTemplate = """
               <tr data-id="{{id}}">
                 <td class="select">
                   <input type="checkbox" name="file_ids[]" value="{{id}}"></input>
                 </td>
                 <td>
                   <a href="/gridfs/{{file_id}}/{{file_name}}">{{file_name}}</a>
                 </td>
                 <td>
                   {{#tags}}
                    <span class="label label-info">{{.}}</span>
                   {{/tags}}
                 </td>
                 <td class="align-right span2">
                   {{formatFileSize}}
                 </td>
               </tr>
               """

delay = ->
  true

jQuery ->
  FileDoc.fetch() 
  
  FileDoc.bind 'refresh', ->
    FileDoc.each (d) -> 
      $('#fileList').append(Mustache.render(fileTemplate, d))
  
  #ko.applyBindings(FileList)
  #$('body').trigger 'refresh'
  #fileList.updateList()

  $('#clear-tags').click (event) ->
    event.preventDefault()
    fileList.selectedTags([])

$('#available-tags a').live 'click', (event) ->
#    event.preventDefault()
    fileList.selectedTags.push($(this).text())
#    fileList.tags.pop($(this).text())


  $('#selected-tags a').live 'click', (event) ->
    event.preventDefault()
    fileList.selectedTags.remove($(this).text())

  $('#select-all').click ->
    $("INPUT[type='checkbox']").attr('checked', $(this).is(':checked'));

  $('#btn-add-tag').click ->
    new_tags = $('#new_tags').val()
    new_tag_array = new_tags.split(',')
    files = ( fileList.find(item) for item in selectedItems())
    for file in files
      for tag in new_tag_array
        file.addTag(tag)
    $('#new_tags').val('')

  $('#btn-delete').click ->
      list = selectedItems()
      alert list
      #confirm?
      for item in list
        fileList.delete(item)

  $('#fileupload').fileupload
    dataType: 'json'
    url: '/files'
    formData: {"tags": []}
    done: (e, data) ->
      $.each data.result, (index, file) ->
        alert "Index #{index}"
    progress: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      alert progress
