
parseOptions = require "parseOptions"
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
  type.defineMethods mixin.methods

mixin = {}

mixin.render = ->
  {touchHandlers} = @_tap.join @_hold
  viewProps = parseOptions View, @props, {key: "propTypes"}
  return View
    children: @__renderChildren()
    hitSlop: @props.hitSlop
    mixins: [viewProps, touchHandlers]
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
