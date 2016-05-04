
{ Component, Style, View, ImageView } = require "component"

ReactiveTextView = require "ReactiveTextView"
Tappable = require "tappable"
Gesture = require "gesture"

Button = require "./Button"

type = Component()

type.contextType = Button

type.defineProperties

  button: get: ->
    @props.button

type.defineValues

  gestures: Gesture.ResponderList [
    @button.tap
    @button.hold
  ]

type.createListeners ->

  @button.__attachListeners()

type.render ->

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

module.exports = type.build()
