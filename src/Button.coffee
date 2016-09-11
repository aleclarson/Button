
{View, ImageView} = require "modx/views"
{NativeValue} = require "modx/native"
{Type} = require "modx"

ReactiveTextView = require "ReactiveTextView"
Holdable = require "holdable"
Tappable = require "tappable"
Gesture = require "gesture"

type = Type "Button"

type.defineOptions
  icon: Number
  text: String
  getText: Function
  maxTapCount: Number.withDefault 1
  minHoldTime: Number
  preventDistance: Number
  centerIcon: Boolean.withDefault no

type.defineValues (options) ->

  _icon: options.icon

  _centerIcon: options.centerIcon

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
    return if @_hold
    @_hold.didHold.listenable

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
    alignItems: "center"

  # Set 'options.centerIcon' to true
  # to use this as the icon style.
  centered:
    flex: 1
    alignSelf: "stretch"
    resizeMode: "center"

  icon: null

  text: null

type.render ->
  return View
    style: @styles.container()
    children: @__renderChildren()
    mixins: [ @_touchHandlers ]

type.defineHooks

  __renderIcon: ->
    source = @_icon
    return if not source
    style = []
    @styles.icon and style.push @styles.icon()
    @_centerIcon and style.push @styles.centered()
    return ImageView { source, style }

  __renderText: ->
    @_text and ReactiveTextView
      getText: => @_text.value
      style: @styles.text()

  __renderChildren: -> [
    @__renderIcon()
    @__renderText()
  ]

module.exports = type.build()
