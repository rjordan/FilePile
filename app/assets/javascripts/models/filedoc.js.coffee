class @FileDoc extends Spine.Model
  @configure "FileDoc", "file_name", "file_id", "file_size",
             "fingerprint", "description", "file_type", "tags"
  @extend Spine.Model.Ajax
  @url: "/files" 

  @filter: (tags) ->
    @select (c) ->
      tags in c.tags

  @allTags: =>
    tags = (d.tags for d in FileDoc.all()).flatten()

  addTag: (tag) =>
    @tags = @tags.concat(tag) unless tag in @tags

  removeTag: (tag) =>
    @tags = @tags.remove(tag)

#window.FileDoc = FileDoc
