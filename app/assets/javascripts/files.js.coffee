@renderAll = ->
  FileDocs.buildTagsModel()
  Tags.render()
  FileDocs.renderFilteredFiles()

$('#tags span').live 'click', ->
  Tags.toggleSelected($(this).text())
  renderAll()

@selectedItems = ->
  (item.value for item in $("INPUT[type='checkbox']:checked"))

window.fileDocs = new FileDocuments()

jQuery ->
  window.fileDocs.fetch()

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
      if confirm("Really delete #{list}")
        for item in list
          FileDoc.destroy(item)

  window.uploadTemplate = """
    <div class="upload">
      {{name}}
      <div class="progress"><div class="bar" style="width: 0%"></div></div>
    </div>
  """

  $('#fileupload').bind 'fileuploadsubmit', (e, data) ->
    data.formData = { tags: Tags.selected() }

  $('#fileupload').fileupload
    dataType: 'json'
    url: '/files'
    add: (e, data) ->
      data.context = $(Mustache.render(window.uploadTemplate, data.files[0]))
      $('#file-list').append(data.context)
      data.submit()
    done: (e, data) ->
      if data.context
        data.context.remove()
        #alert data.files[0].name
        newdoc = new FileDoc()
        newdoc.file_name = data.files[0].name
        newdoc.file_id = data.files[0].id
        newdoc.file_size = data.files[0].file_size
        newdoc.fingerprint = data.files[0].fingerprint
        newdoc.description = data.files[0].description
        newdoc.file_type = data.files[0].file_type
        newdoc.tags = data.files[0].tags
        fileDocs.add(newdoc)
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')