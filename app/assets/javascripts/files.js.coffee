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

  $(document).on 'click', '#tags span', ->
    fileDocs.removeTagFilter($(this).text())

  $(document).on 'click', 'tr.filerow span.badge', ->
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

  $(document).on 'click', 'td.tags i.icon-remove', ->
    tag = $(this).parent('.badge').text()
    doc_id = $(this).parents('tr.filerow').data('id')
    window.fileDocs.find(doc_id).removeTag(tag)
    document.dispatchEvent(changeEvent)
    false

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
        document.dispatchEvent(changeEvent)
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
