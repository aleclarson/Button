var Button, Component, Gesture, ImageView, ReactiveTextView, Style, Tappable, View, ref, type;

ref = require("component"), Component = ref.Component, Style = ref.Style, View = ref.View, ImageView = ref.ImageView;

ReactiveTextView = require("ReactiveTextView");

Tappable = require("tappable");

Gesture = require("gesture");

Button = require("./Button");

type = Component();

type.contextType = Button;

type.defineProperties({
  button: {
    get: function() {
      return this.props.button;
    }
  }
});

type.defineValues({
  gestures: Gesture.ResponderList([this.button.tap, this.button.hold])
});

type.createListeners(function() {
  return this.button.__attachListeners();
});

type.render(function() {
  var icon, text;
  if (this.button.icon != null) {
    icon = ImageView({
      source: this.button.icon,
      style: this.button.iconStyle
    });
  }
  if (this.button.text != null) {
    text = ReactiveTextView({
      getText: this.button.text.getValue,
      style: this.button.textStyle
    });
  }
  return View({
    style: this.button.style,
    children: [icon, text],
    mixins: [this.gestures.touchHandlers]
  });
});

module.exports = type.build();

//# sourceMappingURL=../../map/src/ButtonView.map
