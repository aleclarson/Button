
{ Component, NativeValue, View, ImageView } = require "component"

ReactiveTextView = require "ReactiveTextView"
getArgProp = require "getArgProp"
Holdable = require "holdable"
Tappable = require "tappable"
Gesture = require "gesture"

type = Component.Type "Button"

type.optionTypes =
  icon: Number.Maybe
  text: String.Maybe
  getText: Function.Maybe
  maxTapCount: Number.Maybe
  minHoldTime: Number.Maybe
  preventDistance: Number.Maybe

type.optionDefaults =
  maxTapCount: 1

type.defineValues

  _icon: getArgProp "icon"

  _text: (options) ->
    value = options.getText or options.text
    return if value is undefined
    return NativeValue value

  _tap: (options) ->
    return Tappable
      maxTapCount: options.maxTapCount
      preventDistance: options.preventDistance

  _hold: (options) ->
    return if not options.minHoldTime?
    return Holdable
      minHoldTime: options.minHoldTime
      preventDistance: options.preventDistance

  _gestures: ->
    return @_tap if not @_hold
    Gesture.ResponderList [ @_tap, @_hold ]

type.definePrototype

  didTap: get: ->
    @_tap.didTap.listenable

  didHold: get: ->
    return if not @_hold
    @_hold.didHold.listenable

  didReject: get: ->
    @_tap.didReject.listenable

  didGrant: get: ->
    @_tap.didGrant.listenable

  didEnd: get: ->
    @_tap.didEnd.listenable

  didTouchStart: get: ->
    @_tap.didTouchStart.listenable

  didTouchMove: get: ->
    @_tap.didTouchMove.listenable

  didTouchEnd: get: ->
    @_tap.didTouchEnd.listenable

type.defineMethods

  __renderIcon: ->
    return if not @_icon
    return ImageView
      source: @_icon
      style: @styles.icon()

  __renderText: ->
    return if not @_text
    return ReactiveTextView
      getText: @_text.getValue
      style: @styles.text()

  __renderChildren: -> [
    @__renderIcon()
    @__renderText()
  ]

type.render ->
  return View
    style: @styles.container()
    children: @__renderChildren()
    mixins: [
      @_gestures.touchHandlers
    ]

type.defineStyles

  container: {
    flexDirection: "row"
    alignItems: "center"
  }

  icon: null

  text: null

module.exports = type.build()
