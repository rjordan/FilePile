class FileModel
  filename: ko.observable('(Unknown)')
  tags: ko.observableArray([])
  load: (id) =>
    $.getJSON "/files/#{id}", (data) =>
      @filename(data.file_name)
      @tags(data.tags)
  @find: (id) ->
    file = new FileModel()
    file.load(id)
    file

jQuery ->
  ko.applyBindings(FileModel.find('4f39ff66c78e6a2fcc000016'))

