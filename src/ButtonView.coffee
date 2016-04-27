
{ Component, Style, View, ImageView } = require "component"

ReactiveTextView = require "ReactiveTextView"
Tappable = require "tappable"
Gesture = require "gesture"

Button = require "./Button"

module.exports = Component "ButtonView",

  propTypes:
    button: Button.Kind

  customValues:

    button: get: ->
      @props.button

  initValues: ->

    gestures: Gesture.ResponderList [
      @button.tap
      @button.hold
    ]

  initListeners: ->
    @button.__attachListeners()

  render: ->

    if @button.icon?
      icon = ImageView
        source: @button.icon
        style: @button.iconStyle

    if @button.text?
      text = ReactiveTextView
        getText: @button.text.getValue
        style: @button.textStyle

    return View
      style: @button.style
      children: [ icon, text ]
      mixins: [ @gestures.touchHandlers ]
