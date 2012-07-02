@tagTemplate = """
  <span class="badge {{#selected}}badge-success{{/selected}}">{{id}}</span>

"""

class @Tags
  @all

  @constructor:
    @all = []

  @clear: ->
    @all = []

  @add: (value) =>
    return unless @find(value).length is 0
    tag = new Tag(value)
    @all.push(tag)
    @render()
    tag

  @setSelected: (tag) =>
    (item.selected=true for item in @all when item.id is tag)

  @toggleSelected: (tag) =>
    (item.selected=!item.selected for item in @all when item.id is tag)

  @find: (tag) =>
    (item for item in @all when item.id is tag)

  @selected: =>
    (item.id for item in @all when item.selected is true)

  @render: =>
    $('#tags').html('')
    for tag in Tags.all
      $('#tags').append(Mustache.render(tagTemplate, tag))
