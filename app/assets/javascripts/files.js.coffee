#@renderAll = ->
#  FileDocs.buildTagsModel()
#  Tags.render()
#  FileDocs.renderFilteredFiles()

#$('#tags span').live 'click', ->
#  Tags.toggleSelected($(this).text())
#  renderAll()

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
    files = ( window.fileDocs.find(item) for item in selectedItems())
    for file in files
      for tag in new_tag_array
        file.addTag(tag)
      file.save()
    $('#new_tags').val('')

  $('#btn-delete').click ->
      list = selectedItems()
      if confirm("Really delete #{list}")
        for item in list
          window.fileDocs.delete(item)

  window.uploadTemplate = """
    <div class="upload">
      {{name}}
      <div class="progress"><div class="bar" style="width: 0%"></div></div>
    </div>
  """

  $('#fileupload').bind 'fileuploadsubmit', (e, data) ->
    data.dataType = 'json'
    data.formData = { tags: window.fileDocs.filterTags }      #TODO This is wrong but I can't seem to fix it

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
        window.fileDocs.fromUpload data.result
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
