#ko.extenders.selectedTagsChange = (target) ->
#  target.subscribe (newvalue) ->
#    fileList.updateList()
#  target

class FilesList
  test : 1
#  @files: ko.observableArray([])
#  @tags: ko.observableArray([])
#  @selectedTags: ko.observableArray([]).extend({selectedTagsChange: 1})
#  @resource_url: "/files"
#  @updateList: =>
#    $.ajax
#      url: @resource_url,
#      dataType: 'JSON'
#      data: {"tags": @selectedTags}
#      success: (data) =>
#        @files([]) #if page=1
#        @tags([])
#        for file in data
#          @files.push( new FileDocument(file) )
#          for tag in file.tags
#            @tags.push(tag) unless tag in @tags()
#  @find: (id) =>
#    $.grep(@files(), (item) -> item.id==id)[0]
#  @delete: (id) =>
#    file = @find(id)
#    $.ajax
#        url: "#{@resource_url}/#{id}"
#        type: 'DELETE'
#    @files(@files.remove(file))

window.FileList = FileList
