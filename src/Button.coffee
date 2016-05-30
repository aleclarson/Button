
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

type.optionDefaults =
  maxTapCount: 1

type.defineValues

  icon: getArgProp "icon"

  text: (options) ->
    value = options.getText or options.text
    return if value is undefined
    return NativeValue value

  tap: (options) ->
    return Tappable
      maxTapCount: options.maxTapCount

  hold: (options) ->
    return if not options.minHoldTime?
    return Holdable
      minHoldTime: options.minHoldTime

  _gestures: ->
    return @tap if not @hold
    Gesture.ResponderList [ @tap, @hold ]

type.defineFrozenValues

  didTap: -> @tap.didTap.listenable

  didHold: -> @hold.didHold.listenable if @hold

type.render ->
  return View
    style: @styles.container()
    children: @__renderChildren()
    mixins: [
      @_gestures.touchHandlers
    ]

type.defineMethods

  __renderChildren: -> [
    @__renderIcon()
    @__renderText()
  ]

  __renderIcon: ->
    return if not @icon
    return ImageView
      source: @icon
      style: @styles.icon()

  __renderText: ->
    return if not @text
    return ReactiveTextView
      getText: @text.getValue
      style: @styles.text()

type.defineStyles

  container: {
    flexDirection: "row"
    alignItems: "center"
  }

  icon: {}

  text: {}

module.exports = type.build()
