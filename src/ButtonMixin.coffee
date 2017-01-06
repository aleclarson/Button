
View = require "modx/lib/View"

# Each instance must have these properties...
#   _tap: Tappable
#   _hold: Holdable?
#
# ...and these methods:
#   __renderIcon
#   __renderText

module.exports = (type) ->
  type.render render
  type.defineMethods methods

render = ->
  {touchHandlers} = @_tap.join @_hold
  viewProps = View.parseProps @props
  return View
    children: @__renderChildren()
    mixins: [viewProps, touchHandlers]
    style: [
      flexDirection: "row"
      @props.style
    ]

methods =

  __renderChildren: ->
    @props.children or [
      @__renderIcon()
      @__renderText()
    ]
