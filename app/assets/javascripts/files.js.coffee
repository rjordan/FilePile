class FilesList
  files: ko.observableArray([])
  updateList: =>
    $.getJSON "/files.json", (data) =>
      this.files(data)

fileList = new FilesList()

#class FileModel
#  id: ko.observable(0)
#  filename: ko.observable('(Unknown)')
#  tags: ko.observableArray([])
#  load: (id) =>
#    $.getJSON "/files/#{id}", (data) =>
#      @filename(data.file_name)
#      @tags(data.tags)
#  @find: (id) ->
#    file = new FileModel()
#    file.load(id)
#    file


selectedItems = ->
  list = []
  $("INPUT[type='checkbox']:checked").each (index, elem) ->
    list.push(elem.value)
  list


jQuery ->
  ko.applyBindings(fileList)
  fileList.updateList()

  $('#select-all').click (sender) ->
    $("INPUT[type='checkbox']").attr('checked', $(this).is(':checked'));

  $('#btn-add-tag').click (sender) ->
    alert "Klick"

  $('#btn-delete').click ->
      list = selectedItems()
      alert list.filter (val) ->
        val != 'on'
      #confirm
      $.each list, (index) ->
        $.ajax
            url: "/files/#{list[index]}"
            type: 'DELETE'
        #remove records from files

  $('#fileupload').fileupload
    dataType: 'json'
    url: '/files'
    formData: {"tags":[]}
    done: (e, data) ->
      $.each data.result, (index, file) ->
        alert "Index #{index}"
    progress: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      alert progress
