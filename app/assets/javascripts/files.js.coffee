@renderAll = ->
  FileDocs.buildTagsModel()
  Tags.render()
  FileDocs.renderFilteredFiles()

$('#tags span').live 'click', ->
  Tags.toggleSelected($(this).text())
  renderAll()

@selectedItems = ->
  (item.value for item in $("INPUT[type='checkbox']:checked"))

jQuery ->
  FileDoc.bind 'change', ->
    renderAll()

  FileDoc.bind 'refresh', ->
    renderAll()

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
        file.save()
    $('#new_tags').val('')

  $('#btn-delete').click ->
      list = selectedItems()
      alert list #confirm?
      for item in list
        FileDoc.destroy(item)

  @uploadTemplate = """
    {{#files}}
    <tr class="template-download fade">
      {{#error}}
        <td></td><td class="name">{{name}}</td><td class="size">{{size}}</td><td class="error" colspan="2">{{error}}</td>
      {{else}}
        <td class="preview"></td><td class="name"><a href="{{url}}">{{name}}</a></td><td class="size">{{size}}</td><td colspan="2"></td>
      {{/error}}
      <td class="delete"><button data-type="{{delete_type}}" data-url="{{delete_url}}">Delete</button><input type="checkbox" name="delete" value="1"></td>
    </tr>
    {{/files}}
  """

  $('#fileupload').bind 'fileuploadsubmit', (e, data) ->
    data.formData = { tags: Tags.selected() }

  $('#fileupload').fileupload
    dataType: 'json'
    url: '/files'
    #formData: { tags: Tags.selected() }
    done: (e, data) ->
      renderAll()
      $.each data.result, (index, file) ->
        alert "Index #{index}"
    uploadTemplateId: null
    downloadTemplateId: null
    uploadTemplate: (o) ->
      val = Mustache.render(uploadTemplate, o)
      $('.files').html(val)
      val
#      rows = $()
#      for file in o.files
#        row = $('<tr class="template-upload fade">' +
#            '<td class="preview"><span class="fade"></span></td>' +
#            '<td class="name"></td>' +
#            '<td class="size"></td>' +
#            (file.error ? '<td class="error" colspan="2"></td>' :
#                    '<td><div class="progress">' +
#                        '<div class="bar" style="width:0%;"></div></div></td>' +
#                        '<td class="start"><button>Start</button></td>'
#            ) + '<td class="cancel"><button>Cancel</button></td></tr>')
#        row.find('.name').text(file.name)
#        row.find('.size').text(o.formatFileSize(file.size))
#        if (file.error)
#          row.find('.error').text(locale.fileupload.errors[file.error] || file.error)
#        rows = rows.add(row)
#      rows
    downloadTemplate: (o) ->
      val = Mustache.render(uploadTemplate, o)
      $('.files').html(val)
      val
#      rows = $()
#      for file in o.files
#        row = $('<tr class="template-download fade">' +
#            (file.error ? '<td></td><td class="name"></td>' +
#                '<td class="size"></td><td class="error" colspan="2"></td>' :
#                    '<td class="preview"></td>' +
#                        '<td class="name"><a></a></td>' +
#                        '<td class="size"></td><td colspan="2"></td>'
#            ) + '<td class="delete"><button>Delete</button> ' +
#                '<input type="checkbox" name="delete" value="1"></td></tr>')
#        row.find('.size').text(o.formatFileSize(file.size))
#        if (file.error)
#          row.find('.name').text(file.name)
#          row.find('.error').text(locale.fileupload.errors[file.error] || file.error)
#        else
#          row.find('.name a').text(file.name)
#          if (file.thumbnail_url)
#              row.find('.preview').append('<a><img></a>').find('img').prop('src', file.thumbnail_url)
#              row.find('a').prop('rel', 'gallery')
#
#          row.find('a').prop('href', file.url)
#          row.find('.delete button')
#              .attr('data-type', file.delete_type)
#              .attr('data-url', file.delete_url)
#        rows = rows.add(row)
#      rows

#    progress: (e, data) ->
#      progress = parseInt(data.loaded / data.total * 100, 10)
#      alert progress
