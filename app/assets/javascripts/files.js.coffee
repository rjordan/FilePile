class FilesList
  files: ko.observableArray([])
  tags: ko.observableArray([])
  selectedTags: ko.observableArray([])
  resource_url: "/files"
  updateList: =>
    $.ajax
      url: @resource_url,
      dataType: 'JSON'
      data: {"tags": @selectedTags}
      success: (data) => @files(data)
  find: (id) =>
    $.grep(@files(), (item) -> item._id==id)[0]
  delete: (id) =>
    file = @find(id)
    $.ajax
        url: "#{@resource_url}/#{id}"
        type: 'DELETE'
    @files(@files.remove(file))
  addTag: (id, tag) =>
    file = @find(id)
    file.tags.push(tag)
    $.ajax
        url: "#{@resource_url}/#{id}/tags"
        dataType: 'JSON'
        data: {"tags": tag}
        type: 'POST'

@fileList = new FilesList()

@selectedItems = ->
  list = []
  #list = list.filter (val) -> val==on
  $("INPUT[type='checkbox']:checked").each (index, elem) ->
    list.push(elem.value)
  list

@formatFileSize = (bytes) ->
  if (typeof bytes != 'number')
      return ''
  if (bytes >= 1000000000)
      return (bytes / 1000000000).toFixed(2) + ' GB'
  if (bytes >= 1000000)
      return (bytes / 1000000).toFixed(2) + ' MB'
  if (bytes >= 1000)
      return (bytes / 1000).toFixed(2) + ' KB'
  return bytes.toFixed(2) + 'B'

jQuery ->
  ko.applyBindings(fileList)
  fileList.updateList()

  $('#clear-tags').click ->
    fileList.selectedTags([])

  $('#available-tags a').live 'click', () ->
    fileList.tags.pop($(this).text())
    fileList.selectedTags.push($(this).text())

  $('#select-all').click (sender) ->
    $("INPUT[type='checkbox']").attr('checked', $(this).is(':checked'));

  $('#btn-add-tag').click (sender) ->
    new_tags = $('#new_tags').val()
    $('#new_tags').val('')
    new_tag_array = new_tags.split(',')
    files = selectedItems()
    for file in files
      for tag in new_tag_array
        fileList.addTag(file, tag)

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
