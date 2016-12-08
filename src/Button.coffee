
{View, TextView, ImageView} = require "modx/views"
{Type, Component, Style} = require "modx"

HoldResponder = require "HoldResponder"
TapResponder = require "TapResponder"

ButtonMixin = require "./ButtonMixin"

Button = do ->

  type = Component "Button"

  type.addMixin ButtonMixin

  type.defineProps
    icon: Object
    iconStyle: Style
    text: String
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
      {maxTapCount, preventDistance} = @props
      return TapResponder {maxTapCount, preventDistance}

    _hold: ->
      {minHoldTime, preventDistance} = @props
      return if minHoldTime is undefined
      return HoldResponder {minHoldTime, preventDistance}

  type.defineListeners ->
    {props} = this
    props.onReject and @_tap.didReject props.onReject
    props.onGrant and @_tap.didGrant props.onGrant
    props.onEnd and @_tap.didEnd props.onEnd
    props.onTap and @_tap.didTap props.onTap
    if @_hold
      props.onHoldStart and @_hold.didHoldStart props.onHoldStart
      props.onHoldEnd and @_hold.didHoldEnd props.onHoldEnd
    return

  type.defineMethods

    __renderIcon: ->
      {icon, iconStyle} = @props
      if icon
      then ImageView {style: iconStyle, source: icon}
      else null

    __renderText: ->
      {text, textStyle} = @props
      if text
      then TextView {style: textStyle, text}
      else null

  return type.build()

Button.Type = do ->

  type = Type "Button"

  type.addMixin ButtonMixin

  type.defineOptions
    icon: Object
    text: String
    maxTapCount: Number.withDefault 1
    minHoldTime: Number
    preventDistance: Number

  type.defineValues

    _icon: (options) ->
      return options.icon

    _text: (options) ->
      return options.text

    _tap: (options) ->
      return TapResponder
        maxTapCount: options.maxTapCount
        preventDistance: options.preventDistance

    _hold: (options) ->
      return if options.minHoldTime is undefined
      return HoldResponder
        minHoldTime: options.minHoldTime
        preventDistance: options.preventDistance

  type.defineStyles

    icon: null

    text: null

  type.defineMethods

    __renderIcon: ->
      if @_icon
      then ImageView source: @_icon, style: @styles.icon()
      else null

    __renderText: ->
      if @_text
      then TextView text: @_text, style: @styles.text()
      else null

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
