#class FileModel
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
#
#jQuery ->
#  ko.applyBindings(FileModel.find('4f39ff66c78e6a2fcc000016'))

jQuery ->
  $('#select-all').click (sender) ->
    $("INPUT[type='checkbox']").attr('checked', $(this).is(':checked'));

  $('#btn-add-tag').click (sender) ->
    alert "Klick"

  $('#btn-delete').click ->
      list = []
      $("INPUT[type='checkbox']:checked").each (index, elem) ->
        list.push(elem.value)
      #confirm
      alert list
      $.each list, (index) ->
        $.ajax
            url: "/files/#{list[index]}"
            type: 'DELETE'

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
