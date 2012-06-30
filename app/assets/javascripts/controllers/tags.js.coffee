class @Tags extends Spine.Controller
  constructor: ->
    super
    @item.bind('update', @render)

  render: =>
    @