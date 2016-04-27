
{ NativeValue } = require "component"

mergeDefaults = require "mergeDefaults"
Holdable = require "holdable"
Tappable = require "tappable"
Factory = require "factory"
define = require "define"
sync = require "sync"

module.exports = Factory "Button",

  optionTypes:
    icon: Number.Maybe
    text: String.Maybe
    getText: Function.Maybe
    maxTapCount: Number.Maybe
    minHoldTime: Number.Maybe
    style: Object.Maybe
    iconStyle: Object.Maybe
    textStyle: Object.Maybe

  optionDefaults:
    maxTapCount: 1

  customValues:

    render: lazy: ->
      render = @__loadComponent()
      return (props = {}) =>
        props.button = this # TODO: Convert this to a 'contextType'.
        render props

  initValues: (options) ->

    icon: options.icon

    text: null

    style: options.style ?= {}

    iconStyle: options.iconStyle ?= {}

    textStyle: options.textStyle ?= {}

  init: (options) ->

    mergeDefaults @style,
      flexDirection: "row"
      alignItems: "center"

    if options.text?
      @text = NativeValue options.text

    else if options.getText?
      @text = NativeValue options.getText

    @tap = Tappable { maxTapCount: options.maxTapCount }
    define this, "didTap", get: -> @tap.didTap.listenable

    if options.minHoldTime?
      @hold = Holdable { minHoldTime: options.minHoldTime }
      define this, "didHold", get: -> @hold.didHold.listenable

  __loadComponent: ->
    require "./ButtonView"

  __attachListeners: emptyFunction
