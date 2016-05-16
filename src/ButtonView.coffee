
{ Component, View, ImageView } = require "component"

ReactiveTextView = require "ReactiveTextView"
Tappable = require "tappable"
Gesture = require "gesture"

Button = require "./Button"

type = Component()

type.contextType = Button

type.render ->

  if @icon
    icon = ImageView
      source: @icon
      style: @styles.icon()

  if @text
    text = ReactiveTextView
      getText: @text.getValue
      style: @styles.text()

  gestures = Gesture.ResponderList [ @tap, @hold ]

  return View
    style: @styles.container()
    children: [ icon, text ]
    mixins: [ gestures.touchHandlers ]

module.exports = type.build()
