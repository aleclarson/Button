
{Responder} = require "gesture"
{Style} = require "react-validators"

mergeDefaults = require "mergeDefaults"
TapResponder = require "TapResponder"
parseOptions = require "parseOptions"
ImageView = require "modx/lib/ImageView"
TextView = require "modx/lib/TextView"
View = require "modx/lib/View"
modx = require "modx"

ButtonMixin = require "./ButtonMixin"

Button = do ->

  type = modx.Component "Button"

  type.addMixin ButtonMixin

  type.inheritProps View,
    exclude: Responder.eventNames

  type.defineProps
    icon: Object
    iconStyle: Style
    text: String
    textStyle: Style
    onTap: Function
    onReject: Function
    onGrant: Function
    onRelease: Function
    onTouchStart: Function
    onTouchMove: Function
    onTouchEnd: Function

  type.defineProps do ->
    propTypes = {}
    [TapResponder, Responder].forEach (type) ->
      mergeDefaults propTypes, type.optionTypes
    return propTypes

  type.defineValues

    _tap: ->
      options = parseOptions TapResponder, @props
      return TapResponder options

  type.defineListeners ->
    {props} = this

    if props.onReject
      @_tap.didReject props.onReject

    if props.onGrant
      @_tap.didGrant props.onGrant

    if props.onRelease
      @_tap.didRelease props.onRelease

    if props.onTap
      @_tap.didTap props.onTap

    if props.onTouchStart
      @_tap.didTouchStart props.onTouchStart

    if props.onTouchMove
      @_tap.didTouchMove props.onTouchMove

    if props.onTouchEnd
      @_tap.didTouchEnd props.onTouchEnd

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

  type = modx.Type "Button"

  type.addMixin ButtonMixin

  type.defineArgs ->
    defaults: {maxTapCount: 1}
    types:
      icon: Object
      text: String
      maxTapCount: Number
      preventDistance: Number

  type.defineValues

    _icon: (options) ->
      return options.icon

    _text: (options) ->
      return options.text

    _tap: (options) ->
      tapOptions = parseOptions TapResponder, options
      return TapResponder tapOptions

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
