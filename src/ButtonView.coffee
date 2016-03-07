
{ Component, Style, View, ImageView } = require "component"

ReactiveTextView = require "ReactiveTextView"
Tappable = require "tappable"
Gesture = require "gesture"

Button = require "./Button"

module.exports = Component "ButtonView",

  propTypes:
    button: Button.Kind
    style: Style
    iconStyle: Style
    textStyle: Style

  customValues:

    button: get: ->
      @props.button

  render: ->

    gestures = Gesture.Combinator [
      @button.tap
      @button.hold
    ]

    if @button.icon?
      icon = ImageView
        style: @props.iconStyle
        source: @button.icon

    if @button.text?
      text = ReactiveTextView
        style: @props.textStyle
        getText: => @button.text.value

    return View
      style: [ @styles.button, @props.style ]
      children: [ icon, text ]
      mixins: [ gestures.touchHandlers ]

  styles:

    button:
      flexDirection: "row"
