ko.extenders.selectedTagsChange = (target) ->
  target.subscribe (newvalue) ->
    fileList.updateList()
  target

class FilesList
  files: ko.observableArray([])
  tags: ko.observableArray([])
  selectedTags: ko.observableArray([]).extend({selectedTagsChange: 1})
  @resource_url: "/files"
  updateList: =>
    $.ajax
      url: @resource_url,
      dataType: 'JSON'
      data: {"tags": @selectedTags}
      success: (data) =>
        @files([]) #if page=1
        @tags([])
        for file in data
          @files.push( new FileDocument(file) )
          for tag in file.tags
            @tags.push(tag) unless tag in @tags()
  find: (id) =>
    $.grep(@files(), (item) -> item.id==id)[0]
  delete: (id) =>
    file = @find(id)
    $.ajax
        url: "#{@resource_url}/#{id}"
        type: 'DELETE'
    @files(@files.remove(file))

class FileDocument
  tags: ko.observableArray([])
  constructor: (file) ->
    @id = file._id
    @file_name = file.file_name
    @tags(file.tags)
    #for tag in file.tags
    #  @tags.push(tag)
    @file_id=file.file_id
    @file_size=file.file_size
    @location = "/files/#{@file_id}"
  addTag: (tag) =>
    $.ajax
        url: "#{@location}/tags"
        dataType: 'JSON'
        data: {"tags": tag}
        type: 'POST'
    @tags.push(tag)
  removeTag: (tag) =>
    $.ajax
        url: "#{@location}/tags"
        dataType: 'JSON'
        data: {"tags": tag}
        type: 'DELETE'
    @tags.pop(tag)
    
@selectedItems = ->
  (item.value for item in $("INPUT[type='checkbox']:checked"))

@formatFileSize = (bytes) ->
  return '' if (typeof bytes != 'number')
  return (bytes / 1000000000).toFixed(2) + ' GB' if (bytes >= 1000000000)
  return (bytes / 1000000).toFixed(2) + ' MB' if (bytes >= 1000000)
  return (bytes / 1000).toFixed(2) + ' KB' if (bytes >= 1000)
  return bytes.toFixed(2) + 'B'


@fileList = new FilesList()

jQuery ->
  ko.applyBindings(fileList)
  #$('body').trigger 'refresh'
  fileList.updateList()

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
