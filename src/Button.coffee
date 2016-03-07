
{ Shape } = require "type-utils"

Holdable = require "holdable"
Tappable = require "tappable"
Factory = require "factory"

module.exports = Factory "Button",

  optionTypes:
    icon: [ Number, Void ]
    text: [ String, Void ]
    getText: [ Function, Void ]
    maxTapCount: [ Number, Void ]
    minHoldTime: [ Number, Void ]

  optionDefaults:
    maxTapCount: 1

  customValues:

    render: lazy: ->
      render = @_getComponent()
      return (props = {}) =>
        props.button = this
        render props

  init: (options) ->

    @icon = options.icon

    if options.text?
      @text = NativeValue options.text

    else if options.getText?
      @text = NativeValue options.getText

    @tap = Tappable { maxTapCount: options.maxTapCount }
    @tap.mixin this

    if options.minHoldTime?
      @hold = Holdable { minHoldTime: options.minHoldTime }
      @hold.mixin this

  _getComponent: ->
    require "./ButtonView"
