
{Type, Component, Style} = require "modx"
{View, ImageView} = require "modx/views"

ReactiveTextView = require "ReactiveTextView"
Holdable = require "holdable"
Tappable = require "tappable"
Gesture = require "gesture"

ButtonMixin = require "./ButtonMixin"

Button = do ->

  type = Component "Button"

  type.addMixin ButtonMixin

  type.defineProps
    icon: Object
    iconStyle: Style
    text: String.or Function
    textStyle: Style
    maxTapCount: Number.withDefault 1
    minHoldTime: Number
    preventDistance: Number
    onTap: Function
    onHoldStart: Function
    onHoldEnd: Function
    onReject: Function
    onGrant: Function
    onEnd: Function
    onTouchStart: Function
    onTouchMove: Function
    onTouchEnd: Function

  type.defineValues

    _tap: ->
      return Tappable
        maxTapCount: @props.maxTapCount
        preventDistance: @props.preventDistance

    _hold: ->
      return if @props.minHoldTime is undefined
      return Holdable
        minHoldTime: @props.minHoldTime
        preventDistance: @props.preventDistance

  type.defineMountedListeners ->
    @props.onReject and @_tap.didReject @props.onReject
    @props.onGrant and @_tap.didGrant @props.onGrant
    @props.onEnd and @_tap.didEnd @props.onEnd
    @props.onTap and @_tap.didTap @props.onTap
    if @_hold
      @props.onHoldStart and @_hold.didHoldStart @props.onHoldStart
      @props.onHoldEnd and @_hold.didHoldEnd @props.onHoldEnd
    return

  type.defineMethods

    __renderIcon: ->
      return ImageView
        style: @props.iconStyle
        source: @props.icon

    __renderText: ->
      {text, textStyle} = @props
      if text.constructor is String
      then TextView {style: textStyle, children: text}
      else ReactiveTextView {style: textStyle, getText: text}

  return type.build()

Button.Type = do ->

  type = Type "Button"

  type.addMixin ButtonMixin

  type.defineOptions
    icon: Object
    text: String.or Function
    maxTapCount: Number.withDefault 1
    minHoldTime: Number
    preventDistance: Number

  type.defineValues

    _icon: (options) ->
      return options.icon

    _text: (options) ->
      return options.text

    _tap: (options) ->
      return Tappable
        maxTapCount: options.maxTapCount
        preventDistance: options.preventDistance

    _hold: (options) ->
      return if options.minHoldTime is undefined
      return Holdable
        minHoldTime: options.minHoldTime
        preventDistance: options.preventDistance

  type.defineStyles

    icon: null

    text: null

  type.defineMethods

    __renderIcon: ->
      return null if not @_icon
      return ImageView
        source: @_icon
        style: @styles.icon()

    __renderText: ->
      return null if not @_text
      if @_text.constructor is String
      then TextView
        style: @styles.text()
        children: @_text
      else ReactiveTextView
        style: @styles.text()
        getText: @_text

  type.defineGetters

    didTap: ->
      @_tap.didTap.listenable

    didHoldStart: ->
      if @_hold then @_hold.didHoldStart.listenable

    didHoldEnd: ->
      if @_hold then @_hold.didHoldEnd.listenable

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

  return type.build()

module.exports = Button
