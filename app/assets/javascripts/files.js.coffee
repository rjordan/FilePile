tagTemplate = '<span class="badge {{#selected}}badge-success{{/selected}}">{{.}}</span> '

$('#tags span').live 'click', ->
  $(this).toggleClass 'badge-success'
  #FileDoc.trigger 'change'

@activeTags = ->
  $(tag).text() for tag in $('#tags span.badge-success')

@selectedItems = ->
  (item.value for item in $("INPUT[type='checkbox']:checked"))

jQuery ->
  FileDoc.bind 'change', ->
    #filter FileDocs by tags
    FileDoc.each (d) ->
      $('#fileList').append(Mustache.render(fileTemplate, d))


  FileDoc.bind 'refresh', ->
    #selected = activeTags() #remember
    $('#tags').html('')
    for tag in FileDoc.allTags()
      $('#tags').append(Mustache.render(tagTemplate, tag))

    FileDoc.each (d) ->
      $('#fileList').append(Mustache.render(fileTemplate, d))

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
