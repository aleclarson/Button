
{View, ImageView, TextView} = require "modx/views"
{Style} = require "modx"

ReactiveTextView = require "ReactiveTextView"

# Each instance must have these properties...
#   _tap: Tappable
#   _hold: Holdable?
#
# ...and these methods:
#   __renderIcon
#   __renderText

module.exports = (type) ->
  type.render mixin.render
  type.defineProps mixin.props
  type.defineMethods mixin.methods
  type.defineStyles mixin.styles

mixin = {}

mixin.props =
  style: Style
  hitSlop: Object

mixin.render = ->
  {touchHandlers} = @_tap.join @_hold
  return View
    children: @__renderChildren()
    hitSlop: @props.hitSlop
    mixins: [touchHandlers]
    style: [
      @styles.container()
      @props.style
    ]

mixin.methods =

  __renderChildren: -> [
    @__renderIcon()
    @__renderText()
  ]

mixin.styles =

  container: {flexDirection: "row"}
