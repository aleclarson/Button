
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

  type.defineValues ->

    _tap: @_createTapResponder()

  type.defineListeners do ->

    eventMap =
      didReject: "onReject"
      didGrant: "onGrant"
      didRelease: "onRelease"
      didTap: "onTap"
      didTouchStart: "onTouchStart"
      didTouchMove: "onTouchMove"
      didTouchEnd: "onTouchEnd"

    return ->
      {props, _tap} = this
      for eventKey, propKey of eventMap
        if callback = props[propKey]
          _tap[eventKey] callback
      return

  type.defineMethods

    _createTapResponder: ->
      options = parseOptions TapResponder, @props
      return TapResponder options

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

  type.defineValues (options) ->

    _icon: options.icon

    _text: options.text

    _tap: @_createTapResponder options

  type.defineStyles

    icon: null

    text: null

  type.defineMethods

    _createTapResponder: (options) ->
      options = parseOptions TapResponder, options
      return TapResponder options

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
