@renderAll = ->
  FileDocs.buildTagsModel()
  Tags.render()
  FileDocs.renderFilteredFiles()


$('#tags span').live 'click', ->
  Tags.toggleSelected($(this).text())
  renderAll()

@selectedItems = ->
  (item.value for item in $("INPUT[type='checkbox']:checked"))

jQuery ->
  FileDoc.bind 'change', ->
    renderAll()

  FileDoc.bind 'refresh', ->
    renderAll()

  FileDoc.fetch()

  $('#select-all').click ->
    $("INPUT[type='checkbox']").attr('checked', $(this).is(':checked'));

  $('#btn-add-tag').click ->
    new_tags = $('#new_tags').val()
    new_tag_array = new_tags.split(',')
    files = ( FileDoc.find(item) for item in selectedItems())
    for file in files
      for tag in new_tag_array
        file.addTag(tag)
        file.save()
    $('#new_tags').val('')

  $('#btn-delete').click ->
      list = selectedItems()
      alert list #confirm?
      for item in list
        FileDoc.destroy(item)

  $('#fileupload').fileupload
    dataType: 'json'
    url: '/files'
    formData: { "tags":Tags.selected() }
    done: (e, data) ->
      renderAll()
      $.each data.result, (index, file) ->
        alert "Index #{index}"

#    progress: (e, data) ->
#      progress = parseInt(data.loaded / data.total * 100, 10)
#      alert progress
