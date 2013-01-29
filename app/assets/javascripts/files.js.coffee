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

  window.tagBoxItems = ->
    $('#new_tags').val().split(',').remove("")

  window.allTagItems = ->
    fileDocs.filterTags.concat(tagBoxItems())

  $('#tags span').live 'click', ->
    fileDocs.removeTagFilter($(this).text())

  $('tr.filerow span.badge').live 'click', ->
    fileDocs.addTagFilter($(this).text())

  $('#select-all').click ->
    $("INPUT[type='checkbox']").attr('checked', $(this).is(':checked'));

  $('#btn-add-tag').click ->
    files = ( window.fileDocs.find(item) for item in selectedItems())
    for file in files
      for tag in tagBoxItems()
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
    data.formData = { tags: JSON.stringify(allTagItems()) }      #TODO This is wrong but I can't seem to fix it
    console.log data.formData

  $('#fileupload').fileupload
    dataType: 'json'
    url: '/files'
    #formData: { tags: allTagItems() }
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
