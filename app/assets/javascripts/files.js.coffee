viewModel =
  filename: ko.observable('test.png')
  name: ko.observable('test')
  tags: ko.observable([])


viewModel.test = () ->
  "Hello #{this.name()}."
viewModel.refresh = () ->
  $.ajax '/files/tags',
    type: 'get'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      alert textStatus
    success: (data) =>
      this.tags(data)


jQuery ->
  ko.applyBindings(viewModel)
  viewModel.refresh()
