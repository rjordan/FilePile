class FilesList
  files: ko.observableArray([])
  tags: ko.observableArray([])
  selectedTags: ko.observableArray([])
  resource_url: "/files"
  updateList: =>
    $.getJSON @resource_url, (data) => @files(data)
  find: (id) =>
    $.grep @files(), (item) ->item._id==id
  delete: (id) =>
    file = @find(id)
    $.ajax
        url: "#{@resource_url}/#{id}"
        type: 'DELETE'
    @files(@files.remove(file))

@fileList = new FilesList()

@selectedItems = ->
  list = []
  list = list.filter (val) -> val=='on'
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

  $('#select-all').click (sender) ->
    $("INPUT[type='checkbox']").attr('checked', $(this).is(':checked'));

  $('#btn-add-tag').click (sender) ->
    alert "Klick"

  $('#btn-delete').click ->
      list = selectedItems()
      alert list
      #confirm?
      $.each list, (index) ->
        fileList.delete(list[index])

  $('#fileupload').fileupload
    dataType: 'json'
    url: '/files'
    formData: {"tags": fileList.selectedTags()}
    done: (e, data) ->
      $.each data.result, (index, file) ->
        alert "Index #{index}"
    #progress: (e, data) ->
    #  progress = parseInt(data.loaded / data.total * 100, 10)
    #  alert progress
