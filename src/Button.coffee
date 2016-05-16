
{ Component, NativeValue } = require "component"

getArgProp = require "getArgProp"
Holdable = require "holdable"
Tappable = require "tappable"

type = Component.Type "Button"

type.loadComponent ->
  require "./ButtonView"

type.optionTypes =
  icon: Number.Maybe
  text: String.Maybe
  getText: Function.Maybe
  maxTapCount: Number.Maybe
  minHoldTime: Number.Maybe

type.optionDefaults =
  maxTapCount: 1

type.defineStyles

  container: {
    flexDirection: "row"
    alignItems: "center"
  }

  icon: {}

  text: {}

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
    return unless options.minHoldTime?
    return Holdable
      minHoldTime: options.minHoldTime

type.defineFrozenValues

  didTap: -> @tap.didTap.listenable

  didHold: -> @hold.didHold.listenable if @hold

module.exports = type.build()
