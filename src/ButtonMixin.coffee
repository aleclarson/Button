
{Style, Children} = require "react-validators"

View = require "modx/lib/View"

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

mixin = {}

mixin.props =
  style: Style
  hitSlop: Object
  children: Children

mixin.render = ->
  {touchHandlers} = @_tap.join @_hold
  return View
    children: @__renderChildren()
    hitSlop: @props.hitSlop
    mixins: [touchHandlers]
    style: [
      flexDirection: "row"
      @props.style
    ]

mixin.methods =

  __renderChildren: ->
    @props.children or [
      @__renderIcon()
      @__renderText()
    ]
