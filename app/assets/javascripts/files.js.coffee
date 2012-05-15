
@selectedItems = ->
  (item.value for item in $("INPUT[type='checkbox']:checked"))

fileTemplate = """
               <tr data-id="{{id}}" class="filerow">
                 <td class="select">
                   <input type="checkbox" name="file_ids[]" value="{{id}}"></input>
                 </td>
                 <td>
                   <a href="/gridfs/{{file_id}}/{{file_name}}">{{file_name}}</a>
                 </td>
                 <td class="tags">
                   {{#tags}}
                    <span class="label label-info">{{.}}</span>
                   {{/tags}}
                 </td>
                 <td class="align-right span2">
                   {{formatFileSize}}
                 </td>
               </tr>
               """

selectedTagTemplate = '<li><a href="/files/{{id}}" class="btn btn-primary">{{.}}<i class="icon-remove icon-white"></i></a></li>'

jQuery ->
  FileDoc.bind 'refresh', ->
    FileDoc.each (d) ->
      $('#fileList').append(Mustache.render(fileTemplate, d))

  FileDoc.fetch()

  window.renderSelectedTags = ->
    $('#selected-tags .breadcrumb').html('')
    for tag in window.selectedTags
      $('#selected-tags .breadcrumb').append(Mustache.render(selectedTagTemplate, tag))


  $('#clear-tags').click (event) ->
    event.preventDefault()
    window.selectedTags = []
    renderSelectedTags()

  $('#selected-tags a').live 'click', (event) ->
    event.preventDefault()
    window.selectedTags = window.selectedTags.remove($(this).text())
    renderSelectedTags()

  $('#available-tags a').live 'click', (event) ->
  #    event.preventDefault()
      window.selectedTags.push($(this).text())
  #    fileList.tags.pop($(this).text())
      renderSelectedTags()

  $('.filerow .tags span').live 'click', (event) ->
    window.selectedTags ?= []
    window.selectedTags = window.selectedTags.concat($(this).text()) unless window.selectedTags.contains($(this).text())
    renderSelectedTags()
  #    fileList.tags.pop($(this).text())


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
