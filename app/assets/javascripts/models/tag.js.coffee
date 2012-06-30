class @Tag extends Spine.Model
  @configure "Tag", "value", "selected"

  constructor: (@value) ->
    @selected = false

