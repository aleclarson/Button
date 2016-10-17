
{View, ImageView} = require "modx/views"
{NativeValue} = require "modx/native"
{Type, Style} = require "modx"

ReactiveTextView = require "ReactiveTextView"
Holdable = require "holdable"
Tappable = require "tappable"
Gesture = require "gesture"

type = Type "Button"

type.defineOptions
  icon: Object
  text: String
  getText: Function
  maxTapCount: Number.withDefault 1
  minHoldTime: Number
  preventDistance: Number

type.defineValues (options) ->

  icon: options.icon

type.defineValues

  _text: (options) ->
    value = options.getText or options.text
    return if value is undefined
    value = NativeValue value
    return value.__attach()

  _tap: (options) ->
    return Tappable
      maxTapCount: options.maxTapCount
      preventDistance: options.preventDistance

  _hold: (options) ->
    return if not options.minHoldTime?
    return Holdable
      minHoldTime: options.minHoldTime
      preventDistance: options.preventDistance

  _touchHandlers: ->
    return @_tap.touchHandlers if not @_hold
    responder = Gesture.ResponderList [ @_tap, @_hold ]
    return responder.touchHandlers

#
# Prototype
#

type.defineGetters

  didTap: ->
    @_tap.didTap.listenable

  didHold: ->
    if @_hold then @_hold.didHold.listenable

  didReject: ->
    @_tap.didReject.listenable

  didGrant: ->
    @_tap.didGrant.listenable

  didEnd: ->
    @_tap.didEnd.listenable

  didTouchStart: ->
    @_tap.didTouchStart.listenable

  didTouchMove: ->
    @_tap.didTouchMove.listenable

  didTouchEnd: ->
    @_tap.didTouchEnd.listenable

#
# Rendering
#

type.defineStyles

  container:
    flexDirection: "row"

  icon: null

  text: null

type.defineProps
  style: Style
  hitSlop: Object

type.render ->
  return View
    style: [ @styles.container(), @props.style ]
    children: @__renderChildren()
    hitSlop: @props.hitSlop
    mixins: [ @_touchHandlers ]

type.defineHooks

  __renderIcon: ->
    return no if not source = @icon
    @styles.icon and style = @styles.icon()
    return ImageView {source, style}

  __renderText: ->
    return no if not text = @_text
    return ReactiveTextView
      getText: -> text.value
      style: @styles.text()

  __renderChildren: -> [
    @__renderIcon()
    @__renderText()
  ]

module.exports = type.build()
